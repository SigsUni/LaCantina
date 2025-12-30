package it.unisa.lacantina.model.domain;

public class Fornitore {

    private int id;
    private String nome;
    private String citta;
    private String provincia;
    private String indirizzo;
    private int annoNascita;

    // Costruttore vuoto
    public Fornitore() {
    }

    // Costruttore completo
    public Fornitore(int id, String nome, String citta, String provincia, String indirizzo, int annoNascita) {
        this.id = id;
        this.nome = nome;
        this.citta = citta;
        this.provincia = provincia;
        this.indirizzo = indirizzo;
        this.annoNascita = annoNascita;
    }

    // Getter e Setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCitta() {
        return citta;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public int getAnnoNascita() {
        return annoNascita;
    }

    public void setAnnoNascita(int annoNascita) {
        this.annoNascita = annoNascita;
    }
}
