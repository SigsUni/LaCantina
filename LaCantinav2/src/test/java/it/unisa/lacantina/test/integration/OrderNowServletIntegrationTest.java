package it.unisa.lacantina.test.integration;

import static it.unisa.lacantina.test.util.TestDbConfig.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.OrderControl.OrderNowServlet;
import it.unisa.lacantina.model.domain.Carrello;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Tag("integration")
public class OrderNowServletIntegrationTest extends SeededIntegrationBase {

    static class TestableOrderNowServlet extends OrderNowServlet {
        public void doPostPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception {
            super.doPost(req, resp);
        }
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
    void TF_OM_05_nonAutenticato_redirectLogin_noInsert() throws Exception {
        int beforeOrdini = countRows("ordini");
        int beforeRighe = countRows("riga_ordini");

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getSession(false)).thenReturn(null);
        doNothing().when(resp).sendRedirect(anyString());

        new TestableOrderNowServlet().doPostPublic(req, resp);

        verify(resp).sendRedirect("LoginAndRegistration.jsp");
        assertEquals(beforeOrdini, countRows("ordini"));
        assertEquals(beforeRighe, countRows("riga_ordini"));
    }

    @Test
    void TF_OM_06_auth_formNonValido_forwardErrore_noInsert() throws Exception {
        int beforeOrdini = countRows("ordini");
        int beforeRighe = countRows("riga_ordini");

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = sessionStore(session);
        store.put("auth", new Utente(1, "user", "gabriele.cicalese2004@gmail.com", "1234"));

        when(req.getSession(false)).thenReturn(session);
        when(req.getParameter("insert-id")).thenReturn("12");
        when(req.getParameter("insert-quantity")).thenReturn("0"); // NON valido
        when(req.getParameter("insert-indirizzo")).thenReturn("via test");
        when(req.getParameter("insert-cap")).thenReturn("84016");
        when(req.getParameter("insert-citta")).thenReturn("Nocera");
        when(req.getParameter("insert-provincia")).thenReturn("SA");

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableOrderNowServlet().doPostPublic(req, resp);

        verify(rdErr).forward(req, resp);
        assertEquals(beforeOrdini, countRows("ordini"));
        assertEquals(beforeRighe, countRows("riga_ordini"));
    }

    @Test
    void TF_OM_07_auth_formValido_creaOrdine_decrementaStock_redirectOrdini_rimuoveDalCarrello() throws Exception {
        int beforeOrdini = countRows("ordini");
        int beforeRighe = countRows("riga_ordini");
        int beforeStock = stockOf(12);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = sessionStore(session);
        store.put("auth", new Utente(1, "user", "gabriele.cicalese2004@gmail.com", "1234"));

        ArrayList<Carrello> cart = new ArrayList<>();
        Carrello c = new Carrello();
        c.getProdotto().setId(12);
        c.setQuantity(1);
        cart.add(c);
        store.put("cart-list", cart);

        when(req.getSession(false)).thenReturn(session);
        when(req.getParameter("insert-id")).thenReturn("12");
        when(req.getParameter("insert-quantity")).thenReturn("1");
        when(req.getParameter("insert-indirizzo")).thenReturn("via test");
        when(req.getParameter("insert-cap")).thenReturn("84016");
        when(req.getParameter("insert-citta")).thenReturn("Nocera");
        when(req.getParameter("insert-provincia")).thenReturn("SA");

        doNothing().when(resp).sendRedirect(anyString());

        new TestableOrderNowServlet().doPostPublic(req, resp);

        verify(resp).sendRedirect("ordini.jsp");
        assertTrue(countRows("ordini") > beforeOrdini);
        assertTrue(countRows("riga_ordini") > beforeRighe);
        assertEquals(beforeStock - 1, stockOf(12));

        assertTrue(cart.isEmpty(), "dopo ordine diretto il prodotto va rimosso dal carrello");
    }
}
