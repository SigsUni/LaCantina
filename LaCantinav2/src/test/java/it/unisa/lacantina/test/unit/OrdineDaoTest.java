package it.unisa.lacantina.test.unit;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.model.dao.OrdineDao;
import it.unisa.lacantina.model.domain.Ordine;
import it.unisa.lacantina.test.util.DbTestBase;

public class OrdineDaoTest extends DbTestBase {

    @AfterEach
    void tearDown() throws Exception {
        rollbackAndClose();
    }

    @Test
    @DisplayName("insertOrder: inserisce ordine valido e valorizza model.prodotto")
    void insertOrder_inserisceOrdine() {
        OrdineDao dao = new OrdineDao(con);

        Ordine o = new Ordine();
        o.setId_prodotto(12);
        o.setId_utente(1);
        o.setQuantity(2);
        o.setPrezzoAcquisto(22f);
        o.setData("12/01/2026");
        o.setIdRigaOrdine(1);

        assertTrue(dao.insertOrder(o));
        assertNotNull(o.getProdotto());
        assertEquals(12, o.getProdotto().getId());
    }

    @Test
    @DisplayName("userOrders: ritorna ordini dell'utente")
    void userOrders_ritornaLista() {
        OrdineDao dao = new OrdineDao(con);
        assertFalse(dao.userOrders(1).isEmpty());
    }
}
