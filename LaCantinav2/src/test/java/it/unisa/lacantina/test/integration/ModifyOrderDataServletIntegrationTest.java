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
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.OrderControl.ModifyOrderDataServlet;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Tag("integration")
public class ModifyOrderDataServletIntegrationTest extends SeededIntegrationBase {

    static class TestableModifyOrderDataServlet extends ModifyOrderDataServlet {
        public void doPostPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception { super.doPost(req, resp); }
    }

    private static Map<String,Object> sessionStore(HttpSession session) {
        Map<String,Object> store = new HashMap<>();
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());
        return store;
    }

    private static String statoOrdineOf(int rigaId) throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = c.prepareStatement("SELECT stato_ordine FROM riga_ordini WHERE id=?")) {
            ps.setInt(1, rigaId);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getString(1); }
        }
    }

    @Test
    void TF_ADM_17_admin_modificaStatoOrdine_ok() throws Exception {
        String before = statoOrdineOf(1);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = sessionStore(session);
        store.put("auth", new Utente(2, "admin", "admin@lacantina.it", "1234"));

        when(req.getSession()).thenReturn(session);
        when(resp.getWriter()).thenReturn(new PrintWriter(new StringWriter(), true));
        doNothing().when(resp).sendRedirect(anyString());

        when(req.getParameter("insert-indirizzo")).thenReturn("via nuova");
        when(req.getParameter("insert-provincia")).thenReturn("NA");
        when(req.getParameter("insert-cap")).thenReturn("80000");
        when(req.getParameter("insert-citta")).thenReturn("Napoli");
        when(req.getParameter("stato_ordine")).thenReturn("preso in carico");
        when(req.getParameter("insert-id")).thenReturn("1");

        new TestableModifyOrderDataServlet().doPostPublic(req, resp);

        assertNotEquals(before, statoOrdineOf(1));
        assertEquals("preso in carico", statoOrdineOf(1));
    }
}
