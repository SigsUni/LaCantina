package it.unisa.lacantina.test.unit;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.model.dao.FornitoreDao;
import it.unisa.lacantina.test.util.DbTestBase;

public class FornitoreDaoTest extends DbTestBase {

    @AfterEach
    void tearDown() throws Exception {
        rollbackAndClose();
    }

    @Test
    @DisplayName("getAllFornitori: ritorna lista fornitori")
    void getAllFornitori() {
        FornitoreDao dao = new FornitoreDao(con);
        assertFalse(dao.getAllFornitori().isEmpty());
    }

    @Test
    @DisplayName("getNomeById: ritorna nome fornitore")
    void getNomeById() {
        FornitoreDao dao = new FornitoreDao(con);
        assertEquals("LemonGroup", dao.getNomeById(1));
    }
}
