package it.unisa.lacantina.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import it.unisa.lacantina.control.OrdineDao;
import it.unisa.lacantina.control.ProdottoDao;
import it.unisa.lacantina.control.RigaOrdineDao;
import it.unisa.lacantina.model.Cart;
import it.unisa.lacantina.model.ConnectToDB;
import it.unisa.lacantina.model.Ordine;
import it.unisa.lacantina.model.User;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try(PrintWriter out = response.getWriter()){
			
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			//prende tutti i prodotti dal carrello
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			//prende la sessione utente
			User auth = (User)request.getSession().getAttribute("auth");
			
			//controlli cart-list e autenticazione
			
			float prezzo_totale =0;
			int num_oggetti = 0;
			RigaOrdineDao nuovaRiga = new RigaOrdineDao(ConnectToDB.getConnection());
			int id_riga_ordine = 0;
			if(cart_list!=null && auth!=null) {
				
				for(Cart c:cart_list) {
					prezzo_totale = prezzo_totale + (c.getPrezzo() * c.getQuantity());
					num_oggetti++;
				}
				id_riga_ordine = nuovaRiga.nuovaRigaOrdine(prezzo_totale, num_oggetti);
			}
			
			
			
			ProdottoDao prodotto = null;
			
			if(cart_list != null && auth!= null) {
			
				//INSERIMENTO RIGA ORDINE
				
				
				for(Cart c:cart_list)
				{
	
					Ordine order = new Ordine();
					prodotto = new ProdottoDao(ConnectToDB.getConnection());
					order.setId_prodotto(c.getId());
					order.setId_utente(auth.getID());
					order.setQuantity(c.getQuantity());
					order.setData(formatter.format(date));
					order.setIdRigaOrdine(id_riga_ordine);
					
					OrdineDao oDao = new OrdineDao(ConnectToDB.getConnection());
					boolean result = oDao.insertOrder(order);
					//UPDATE NUOVO STOCK
					int nuovo_stock = prodotto.getStockFromId(c.getId()) - c.getQuantity();
					boolean result_update_stock = prodotto.setNewStock(c.getId(),nuovo_stock);
					if(!result || !result_update_stock) {
						
						break;
					}
				}
				
				
				cart_list.clear();
				response.sendRedirect("ordini.jsp");
			}
			else {
				if(auth == null) {
					response.sendRedirect("LoginAndRegistration.jsp");
				}
				response.sendRedirect("carrello.jsp");
			}
			
			
			
			
		}
		catch(Exception e) {
			e.printStackTrace();		
			}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
