package it.unisa.lacantina.model;

public class Prodotto {
	
	private int id;
	private String nome;
	private String descrizione;
	private String categoria;
	private int stock;
	private float prezzo;
	private String immagine;
	
	
	public Prodotto(int id, String nome, String descrizione, String categoria, float prezzo, String immagine){
		
		this.id = id;
		this.nome = nome;
		this.descrizione = descrizione;
		this.categoria = categoria;
		this.prezzo = prezzo;
		this.immagine = immagine;
	}
	
	public int getId() {
		return this.id;
	}
	
	public String getNome() {
		return this.nome;
	}
	
	public String getDescrizione() {
		return this.descrizione;
	}
	
	public String getCategoria() {
		return this.categoria;
	}
	
	public float getPrezzo() {
		return this.prezzo;
	}
	
	public String getImmagine() {
		return this.immagine;
	}
	
	
	void setNome(String nome)
	{
		this.nome = nome;
	}
	
	void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
	void setPrezzo(float prezzo) {
		
		this.prezzo = prezzo;
	}
	
	void setImmagine(String immagine) {
		
		this.immagine = immagine;
	}
}
