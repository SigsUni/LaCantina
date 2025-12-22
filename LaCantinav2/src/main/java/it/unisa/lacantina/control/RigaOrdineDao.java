package it.unisa.lacantina.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import it.unisa.lacantina.model.Ordine;

public class RigaOrdineDao {

	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	
	
	public RigaOrdineDao(Connection con) {
		
		this.con = con;
		
	}
	
	public int nuovaRigaOrdine(float prezzo_totale, int numero_ordini) // ritorna l'id della riga ordine creata
	{
	    int id_nuova_riga = 0;

	    try {
	        query = "INSERT INTO riga_ordini " +
	                "(numero_ordini, prezzo_totale, stato_ordine, indirizzo, cap, citta, provincia) " +
	                "VALUES (?,?,?,?,?,?,?)";

	        pst = this.con.prepareStatement(
	                query,
	                Statement.RETURN_GENERATED_KEYS
	        );

	        pst.setInt(1, numero_ordini);
	        pst.setFloat(2, prezzo_totale);
	        pst.setString(3, "attesa di conferma");
	        pst.setString(4, "via giovanni nicotera");
	        pst.setString(5, "84015");
	        pst.setString(6, "Nocera Superiore");
	        pst.setString(7, "Salerno");

	        pst.executeUpdate();

	        //  Recupero ID generato
	        ResultSet rs = pst.getGeneratedKeys();
	        if (rs.next()) {
	            id_nuova_riga = rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return id_nuova_riga;
	}
}
