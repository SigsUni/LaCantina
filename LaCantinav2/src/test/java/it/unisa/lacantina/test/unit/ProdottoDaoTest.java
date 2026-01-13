package it.unisa.lacantina.test.unit;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.model.domain.Prodotto;
import it.unisa.lacantina.test.util.DbTestBase;

public class ProdottoDaoTest extends DbTestBase {

    @AfterEach
    void tearDown() throws Exception {
        rollbackAndClose();
    }

    private String statoFromDb(int id) throws Exception {
        try (PreparedStatement ps = con.prepareStatement("SELECT stato FROM prodotti WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getString(1) : null;
            }
        }
    }

    @Test
    @DisplayName("TC-CM-01 (unit/DAO): getAllProdotti ritorna lista non vuota se DB popolato")
    void getAllProdotti_nonVuota_TC_CM_01() {
        ProdottoDao dao = new ProdottoDao(con);
        assertFalse(dao.getAllProdotti().isEmpty());
    }

    @Test
    @DisplayName("TC-CM-01 (unit/DAO): getSingleProdotto ritorna il prodotto con id valido")
    void getSingleProdotto_idValido_TC_CM_01() {
        ProdottoDao dao = new ProdottoDao(con);
        Prodotto p = dao.getSingleProdotto(12);
        assertNotNull(p);
        assertEquals(12, p.getId());
        assertTrue(p.getNome().equalsIgnoreCase("olio evo 500ml"));

    }

    @Test
    @DisplayName("TF-ADM-03: setNewStock aggiorna stock con valore positivo")
    void setNewStock_aggiornaStock_TF_ADM_03() {
        ProdottoDao dao = new ProdottoDao(con);
        int id = 12;

        int oldStock = dao.getStockFromId(id);
        assertTrue(dao.setNewStock(id, oldStock + 5));
        assertEquals(oldStock + 5, dao.getStockFromId(id));
    }

    @Test
    @DisplayName("TF-ADM-07: ModifyPriceById aggiorna prezzo con valore >0")
    void modifyPriceById_updatePrezzo_TF_ADM_07() throws Exception {
        ProdottoDao dao = new ProdottoDao(con);
        int id = 12;

        assertTrue(dao.ModifyPriceById(id, 99.99f));

        try (PreparedStatement ps = con.prepareStatement("SELECT prezzo FROM prodotti WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next());
                assertEquals(99.99, rs.getDouble(1), 0.001);
            }
        }
    }

    @Test
    @DisplayName("TF-ADM-04 (parte DAO): DeleteById setta stato='inattivo'")
    void deleteById_settaInattivo_TF_ADM_04() throws Exception {
        ProdottoDao dao = new ProdottoDao(con);
        int id = 12;

        dao.DeleteById(id);

        assertEquals("inattivo", statoFromDb(id));
    }

    @Test
    @DisplayName("TF-ADM-13 (happy path): insertProduct inserisce prodotto con stato='attivo'")
    void insertProduct_inserisceProdotto_attivo_TF_ADM_13() throws Exception {
        ProdottoDao dao = new ProdottoDao(con);

        boolean ok = dao.insertProduct(
                "prodotto test",
                1,
                "vino-rosso",
                "descr test",
                5,
                12.5f,
                "img.png"
        );
        assertTrue(ok);

        try (PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM prodotti WHERE nome=? AND stato='attivo'")) {
            ps.setString(1, "prodotto test");
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next());
                assertEquals(1, rs.getInt(1));
            }
        }
    }
}
