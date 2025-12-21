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
	
	public boolean UserCheck(String email)
	{
		try
		{
			query = "select * from utenti where email=?";
			
			pst = this.con.prepareStatement(query);
			pst.setString(1,email);
			rs = pst.executeQuery();
			
			if(rs.next())
			{
				if(rs.getString("email").equals(email))
				{
						return true;
				}
			}
			return false;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return false;
	}
	
	
	public boolean userRegistration(String name, String email, String password)
	{
		try
		{
			query = "insert into utenti (nome, email, password) VALUES (?,?,?)";
				
			pst = this.con.prepareStatement(query);
			pst.setString(1,name);
			pst.setString(2,email);
			pst.setString(3,password);
			pst.executeUpdate();
			return true;
				
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		
		return false;
	}
	
	public User getSingleUser(int id)
	{
		User row = null;
		
		try {
			
			query = "select * from utenti where id=?";
			
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			
			rs = pst.executeQuery();
			
			while(rs.next()) {
				
				row = new User();
				
				row.setID(rs.getInt("id"));
				row.setName(rs.getString("nome"));
				row.setEmail(rs.getString("email"));
				row.setPassword(rs.getString("password"));
			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return row;
	}
	
	public String getNomeById(int id)
	{
		String nome = null;
		
		try {
			
			query = "select nome from utenti where id=?";
			
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			
			rs = pst.executeQuery();
			
			while(rs.next()) {
				nome = (rs.getString("nome"));
			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return nome;
	}

}
