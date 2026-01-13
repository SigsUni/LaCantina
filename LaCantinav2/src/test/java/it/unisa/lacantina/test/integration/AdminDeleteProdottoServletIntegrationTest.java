package it.unisa.lacantina.test.integration;

import static it.unisa.lacantina.test.util.TestDbConfig.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.controller.AdminOperationControl.AdminDeleteProdottoServlet;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Tag("integration")
public class AdminDeleteProdottoServletIntegrationTest extends SeededIntegrationBase {

    static class TestableAdminDeleteProdotto extends AdminDeleteProdottoServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception { super.doGet(req, resp); }
    }

    private static String statoOf(int productId) throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = c.prepareStatement("SELECT stato FROM prodotti WHERE id=?")) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getString(1); }
        }
    }

    @Test
    void TF_ADM_14_deleteProdotto_admin_disattivaProdotto() throws Exception {
        assertNotNull(statoOf(12));

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getParameter("id")).thenReturn("12");
        doNothing().when(resp).sendRedirect(anyString());

        new TestableAdminDeleteProdotto().doGetPublic(req, resp);

        assertEquals("inattivo", statoOf(12));
        verify(resp).sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
    }
}
