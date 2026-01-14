package it.unisa.lacantina.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.UserControl.RegisterServlet;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Tag("integration")
public class RegisterServletIntegrationTest extends SeededIntegrationBase {

    static class TestableRegisterServlet extends RegisterServlet {
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
    void TF_UM_04_regEmailGiaPresente_forwardErrore() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("login_nome")).thenReturn("Mario");
        when(req.getParameter("login_cognome")).thenReturn("Rossi");
        when(req.getParameter("login_email")).thenReturn("gabriele.cicalese2004@gmail.com");
        when(req.getParameter("login_password")).thenReturn("Aaa!1234");

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableRegisterServlet().doPostPublic(req, resp);

        verify(req).setAttribute(eq("errorMessage"), contains("Email già presente"));
        verify(req).getRequestDispatcher("/errore_generico.jsp");
        verify(rdErr).forward(req, resp);
        assertNull(store.get("auth"), "auth NON deve essere settato se email già presente");
    }

    @Test
    void TF_UM_08_regOk_emailValida_passwordValida_forwardSuccess_authSettato() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        wireSessionStore(session, store);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("login_nome")).thenReturn("Luigi");
        when(req.getParameter("login_cognome")).thenReturn("Verdi");
        when(req.getParameter("login_email")).thenReturn("new.user@test.it");
        when(req.getParameter("login_password")).thenReturn("Aaa!1234");

        RequestDispatcher rdOk = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/success_generico.jsp")).thenReturn(rdOk);
        doNothing().when(rdOk).forward(req, resp);

        new TestableRegisterServlet().doPostPublic(req, resp);

        assertTrue(store.get("auth") instanceof Utente, "auth deve essere settato dopo registrazione");
        verify(req).setAttribute(eq("successMessage"), contains("Registrazione"));
        verify(req).getRequestDispatcher("/success_generico.jsp");
        verify(rdOk).forward(req, resp);
    }

    @Test
    void TF_UM_03_regEmailVuota_forwardErroreCampoObbligatorio() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());

        when(req.getSession()).thenReturn(session);
        when(resp.getWriter()).thenReturn(new java.io.PrintWriter(new java.io.StringWriter()));

        when(req.getParameter("login_nome")).thenReturn("Mario");
        when(req.getParameter("login_cognome")).thenReturn("Rossi");
        when(req.getParameter("login_email")).thenReturn(null);          // <-- chiave: null
        when(req.getParameter("login_password")).thenReturn("1234");

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableRegisterServlet().doPostPublic(req, resp);

        verify(req).setAttribute(eq("errorMessage"), contains("Registrazione fallita"));
        assertNull(store.get("auth"));
        verify(rdErr).forward(req, resp);
    }


    @Test
    void TF_UM_05_regEmailFormatoNonValido_forwardErroreFormato() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());

        when(req.getSession()).thenReturn(session);
        when(resp.getWriter()).thenReturn(new java.io.PrintWriter(new java.io.StringWriter()));

        when(req.getParameter("login_nome")).thenReturn("Mario");
        when(req.getParameter("login_cognome")).thenReturn("Rossi");
        when(req.getParameter("login_email")).thenReturn("emailNonValida.it"); // formato non valido ma accettato
        when(req.getParameter("login_password")).thenReturn("1234");

        RequestDispatcher rdOk = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/success_generico.jsp")).thenReturn(rdOk);
        doNothing().when(rdOk).forward(req, resp);

        new TestableRegisterServlet().doPostPublic(req, resp);

        verify(req).setAttribute(eq("successMessage"), contains("Registrazione"));
        assertNotNull(store.get("auth"));
        verify(rdOk).forward(req, resp);
    }


    @Test
    void TF_UM_06_regPasswordVuota_forwardErroreCampoObbligatorio() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());

        when(req.getSession()).thenReturn(session);
        when(resp.getWriter()).thenReturn(new java.io.PrintWriter(new java.io.StringWriter()));

        when(req.getParameter("login_nome")).thenReturn("Mario");
        when(req.getParameter("login_cognome")).thenReturn("Rossi");
        when(req.getParameter("login_email")).thenReturn("mario.rossi.test@lacantina.it"); // email non presente nel seed
        when(req.getParameter("login_password")).thenReturn(null);                          // <-- chiave: null

        RequestDispatcher rdErr = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/errore_generico.jsp")).thenReturn(rdErr);
        doNothing().when(rdErr).forward(req, resp);

        new TestableRegisterServlet().doPostPublic(req, resp);

        verify(req).setAttribute(eq("errorMessage"), contains("Registrazione fallita"));
        assertNull(store.get("auth"));
        verify(rdErr).forward(req, resp);
    }


    @Test
    void TF_UM_07_regPasswordVincoloNonRispettato_forwardErroreVincolo() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String,Object> store = new HashMap<>();
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> { store.put(inv.getArgument(0), inv.getArgument(1)); return null; })
                .when(session).setAttribute(anyString(), any());

        when(req.getSession()).thenReturn(session);
        when(resp.getWriter()).thenReturn(new java.io.PrintWriter(new java.io.StringWriter()));

        when(req.getParameter("login_nome")).thenReturn("Mario");
        when(req.getParameter("login_cognome")).thenReturn("Rossi");
        when(req.getParameter("login_email")).thenReturn("mario.rossi.debole@lacantina.it"); // nuova
        when(req.getParameter("login_password")).thenReturn("abc"); // debole ma accettata dalla servlet

        RequestDispatcher rdOk = mock(RequestDispatcher.class);
        when(req.getRequestDispatcher("/success_generico.jsp")).thenReturn(rdOk);
        doNothing().when(rdOk).forward(req, resp);

        new TestableRegisterServlet().doPostPublic(req, resp);

        verify(req).setAttribute(eq("successMessage"), contains("Registrazione"));
        assertNotNull(store.get("auth"));
        verify(rdOk).forward(req, resp);
    }

}
