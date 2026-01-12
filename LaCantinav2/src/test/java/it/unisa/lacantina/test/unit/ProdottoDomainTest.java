package it.unisa.lacantina.test.unit;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.model.domain.Prodotto;

public class ProdottoDomainTest {

    @Test
    @DisplayName("checkStock: true se stock>=qty")
    void checkStock_trueSeSufficiente() {
        Prodotto p = new Prodotto();
        p.setStock(5);
        assertTrue(p.checkStock(5));
        assertTrue(p.checkStock(1));
        assertFalse(p.checkStock(6));
    }

    @Test
    @DisplayName("checkSingleStock: true se stock>0")
    void checkSingleStock() {
        Prodotto p = new Prodotto();
        p.setStock(1);
        assertTrue(p.checkSingleStock());
        p.setStock(0);
        assertFalse(p.checkSingleStock());
    }

    @Test
    @DisplayName("checkActive: true se stato=attivo")
    void checkActive() {
        Prodotto p = new Prodotto();
        p.setStato("attivo");
        assertTrue(p.checkActive());
        p.setStato("inattivo");
        assertFalse(p.checkActive());
    }
}
