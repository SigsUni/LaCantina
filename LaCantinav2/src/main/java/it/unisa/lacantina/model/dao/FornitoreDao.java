package it.unisa.lacantina.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import it.unisa.lacantina.model.domain.Fornitore;

public class FornitoreDao {

    private Connection con;
    private PreparedStatement pst;
    private ResultSet rs;
    private String query;

    public FornitoreDao(Connection con) {
        this.con = con;
    }

    public List<Fornitore> getAllFornitori() {

        List<Fornitore> fornitori = new ArrayList<>();

        try {
            query = "SELECT * FROM fornitori";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                Fornitore f = new Fornitore();

                f.setId(rs.getInt("id"));
                f.setNome(rs.getString("nome"));
                f.setCitta(rs.getString("citta"));
                f.setProvincia(rs.getString("provincia"));
                f.setIndirizzo(rs.getString("indirizzo"));
                f.setAnnoNascita(rs.getInt("anno_nascita"));

                fornitori.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return fornitori;
    }
    
    
    
    public String getNomeById(int id) {
        String nome = null;

        try {
            query = "SELECT nome FROM fornitori WHERE id = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();

            if (rs.next()) {
                nome = rs.getString("nome");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return nome;
    }
}
