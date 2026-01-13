package it.unisa.lacantina.test.unit;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.model.domain.Prodotto;
import it.unisa.lacantina.test.util.DbTestBase;

public class CatalogCategoryPartitionTest extends DbTestBase {

    @AfterEach
    void tearDown() throws Exception {
        rollbackAndClose();
    }

    private static List<Prodotto> filterByCategoria(List<Prodotto> all, String categoria) {
        if (categoria == null || categoria.isBlank()) return all;
        String cat = categoria.trim().toLowerCase();
        return all.stream()
                .filter(p -> p.getCategoria() != null && p.getCategoria().trim().equalsIgnoreCase(cat))
                .collect(Collectors.toList());
    }

    @Test
    @DisplayName("TC_CM_02 / TF-CM-04: categoria valida con prodotti -> lista filtrata non vuota e coerente")
    void TF_CM_04_categoriaValida_conProdotti() {
        ProdottoDao dao = new ProdottoDao(con);
        List<Prodotto> all = dao.getAllProdotti();
        assertFalse(all.isEmpty());

        String existingCat = all.stream()
                .map(Prodotto::getCategoria)
                .filter(Objects::nonNull)
                .findFirst()
                .orElseThrow();

        List<Prodotto> filtered = filterByCategoria(all, existingCat);
        assertFalse(filtered.isEmpty());
        assertTrue(filtered.stream().allMatch(p -> existingCat.equalsIgnoreCase(p.getCategoria())));
    }

    @Test
    @DisplayName("TC_CM_02 / TF-CM-05: categoria valida ma senza prodotti -> lista vuota")
    void TF_CM_05_categoriaValida_senzaProdotti() {
        ProdottoDao dao = new ProdottoDao(con);
        List<Prodotto> all = dao.getAllProdotti();
        assertFalse(all.isEmpty());

        List<Prodotto> filtered = filterByCategoria(all, "categoria_inesistente_123");
        assertTrue(filtered.isEmpty());
    }

    @Test
    @DisplayName("TC_CM_02 / TF-CM-06: nessuna categoria selezionata -> lista completa")
    void TF_CM_06_nessunaCategoria_listaCompleta() {
        ProdottoDao dao = new ProdottoDao(con);
        List<Prodotto> all = dao.getAllProdotti();
        assertFalse(all.isEmpty());

        List<Prodotto> filtered = filterByCategoria(all, "");
        assertEquals(all.size(), filtered.size());
    }
}
