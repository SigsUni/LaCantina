package it.unisa.lacantina.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import it.unisa.lacantina.model.Ordine;

public class OrdineDao 
{
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	
	
	public OrdineDao(Connection con) {
		
		this.con = con;
		
	}
	
	public boolean insertOrder(Ordine model) 
	{
		boolean result = false;
		
		try {
			
			query = "insert into ordini(id_prodotto,id_utente, quantity, data_ordine) values(?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, model.getIdProdotto());
			pst.setInt(2, model.getIdUtente());
			pst.setInt(3,model.getQuantity());
			pst.setString(4, model.getData());
			pst.executeUpdate();
			result = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	
}
