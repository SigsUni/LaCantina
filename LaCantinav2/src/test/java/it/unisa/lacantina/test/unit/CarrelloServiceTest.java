package it.unisa.lacantina.test.unit;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.model.domain.Carrello;
import it.unisa.lacantina.model.domain.Prodotto;
import it.unisa.lacantina.model.service.CarrelloService;

public class CarrelloServiceTest {

    @Test
    @DisplayName("TF-OM-01/02 (parziale): totale = somma(prezzo * qty) su carrello")
    void getTotalCartPrice_calcolaSommaCorretta_TF_OM_totale() {
        Prodotto p1 = new Prodotto();
        p1.setPrezzo(10f);

        Prodotto p2 = new Prodotto();
        p2.setPrezzo(8f);

        Carrello c1 = new Carrello();
        c1.setProdotto(p1);
        c1.setQuantity(2); // 20

        Carrello c2 = new Carrello();
        c2.setProdotto(p2);
        c2.setQuantity(3); // 24

        ArrayList<Carrello> list = new ArrayList<>();
        list.add(c1);
        list.add(c2);

        CarrelloService s = new CarrelloService();
        assertEquals(44f, s.getTotalCartPrice(list), 0.0001);
    }
}
