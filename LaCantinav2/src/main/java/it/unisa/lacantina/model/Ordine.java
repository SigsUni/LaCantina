package it.unisa.lacantina.model;

public class Ordine extends Prodotto{
	
	private int id_prodotto;
	private int id_utente;
	private int quantity;
	private String data;
	
	
	public Ordine() {
		
	}
	
	public Ordine(int id, int id_utente, int quantity, String data) {
		super();
		this.id_prodotto = id;
		this.id_utente = id_utente;
		this.quantity = quantity;
		this.data = data;
	}
	
	public int getIdProdotto() 
	{
		return this.id_prodotto;
	}
	
	public int getIdUtente() 
	{
		return this.id_utente;
	}
	
	public int getQuantity() 
	{
		return this.quantity;
	}
	
	public String getData() 
	{
		return this.data;
	}
	
	public void setId_prodotto(int id) {
		this.id_prodotto = id;
	}
	
	public void setId_utente(int id) {
		this.id_utente = id;
	}
	
	public void setQuantity(int quantity) {
		
		this.quantity = quantity;
	}
	
	public void setData(String data) 
	{
		this.data = data;
	}
	

}
