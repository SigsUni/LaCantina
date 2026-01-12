package it.unisa.lacantina.test.util;

import static it.unisa.lacantina.test.util.TestDbConfig.*;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.jupiter.api.BeforeEach;

public abstract class SeededIntegrationBase {

    @BeforeEach
    void seedDb() throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD)) {
            c.setAutoCommit(true);
            SqlScriptRunner.runClasspathScript(c, "db/seed.sql");
        }
    }
}
