package it.unisa.lacantina.test.util;

import static it.unisa.lacantina.test.util.TestDbConfig.*;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.jupiter.api.BeforeEach;

public abstract class DbTestBase {

    protected Connection con;

    @BeforeEach
    void resetDbAndOpenTx() throws Exception {
        try (Connection seedCon = DriverManager.getConnection(URL, USER, PASSWORD)) {
            seedCon.setAutoCommit(true);
            SqlScriptRunner.runClasspathScript(seedCon, "db/seed.sql");
        }

        con = DriverManager.getConnection(URL, USER, PASSWORD);
        con.setAutoCommit(false);
    }

    protected void rollbackAndClose() throws Exception {
        if (con != null) {
            con.rollback();
            con.close();
        }
    }
}
