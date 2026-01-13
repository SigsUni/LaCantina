package it.unisa.lacantina.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.UserControl.LoginServlet;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Tag("integration")
public class LoginServletIntegrationTest extends SeededIntegrationBase {

    static class TestableLoginServlet extends LoginServlet {
        public void doPostPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception {
            super.doPost(req, resp);
        }
    }

    private static void wireSessionStore(HttpSession session, Map<String,Object> store) {
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());
    }

    @Test
    void TF_UM_09_userOk_passwordOk_forwardSuccessMessageUser() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("email")).thenReturn("gabriele.cicalese2004@gmail.com");
        when(req.getParameter("password")).thenReturn("1234");

        RequestDispatcher rdSuccess = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/success_generico.jsp")).thenReturn(rdSuccess);
        doNothing().when(rdSuccess).forward(req, resp);

        new TestableLoginServlet().doPostPublic(req, resp);

        assertTrue(store.get("auth") instanceof Utente, "auth deve essere settato");
        verify(req).setAttribute("successMessage", "Login Effettuato con successo");
        verify(rdSuccess).forward(req, resp);
    }

    @Test
    void TF_UM_11_adminOk_forwardSuccessMessageAdmin() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("email")).thenReturn("admin@lacantina.it");
        when(req.getParameter("password")).thenReturn("1234");

        RequestDispatcher rdSuccess = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/success_generico.jsp")).thenReturn(rdSuccess);
        doNothing().when(rdSuccess).forward(req, resp);

        new TestableLoginServlet().doPostPublic(req, resp);

        assertTrue(store.get("auth") instanceof Utente, "auth deve essere settato");
        Utente u = (Utente) store.get("auth");
        assertEquals(2, u.getID(), "admin deve avere id=2 nel seed");

        verify(req).setAttribute("successMessage", "Benvenuto Admin");
        verify(rdSuccess).forward(req, resp);
    }

    @Test
    void TF_UM_10_passwordErrata_forwardErrore() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("email")).thenReturn("admin@lacantina.it");
        when(req.getParameter("password")).thenReturn("WRONG");

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableLoginServlet().doPostPublic(req, resp);

        assertNull(store.get("auth"), "auth NON deve essere settato");
        verify(req).setAttribute("errorMessage", "Credenziali Errate, riprova");
        verify(rdErr).forward(req, resp);
    }

    // ---- TC_UM_01 (email vuota/formato) + TF-UM-12 (email inesistente) ----

    @Test
    void TF_UM_01_loginEmailVuota_forwardErroreCampoObbligatorio() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getParameter("email")).thenReturn("");
        when(req.getParameter("password")).thenReturn("1234");

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableLoginServlet().doPostPublic(req, resp);

        verify(req).setAttribute(eq("errorMessage"), contains("obbligatorie"));
        verify(rdErr).forward(req, resp);
    }

    @Test
    void TF_UM_02_loginEmailFormatoNonValido_forwardErroreFormato() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getParameter("email")).thenReturn("emailNonValida.it");
        when(req.getParameter("password")).thenReturn("1234");

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableLoginServlet().doPostPublic(req, resp);

        verify(req).setAttribute(eq("errorMessage"), contains("Credenziali Errate"));
        verify(rdErr).forward(req, resp);
    }

    @Test
    void TF_UM_12_loginEmailInesistente_forwardErroreCredenziali() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getParameter("email")).thenReturn("inesistente@test.it");
        when(req.getParameter("password")).thenReturn("1234");

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableLoginServlet().doPostPublic(req, resp);

        verify(req).setAttribute("errorMessage", "Credenziali Errate, riprova");
        verify(rdErr).forward(req, resp);
    }
}
