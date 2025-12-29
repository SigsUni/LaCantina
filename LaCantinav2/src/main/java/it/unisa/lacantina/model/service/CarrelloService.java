package it.unisa.lacantina.model.service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import it.unisa.lacantina.model.domain.Carrello;

public class CarrelloService {
	
	
	public CarrelloService() {
		
	}
	
	public float getTotalCartPrice(ArrayList<Carrello> cartList) {
		
		float sum = 0;
	
		try {
			if(cartList.size()>0) {
				for(Carrello item:cartList) 
				{
					sum = sum + item.getProdotto().getPrezzo() * item.getQuantity();
					
				}
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
}
