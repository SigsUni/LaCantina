package it.unisa.lacantina.test.integration;

import static it.unisa.lacantina.test.util.TestDbConfig.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.OrderControl.CheckOutServlet;
import it.unisa.lacantina.model.domain.Carrello;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Tag("integration")
public class CheckoutServletIntegrationTest extends SeededIntegrationBase {

    // ✅ wrapper per esporre doGet (protected) come public
    static class TestableCheckOutServlet extends CheckOutServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception {
            super.doGet(req, resp);
        }
    }

    private static class Capture {
        final StringWriter sw = new StringWriter();
        final PrintWriter pw = new PrintWriter(sw, true);
    }

    private static Map<String,Object> sessionStore(HttpSession session) {
        Map<String,Object> store = new HashMap<>();
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());
        return store;
    }

    private static int countRows(String table) throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = c.prepareStatement("SELECT COUNT(*) FROM " + table);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private static int stockOf(int productId) throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = c.prepareStatement("SELECT stock FROM prodotti WHERE id=?")) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1);
            }
        }
    }

    @Test
    void TF_OM_08_nonAutenticato_redirectLogin_carrelloPreservato() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = sessionStore(session);

        ArrayList<Carrello> cart = new ArrayList<>();
        Carrello item = new Carrello();
        item.getProdotto().setId(12);
        item.getProdotto().setPrezzo(11f);
        item.setQuantity(1);
        cart.add(item);
        store.put("cart-list", cart);

        Capture cap = new Capture();

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("insert-indirizzo")).thenReturn("via test");
        when(req.getParameter("insert-provincia")).thenReturn("SA");
        when(req.getParameter("insert-cap")).thenReturn("84016");
        when(req.getParameter("insert-citta")).thenReturn("Nocera");
        when(resp.getWriter()).thenReturn(cap.pw);

        new TestableCheckOutServlet().doGetPublic(req, resp);

        verify(resp, atLeastOnce()).sendRedirect("LoginAndRegistration.jsp");
        assertEquals(1, cart.size(), "carrello deve restare (preservato)");
    }

    @Test
    void TF_OM_10_autenticato_formValido_creaOrdine_decrementaStock_svuotaCarrello_redirectOrdini() throws Exception {
        int beforeOrdini = countRows("ordini");
        int beforeRighe = countRows("riga_ordini");
        int beforeStock = stockOf(12);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = sessionStore(session);

        Utente u = new Utente(1, "gabriele", "gabriele.cicalese2004@gmail.com", "1234");
        store.put("auth", u);

        ArrayList<Carrello> cart = new ArrayList<>();
        Carrello item = new Carrello();
        item.getProdotto().setId(12);
        item.getProdotto().setPrezzo(11f);
        item.setQuantity(2);
        cart.add(item);
        store.put("cart-list", cart);

        Capture cap = new Capture();

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("insert-indirizzo")).thenReturn("via test");
        when(req.getParameter("insert-provincia")).thenReturn("SA");
        when(req.getParameter("insert-cap")).thenReturn("84016");
        when(req.getParameter("insert-citta")).thenReturn("Nocera");
        when(resp.getWriter()).thenReturn(cap.pw);
        doNothing().when(resp).sendRedirect(anyString());

        new TestableCheckOutServlet().doGetPublic(req, resp);

        verify(resp).sendRedirect("ordini.jsp");
        assertEquals(0, cart.size(), "carrello deve essere svuotato");

        int afterOrdini = countRows("ordini");
        int afterRighe = countRows("riga_ordini");
        int afterStock = stockOf(12);

        assertTrue(afterRighe > beforeRighe, "deve essere creata una riga ordine");
        assertTrue(afterOrdini > beforeOrdini, "devono essere creati ordini");
        assertEquals(beforeStock - 2, afterStock, "stock decrementato della quantità acquistata");
    }
}
