package it.unisa.lacantina.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import it.unisa.lacantina.model.*;

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
				row.setImmagine(rs.getString("immagine"));
				row.setDescrizione(rs.getString("descrizione"));
				row.setStock(rs.getInt("stock"));
				
				
				prodotti.add(row);
			}
			}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return prodotti;
			
	}
	
	
	////////METODI IMPLEMENTATIVI DELLE FUNZIONI DEL CARRELLO
	
	public List<Cart> getCartProducts(ArrayList<Cart> cartList){
	
		List<Cart> prodotti = new ArrayList<Cart>();
	
		try {
		
			if(cartList.size()>0) {
				for(Cart item:cartList) {
					query = "select * from prodotti where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1,item.getId());
					rs = pst.executeQuery();
					while(rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("id"));
						row.setNome(rs.getString("nome"));
						row.setCategoria(rs.getString("categoria"));
						row.setPrezzo(rs.getFloat("prezzo"));
						row.setImmagine(rs.getString("immagine"));
						row.setDescrizione(rs.getString("descrizione"));
						row.setStock(rs.getInt("stock"));
						row.setQuantity(item.getQuantity());
						prodotti.add(row);
					}
				}
			}
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			//e.printStackTrace();
		}
	
		return prodotti;
	
	}

}
