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

import it.unisa.lacantina.controller.AdminOperationControl.AdminInsertNewProductServlet;
import it.unisa.lacantina.test.util.SeededIntegrationBase;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Tag("integration")
public class AdminInsertNewProductServletIntegrationTest extends SeededIntegrationBase {

    static class TestableAdminInsertProduct extends AdminInsertNewProductServlet {
        public void doGetPublic(HttpServletRequest req, HttpServletResponse resp) throws Exception { super.doGet(req, resp); }
    }

    private static int countByName(String nome) throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = c.prepareStatement("SELECT COUNT(*) FROM prodotti WHERE nome=?")) {
            ps.setString(1, nome);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
        }
    }

    @Test
    void TF_ADM_13_insertProduct_valido_inserisce_redirectAdmin() throws Exception {
        String nome = "prodotto junit servlet";
        int before = countByName(nome);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        when(resp.getWriter()).thenReturn(new PrintWriter(new StringWriter(), true));

        when(req.getParameter("insert-nome")).thenReturn(nome);
        when(req.getParameter("insert-categoria")).thenReturn("vino-rosso");
        when(req.getParameter("insert-descrizione")).thenReturn("descr test");
        when(req.getParameter("insert-stock")).thenReturn("10");
        when(req.getParameter("insert-immagine")).thenReturn("img.png");
        when(req.getParameter("insert-prezzo")).thenReturn("12.50");
        when(req.getParameter("fornitore_id")).thenReturn("1");

        doNothing().when(resp).sendRedirect(anyString());

        new TestableAdminInsertProduct().doGetPublic(req, resp);

        assertEquals(before + 1, countByName(nome));
        verify(resp).sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
    }

}
