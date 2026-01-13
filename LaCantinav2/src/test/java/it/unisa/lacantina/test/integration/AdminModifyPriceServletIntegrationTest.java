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

import it.unisa.lacantina.controller.AdminOperationControl.AdminModifyPriceProdotto;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Tag("integration")
public class AdminModifyPriceServletIntegrationTest extends SeededIntegrationBase {

    static class TestableAdminModifyPrice extends AdminModifyPriceProdotto {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception { super.doGet(req, resp); }
    }

    private static double prezzoOf(int productId) throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = c.prepareStatement("SELECT prezzo FROM prodotti WHERE id=?")) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getDouble(1); }
        }
    }

    @Test
    void TF_ADM_07_modifyPrice_prezzoPositivo_aggiorna() throws Exception {
        double before = prezzoOf(12);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getParameter("id")).thenReturn("12");
        when(req.getParameter("nuovo_prezzo")).thenReturn("99.99");
        doNothing().when(resp).sendRedirect(anyString());

        new TestableAdminModifyPrice().doGetPublic(req, resp);

        assertNotEquals(before, prezzoOf(12));
        assertEquals(99.99, prezzoOf(12), 0.001);
        verify(resp).sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
    }

    // TF_ADM_06 (<=0) e controlli ruolo richiedono validazione nella servlet:
    // se vuoi renderli automatici, vedi sezione "Cosa aggiungere nelle servlet" in fondo.
}
