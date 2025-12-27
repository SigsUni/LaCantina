package it.unisa.lacantina.model.domain;

import java.util.ArrayList;
import java.util.List;

public class Prodotto {
	
	private int id;
	private String nome;
	private String descrizione;
	private String categoria;
	private int stock;
	private float prezzo;
	private String immagine;
	
	public Prodotto() {
		
	}
	
	public Prodotto(int id, String nome, String descrizione, String categoria, float prezzo, String immagine, int stock){
		
		this.id = id;
		this.nome = nome;
		this.descrizione = descrizione;
		this.categoria = categoria;
		this.prezzo = prezzo;
		this.immagine = immagine;
		this.stock = stock;
	}
	
	public void setId(int id) {
		this.id = id;
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
	
	public int getStock() {
		return stock;
	}
	
	public boolean checkStock(int quantity) { //CONTROLLA SE ESISTONO UN NUMERO MINIMO DI PRODOTTI
		if(stock>=quantity) {
			return true;
		}
		return false;
	}
	
	public boolean checkSingleStock() { //CONTROLLA SE ESISTE ALEMNO UN PRODOTTO
		if(stock>0) {
			return true;
		}
		return false;
	}
	
	public void setNome(String nome)
	{
		this.nome = nome;
	}
	
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
	public void setPrezzo(float prezzo) {
		
		this.prezzo = prezzo;
	}
	
	public void setImmagine(String immagine) {
		
		this.immagine = immagine;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	
	
	
	
	
	
}
