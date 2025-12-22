package it.unisa.lacantina.model;

public class RigaOrdine {
	
	private int id;
	private int quantity;
	private int prezzo_totale;
	private String stato_ordine;
	private String indirizzo;
	private String cap;
	private String city;
	private String provincia;

	
	public RigaOrdine() {
		
	}
	
	public RigaOrdine(int id,int quantity, int prezzo_totale, String stato_ordine, String indirizzo, String cap, String city, String provincia) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.prezzo_totale = prezzo_totale;
		this.stato_ordine = stato_ordine;
		this.indirizzo = indirizzo;
		this.cap = cap;
	}

}
