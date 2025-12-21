package it.unisa.lacantina.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import it.unisa.lacantina.model.Ordine;
import it.unisa.lacantina.model.Prodotto;
import it.unisa.lacantina.model.User;

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
				order.setNome(prodotto.getNome());
				order.setCategoria(prodotto.getCategoria());
				order.setPrezzo(prodotto.getPrezzo() * rs.getInt("quantity"));
				order.setQuantity(rs.getInt("quantity"));
				order.setData(rs.getString("data_ordine"));
			
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
				UserDao userdao = new UserDao(this.con);
				
				int pId = rs.getInt("id_prodotto");
				int uId = rs.getInt("id_utente");
				
				
				Prodotto product = productdao.getSingleProdotto(pId);
				User user = userdao.getSingleUser(uId);
				order.setId(rs.getInt("id"));
				order.setId_prodotto(pId);
				order.setId_utente(uId);
				order.setNome(product.getNome());
				order.setCategoria(product.getCategoria());
				order.setPrezzo(product.getPrezzo()*rs.getInt("quantity"));
				order.setQuantity(rs.getInt("quantity"));
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