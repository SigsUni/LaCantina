package it.unisa.lacantina.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.CarrelloControl.AddToCartServlet;
import it.unisa.lacantina.controller.CarrelloControl.QuantityIncDecServlet;
import it.unisa.lacantina.controller.CarrelloControl.RemoveFromCartServlet;
import it.unisa.lacantina.model.domain.Carrello;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import it.unisa.lacantina.test.util.*;

public class CarrelloServletIntegrationTest extends SeededIntegrationBase {

    static class TestableAddToCartServlet extends AddToCartServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception {
            super.doGet(req, resp);
        }
    }

    static class TestableQuantityIncDecServlet extends QuantityIncDecServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception {
            super.doGet(req, resp);
        }
    }

    static class TestableRemoveFromCartServlet extends RemoveFromCartServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception {
            super.doGet(req, resp);
        }
    }

    private static Map<String, Object> sessionStore(HttpSession session) {
        Map<String, Object> store = new HashMap<>();
        when(session.getAttribute(anyString())).thenAnswer(inv -> store.get(inv.getArgument(0)));
        doAnswer(inv -> {
            store.put(inv.getArgument(0), inv.getArgument(1));
            return null;
        }).when(session).setAttribute(anyString(), any());
        return store;
    }

    @SuppressWarnings("unchecked")
    private static ArrayList<Carrello> cartList(Map<String, Object> store) {
        return (ArrayList<Carrello>) store.get("cart-list");
    }

    @Test
    void TF_OM_01_addCarrelloVuoto_creaRigaQty1() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String, Object> store = sessionStore(session);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("id")).thenReturn("12"); 
        doNothing().when(resp).sendRedirect(anyString());

        new TestableAddToCartServlet().doGetPublic(req, resp);

        ArrayList<Carrello> list = cartList(store);
        assertNotNull(list);
        assertEquals(1, list.size());
        assertEquals(12, list.get(0).getProdotto().getId());
        assertEquals(1, list.get(0).getQuantity());

        verify(resp).sendRedirect("shop.jsp");
    }

    @Test
    void TF_OM_02_addStessoProdotto_incrementaQty() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String, Object> store = sessionStore(session);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("id")).thenReturn("12");
        doNothing().when(resp).sendRedirect(anyString());

        TestableAddToCartServlet servlet = new TestableAddToCartServlet();
        servlet.doGetPublic(req, resp); 
        servlet.doGetPublic(req, resp); 

        ArrayList<Carrello> list = cartList(store);
        assertNotNull(list);
        assertEquals(1, list.size());
        assertEquals(2, list.get(0).getQuantity());
    }

    @Test
    void TF_OM_04_dec_qtyMaggiore1_decrementa() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String, Object> store = sessionStore(session);

        // pre-carico carrello con qty=2
        ArrayList<Carrello> list = new ArrayList<>();
        Carrello c = new Carrello();
        c.getProdotto().setId(12);
        c.setQuantity(2);
        list.add(c);
        store.put("cart-list", list);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("action")).thenReturn("dec");
        when(req.getParameter("id")).thenReturn("12");
        doNothing().when(resp).sendRedirect(anyString());

        new TestableQuantityIncDecServlet().doGetPublic(req, resp);

        assertEquals(1, list.get(0).getQuantity());
        verify(resp).sendRedirect("carrello.jsp");
    }

    @Test
    void TF_OM_03_remove_rimuoveRiga() throws Exception {
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        Map<String, Object> store = sessionStore(session);

        ArrayList<Carrello> list = new ArrayList<>();
        Carrello c = new Carrello();
        c.getProdotto().setId(12);
        c.setQuantity(1);
        list.add(c);
        store.put("cart-list", list);

        when(req.getSession()).thenReturn(session);
        when(req.getParameter("id")).thenReturn("12");
        doNothing().when(resp).sendRedirect(anyString());

        when(req.getContextPath()).thenReturn("/LaCantinav2");
        when(resp.getWriter()).thenReturn(new java.io.PrintWriter(new java.io.StringWriter()));

        new TestableRemoveFromCartServlet().doGetPublic(req, resp);

        assertEquals(0, list.size());
        verify(resp).sendRedirect("carrello.jsp");
    }

}

    
