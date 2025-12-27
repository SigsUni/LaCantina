package it.unisa.lacantina.model.domain;


public class Carrello{
	private int quantity;
	private Prodotto prodotto;
	
	public Carrello() {
		prodotto = new Prodotto();
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public Prodotto getProdotto() {
		return prodotto;
	}
	
	public void setProdotto(Prodotto prodotto) {
		this.prodotto = prodotto;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
	
	

}
