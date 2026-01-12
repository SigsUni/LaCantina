package it.unisa.lacantina.test.unit;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.model.dao.RigaOrdineDao;
import it.unisa.lacantina.model.domain.RigaOrdine;
import it.unisa.lacantina.test.util.DbTestBase;

public class RigaOrdineDaoTest extends DbTestBase {

    @AfterEach
    void tearDown() throws Exception {
        rollbackAndClose();
    }

    @Test
    @DisplayName("TF-OM-07 (parte DB): nuovaRigaOrdine crea riga con stato 'attesa di conferma'")
    void nuovaRigaOrdine_creaRiga_TF_OM_07_parziale() {
        RigaOrdineDao dao = new RigaOrdineDao(con);

        int newId = dao.nuovaRigaOrdine("via x", "84016", "Nocera", "Salerno", 100f, 2);
        assertTrue(newId > 0);

        RigaOrdine r = dao.getInfoById(newId);
        assertNotNull(r);
        assertEquals("attesa di conferma", r.getStatoOrdine());
        assertEquals("via x", r.getIndirizzo());
        assertEquals("84016", r.getCap());
    }

    @Test
    @DisplayName("TF-OM-??: UpdateData aggiorna indirizzo/provincia/cap/citta/stato")
    void updateData_aggiornaCampi() {
        RigaOrdineDao dao = new RigaOrdineDao(con);

        boolean ok = dao.UpdateData(1, "via nuova", "NA", "80000", "Napoli", "preso in carico");
        assertTrue(ok);

        RigaOrdine r = dao.getInfoById(1);
        assertEquals("via nuova", r.getIndirizzo());
        assertEquals("NA", r.getProvincia());
        assertEquals("80000", r.getCap());
        assertEquals("Napoli", r.getCitta());
        assertEquals("preso in carico", r.getStatoOrdine());
    }
}
