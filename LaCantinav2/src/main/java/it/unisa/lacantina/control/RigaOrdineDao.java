package it.unisa.lacantina.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import it.unisa.lacantina.model.Ordine;

public class RigaOrdineDao {

	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	
	
	public RigaOrdineDao(Connection con) {
		
		this.con = con;
		
	}
	
	public boolean nuovaRigaOrdine(int prezzo_totale, int numero_ordini) 
	{
		boolean result = false;
		
		try {
			
			query = "insert into riga_ordini(numero_ordini, prezzo_totale, stato_ordine, indirizzo, cap, citta, provincia) values(?,?,?,?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, numero_ordini);
			pst.setInt(2, prezzo_totale);
			pst.setString(3,"attesa di conferma");
			pst.setString(4, "via giovanni nicotera");
			pst.setString(5, "84015");
			pst.setString(6, "Nocera Superiore");
			pst.setString(7, "Salerno");
			pst.executeUpdate();
			result = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
}
