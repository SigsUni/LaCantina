package it.unisa.lacantina.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import it.unisa.lacantina.model.User;

public class UserDao {
	
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public UserDao(Connection con) {
		this.con = con;
	}
	
	public User userLogin(String email, String password) {
		User user = null;
		
		try {
			query= "select * from utenti where email =? and password=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email); //previene l'SQL Injection
			pst.setString(2, password);
			rs = pst.executeQuery();
			
			if(rs.next())
			{
				user = new User();
				user.setID(rs.getInt("id"));
				user.setName(rs.getString("nome"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		
		return user;
	}

}
