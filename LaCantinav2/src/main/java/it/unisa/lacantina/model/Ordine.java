package it.unisa.lacantina.model;

public class Ordine extends Prodotto{
	
	private int id;
	private int id_prodotto;
	private int id_utente;
	private int quantity;
	private String data;
	private int id_riga_ordine;
	
	
	public Ordine() {
		
	}
	
	public Ordine(int id,int id_prodotto, int id_utente, int quantity, String data, int id_riga_ordine) {
		super();
		this.id = id;
		this.id_prodotto = id_prodotto;
		this.id_utente = id_utente;
		this.quantity = quantity;
		this.data = data;
		this.id_riga_ordine = id_riga_ordine;
	}
	
	public int getId_ordine() {
		return id;
	}
	public int getIdRigaOrdine() {
		return id_riga_ordine;
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
	public void setId_ordine(int id) {
		this.id = id;
	}
	public void setIdRigaOrdine(int id) {

		this.id_riga_ordine = id;
	}
	

}
