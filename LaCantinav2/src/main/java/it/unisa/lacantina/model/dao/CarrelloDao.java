package it.unisa.lacantina.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import it.unisa.lacantina.model.domain.Carrello;

public class CarrelloDao {
	
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public CarrelloDao(Connection con) {
		this.con = con;
	}
	
	
	public List<Carrello> getCartProducts(ArrayList<Carrello> cartList){
		
		List<Carrello> prodotti = new ArrayList<Carrello>();
	
		try {
		
			if(cartList.size()>0) {
				for(Carrello item:cartList) {
					query = "select * from prodotti where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1,item.getProdotto().getId());
					rs = pst.executeQuery();
					while(rs.next()) {
						Carrello row = new Carrello();
						row.getProdotto().setId(rs.getInt("id"));
						row.getProdotto().setNome(rs.getString("nome"));
						row.getProdotto().setCategoria(rs.getString("categoria"));
						row.getProdotto().setPrezzo(rs.getFloat("prezzo"));
						row.getProdotto().setImmagine(rs.getString("immagine"));
						row.getProdotto().setDescrizione(rs.getString("descrizione"));
						row.getProdotto().setStock(rs.getInt("stock"));
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
	
	public float getTotalCartPrice(ArrayList<Carrello> cartList) {
		
		float sum = 0;
	
		try {
			if(cartList.size()>0) {
				for(Carrello item:cartList) 
				{
					query = "select prezzo from prodotti where id=?;";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getProdotto().getId());
					rs = pst.executeQuery();
					while(rs.next()) {
						sum += rs.getFloat("prezzo") * item.getQuantity();
					}
					
				}
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
}
