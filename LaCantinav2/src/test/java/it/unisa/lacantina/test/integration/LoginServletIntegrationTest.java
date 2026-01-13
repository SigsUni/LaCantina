package it.unisa.lacantina.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.UserControl.LoginServlet;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServletIntegrationTest extends SeededIntegrationBase {

    // wrapper per esporre doPost (protected) come public nel test
    static class TestableLoginServlet extends LoginServlet {
        public void doPostPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception {
            super.doPost(req, resp);
        }
    }

    private static class Capture {
        final StringWriter sw = new StringWriter();
        final PrintWriter pw = new PrintWriter(sw, true);
        String text() { return sw.toString(); }
    }

    private static void wireSessionStore(HttpSession session, Map<String,Object> store) {
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());
        doAnswer(inv -> { store.remove(inv.getArgument(0)); return null; })
                .when(session).removeAttribute(anyString());
    }

    /** ✅ FIX: mock del RequestDispatcher per evitare NPE su forward(...) */
    private static void wireDispatcher(HttpServletRequest req) throws Exception {
        RequestDispatcher rd = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher(anyString())).thenReturn(rd);
        doNothing().when(rd).forward(any(), any());
    }

    @Test
    void TF_UM_09_userOk_passwordOk() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        Capture cap = new Capture();

        when(req.getSession()).thenReturn(session);
        when(req.getContextPath()).thenReturn("/LaCantinav2");
        when(req.getParameter("email")).thenReturn("gabriele.cicalese2004@gmail.com");
        when(req.getParameter("password")).thenReturn("1234");
        when(resp.getWriter()).thenReturn(cap.pw);

        // ✅ aggiunto
        wireDispatcher(req);

        new TestableLoginServlet().doPostPublic(req, resp);

        assertTrue(store.get("auth") instanceof Utente);
        assertTrue(cap.text().contains("Login effettuato"));
        assertTrue(cap.text().contains("/index.jsp")); // meta refresh per user normale
    }

    @Test
    void TF_UM_11_adminOk_redirectAdmin() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        Capture cap = new Capture();

        when(req.getSession()).thenReturn(session);
        when(req.getContextPath()).thenReturn("/LaCantinav2");
        when(req.getParameter("email")).thenReturn("admin@lacantina.it");
        when(req.getParameter("password")).thenReturn("1234");
        when(resp.getWriter()).thenReturn(cap.pw);

        // ✅ aggiunto (non dovrebbe servire nel ramo admin, ma previene NPE se il codice cambia)
        wireDispatcher(req);

        new TestableLoginServlet().doPostPublic(req, resp);

        assertTrue(store.get("auth") instanceof Utente);
        verify(resp).sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
    }

    @Test
    void TF_UM_10_passwordErrata() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        Capture cap = new Capture();

        when(req.getSession()).thenReturn(session);
        when(req.getContextPath()).thenReturn("/LaCantinav2");
        when(req.getParameter("email")).thenReturn("gabriele.cicalese2004@gmail.com");
        when(req.getParameter("password")).thenReturn("WRONG");
        when(resp.getWriter()).thenReturn(cap.pw);

        // ✅ aggiunto
        wireDispatcher(req);

        new TestableLoginServlet().doPostPublic(req, resp);

        assertNull(store.get("auth"));
        assertTrue(cap.text().contains("Login errato"));
        assertTrue(cap.text().contains("LoginAndRegistration.jsp"));
    }
}
