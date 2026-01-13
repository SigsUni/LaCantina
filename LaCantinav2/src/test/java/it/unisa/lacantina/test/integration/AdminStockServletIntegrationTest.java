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

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.AdminOperationControl.AdminAddStockServlet;
import it.unisa.lacantina.controller.AdminOperationControl.AdminRemoveStockServlet;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Tag("integration")
public class AdminStockServletIntegrationTest extends SeededIntegrationBase {

    static class TestableAdminAddStockServlet extends AdminAddStockServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception { super.doGet(req, resp); }
    }
    static class TestableAdminRemoveStockServlet extends AdminRemoveStockServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception { super.doGet(req, resp); }
    }

    private static int stockOf(int productId) throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = c.prepareStatement("SELECT stock FROM prodotti WHERE id=?")) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
        }
    }

    private static void stubWriter(HttpServletResponse resp) throws Exception {
        when(resp.getWriter()).thenReturn(new PrintWriter(new StringWriter(), true));
    }

    @Test
    void TF_ADM_03_addStockPositivo_aggiornaStock_redirectAdmin() throws Exception {
        int before = stockOf(12);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        stubWriter(resp);

        when(req.getParameter("id")).thenReturn("12");
        when(req.getParameter("stock_add")).thenReturn("5");
        doNothing().when(resp).sendRedirect(anyString());

        new TestableAdminAddStockServlet().doGetPublic(req, resp);

        assertEquals(before + 5, stockOf(12));
        verify(resp).sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
    }

    @Test
    void TF_ADM_02_removeStock_portaAZero_ok() throws Exception {
        int before = stockOf(12);
        assertTrue(before >= 1, "nel seed il prodotto 12 deve avere stock>0 per questo test");

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        stubWriter(resp);

        when(req.getParameter("id")).thenReturn("12");
        when(req.getParameter("stock_remove")).thenReturn(String.valueOf(before));
        doNothing().when(resp).sendRedirect(anyString());

        new TestableAdminRemoveStockServlet().doGetPublic(req, resp);

        assertEquals(0, stockOf(12));
        verify(resp).sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
    }

    @Test
    void TF_ADM_01_removeStock_troppo_nonAggiorna() throws Exception {
        int before = stockOf(12);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        stubWriter(resp);

        when(req.getParameter("id")).thenReturn("12");
        when(req.getParameter("stock_remove")).thenReturn(String.valueOf(before + 1));
        doNothing().when(resp).sendRedirect(anyString());

        new TestableAdminRemoveStockServlet().doGetPublic(req, resp);

        assertEquals(before, stockOf(12), "se diventerebbe negativo, NON deve aggiornare");
        verify(resp).sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
    }
}
