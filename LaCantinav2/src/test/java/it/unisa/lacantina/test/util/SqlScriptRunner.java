package it.unisa.lacantina.test.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Statement;
import java.util.stream.Collectors;

public final class SqlScriptRunner {
    private SqlScriptRunner() {}

    public static void runClasspathScript(Connection con, String resourcePath) throws Exception {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                SqlScriptRunner.class.getClassLoader().getResourceAsStream(resourcePath),
                StandardCharsets.UTF_8))) {

            if (br == null) throw new IllegalArgumentException("Resource non trovata: " + resourcePath);

            String sql = br.lines().collect(Collectors.joining("\n"));
            // rimuove commenti "-- ..."
            sql = sql.replaceAll("(?m)^\\s*--.*$", "");

            String[] statements = sql.split(";");
            for (String raw : statements) {
                String stmt = raw.trim();
                if (stmt.isEmpty()) continue;
                try (Statement s = con.createStatement()) {
                    s.execute(stmt);
                }
            }
        }
    }
}
