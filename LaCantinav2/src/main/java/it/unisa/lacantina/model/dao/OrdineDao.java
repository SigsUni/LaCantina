package it.unisa.lacantina.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import it.unisa.lacantina.model.domain.Ordine;
import it.unisa.lacantina.model.domain.Prodotto;
import it.unisa.lacantina.model.domain.Utente;

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
		ProdottoDao productDao = new ProdottoDao(this.con);
		Prodotto prod = productDao.getSingleProdotto(model.getIdProdotto());
		try {
			
			query = "insert into ordini(id_prodotto,id_utente, quantity, prezzo_acquisto,data_ordine, id_riga_ordine) values(?,?,?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, model.getIdProdotto());
			pst.setInt(2, model.getIdUtente());
			pst.setInt(3,model.getQuantity());
			pst.setFloat(4, model.getPrezzoAcquisto());
			pst.setString(5, model.getData());
			pst.setInt(6, model.getIdRigaOrdine());
			pst.executeUpdate();
			model.setProdotto(prod);
			result = true;
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	public List<Ordine> userOrders(int id){
		List<Ordine> list = new ArrayList<>();
		try {
			
			query = "select * from ordini where id_utente =? order by ordini.id desc;";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				Ordine order = new Ordine();
				ProdottoDao productDao = new ProdottoDao(this.con);
				
				int pId = rs.getInt("id_prodotto");
				
				Prodotto prodotto = productDao.getSingleProdotto(pId);
				order.setId_ordine(rs.getInt("id"));
				order.setIdRigaOrdine(rs.getInt("id_riga_ordine"));
				order.setProdotto(prodotto);
				order.setQuantity(rs.getInt("quantity"));
				order.setData(rs.getString("data_ordine"));
				order.setPrezzoAcquisto(rs.getFloat("prezzo_acquisto"));
			
				list.add(order);
				
			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	
	public List<Ordine> all_userOrders()
	{
		List<Ordine> list = new ArrayList <>();
		
		try
		{
			query = "select * from ordini order by ordini.id desc";
			pst = this.con.prepareStatement(query);
			
			rs = pst.executeQuery();
			
			while(rs.next())
			{
				Ordine order = new Ordine();
				
				ProdottoDao productdao = new ProdottoDao(this.con);
				UtenteDao userdao = new UtenteDao(this.con);
				
				int pId = rs.getInt("id_prodotto");
				int uId = rs.getInt("id_utente");
				
				
				Prodotto product = productdao.getSingleProdotto(pId);
				Utente user = userdao.getSingleUser(uId);
				order.setId_ordine(rs.getInt("id"));
				order.setIdRigaOrdine(rs.getInt("id_riga_ordine"));
				order.setId_prodotto(pId);
				order.setId_utente(uId);
				order.setProdotto(product);
				order.setQuantity(rs.getInt("quantity"));
				order.setPrezzoAcquisto(rs.getFloat("prezzo_acquisto"));
				order.setData(rs.getString("data_ordine"));
				list.add(order);
				
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	
}