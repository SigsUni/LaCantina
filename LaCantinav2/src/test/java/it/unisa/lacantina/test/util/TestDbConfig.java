package it.unisa.lacantina.test.util;

public final class TestDbConfig {
    private TestDbConfig() {}

    // Usa lo stesso DB del progetto (ConnectToDB), così non devi cambiare niente.
    // Se preferisci un DB separato, cambia qui e basta.
    public static final String URL = "jdbc:mysql://localhost:3306/LaCantina";
    public static final String USER = "root";
    public static final String PASSWORD = "";
}
