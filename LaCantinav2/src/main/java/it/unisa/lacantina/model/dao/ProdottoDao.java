package it.unisa.lacantina.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import it.unisa.lacantina.model.*;
import it.unisa.lacantina.model.domain.Carrello;
import it.unisa.lacantina.model.domain.Prodotto;

public class ProdottoDao {

	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ProdottoDao(Connection con) {
		this.con = con;
	}
	
	public List<Prodotto> getAllProdotti(){
		
		List<Prodotto> prodotti= new ArrayList<Prodotto>();
		
		try {
			query = "select * from prodotti";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				Prodotto row = new Prodotto();
				row.setId(rs.getInt("id"));
				row.setNome(rs.getString("nome"));
				row.setCategoria(rs.getString("categoria"));
				row.setPrezzo(rs.getFloat("prezzo"));
				row.setIdFornitore(rs.getInt("id_fornitore"));
				row.setImmagine(rs.getString("immagine"));
				row.setDescrizione(rs.getString("descrizione"));
				row.setStock(rs.getInt("stock"));
				row.setStato(rs.getString("stato"));
				
				
				prodotti.add(row);
			}
			}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return prodotti;
			
	}
	
	
	
	
	public Prodotto getSingleProdotto(int id) {
		Prodotto prod = null;
		
		try {
			query = "select * from prodotti where id=?;";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while(rs.next()) {
				prod = new Prodotto();
				
				prod.setId(rs.getInt("id"));
				prod.setIdFornitore(rs.getInt("id_fornitore"));
				prod.setNome(rs.getString("nome"));
				prod.setCategoria(rs.getString("categoria"));
				prod.setPrezzo(rs.getFloat("prezzo"));
				prod.setImmagine(rs.getString("immagine"));
				prod.setDescrizione(rs.getString("descrizione"));
				prod.setStock(rs.getInt("stock"));
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		return prod;
	}
	
	public boolean setNewStock(int id, int nuovo_stock) 
	{
		
		boolean result = false;
		
		try {
			
			query = "update prodotti set stock=? where id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, nuovo_stock);
			pst.setInt(2, id);
			pst.executeUpdate();
			result = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	public int getStockFromId(int id) {
		
		int stock = 0;
		
		try {
			query = "select stock from prodotti where id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while(rs.next()) {
				stock = rs.getInt("stock");
			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return stock;
		
	}
	
	
	public void DeleteById(int id)
	{
		try {
			
			query = "UPDATE prodotti SET stato ='inattivo' where id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			
			pst.execute();
	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public boolean insertProduct(String nome, int id_fornitore, String categoria, String descrizione,int stock, float prezzo, String immagine)
	{
		boolean result = false;
		
		try {
			
			query = "insert into prodotti (nome,id_fornitore,descrizione,categoria,stock,prezzo,immagine, stato) values(?,?,?,?,?,?,?,?)";
			
			pst= this.con.prepareStatement(query);
			pst.setString(1,nome);
			pst.setInt(2,id_fornitore);
			pst.setString(3,descrizione);
			pst.setString(4,categoria);
			pst.setInt(5,stock);
			pst.setFloat(6,prezzo);
			pst.setString(7,immagine);
			pst.setString(8, "attivo");
			pst.executeUpdate();
			result = true;
			
			return result;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return result;
		
		
	}
	
	public boolean ModifyPriceById(int id, float prezzo) 
	{
		boolean result = false;
		
		try 
		{
			
			query = "UPDATE prodotti SET prezzo =? where id=?";
			pst = this.con.prepareStatement(query);
			pst.setFloat(1, prezzo);
			pst.setInt(2, id);
			
			pst.execute();
			
			result = true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return result;
		
	}
	
}
	