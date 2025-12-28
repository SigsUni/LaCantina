package it.unisa.lacantina.model.domain;

public class RigaOrdine {
	
	private int id;
	private int quantity;
	private float prezzo_totale;
	private String stato_ordine;
	private String indirizzo;
	private String cap;
	private String citta;
	private String provincia;

	
	public RigaOrdine() {
		
	}
	
	public RigaOrdine(int id,int quantity, float prezzo_totale, String stato_ordine, String indirizzo, String cap, String city, String provincia) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.prezzo_totale = prezzo_totale;
		this.stato_ordine = stato_ordine;
		this.citta = city;
		this.indirizzo = indirizzo;
		this.cap = cap;
	}
	
	public int getId() {
		return id;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public float getPrezzoTotale() {
		return prezzo_totale;
	}
	
	public String getStatoOrdine() {
		return stato_ordine;
	}
	
	public String getIndirizzo() {
		return indirizzo;
	}
	
	public String getCap() {
		return cap;
	}
	
	public String getCitta() {
		return citta;
	}
	
	public String getProvincia() {
		return provincia;
	}
	
	//SETTER
	
	public void setId(int id) {
		this.id = id;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public void setPrezzoTotale(float prezzo) {
		this.prezzo_totale =  prezzo;
	}
	
	public void setStatoOrdine(String stato_ordine) {
		this.stato_ordine = stato_ordine;
	}
	
	public void setIndirizzo(String indirizzo) {
		this.indirizzo =  indirizzo;
	}
	
	public void setCap(String cap) {
		this.cap = cap;
	}
	
	public void setCitta(String city) {
		this.citta = city;
	}
	
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

}
