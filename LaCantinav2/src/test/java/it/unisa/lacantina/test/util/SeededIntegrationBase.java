package it.unisa.lacantina.test.util;

import static it.unisa.lacantina.test.util.TestDbConfig.*;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;

public abstract class SeededIntegrationBase {

	@BeforeAll
    static void configureDbForServlets() {
        System.setProperty("lacantina.db.url",  it.unisa.lacantina.test.util.TestDbConfig.URL);
        System.setProperty("lacantina.db.user", it.unisa.lacantina.test.util.TestDbConfig.USER);
        System.setProperty("lacantina.db.pass", it.unisa.lacantina.test.util.TestDbConfig.PASSWORD);
    }
	
    @BeforeEach
    void seedDb() throws Exception {
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD)) {
            c.setAutoCommit(true);
            SqlScriptRunner.runClasspathScript(c, "db/seed.sql");
        }
    }
    
    

}
