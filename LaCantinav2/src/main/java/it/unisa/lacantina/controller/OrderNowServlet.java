package it.unisa.lacantina.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import it.unisa.lacantina.model.dao.OrdineDao;
import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.model.dao.RigaOrdineDao;
import it.unisa.lacantina.model.domain.Cart;
import it.unisa.lacantina.model.domain.Ordine;
import it.unisa.lacantina.model.domain.RigaOrdine;
import it.unisa.lacantina.model.domain.User;
import it.unisa.lacantina.util.ConnectToDB;

/**
 * Servlet implementation class OrderNowServlet
 */
@WebServlet("/order-now")
public class OrderNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try(PrintWriter out = response.getWriter())
		{
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			
			User auth = (User)request.getSession().getAttribute("auth");
			ProdottoDao prodotto = null;
			if(auth!=null) 
			{
				
				String prodottoId = request.getParameter("insert-id");
				int productQuantity = Integer.parseInt(request.getParameter("insert-quantity"));
				String indirizzo = request.getParameter("insert-indirizzo");
				String provincia = request.getParameter("insert-provincia");
				String cap = request.getParameter("insert-cap");
				String citta = request.getParameter("insert-citta");
				
				
				
				ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
				float prezzo_totale = 0;
				prezzo_totale = Float.parseFloat(request.getParameter("insert-prezzo"));
				
				if(prezzo_totale!=0) {
				if(cart_list!= null)
				{
					for(Cart c:cart_list) {
						if(c.getId() == Integer.parseInt(prodottoId)) 
						{
							System.out.println("PREZO CARRELLO = " + c.getPrezzo());
							System.out.println("QUANTITY CARRELLO ="+ c.getQuantity());
							
							prezzo_totale = prezzo_totale + (c.getPrezzo() * c.getQuantity());
							break;
						}
					}
				}}
				
				
				if(productQuantity<=0) {
					response.sendRedirect("index.jsp");
				}else 
				{
					
					Ordine orderModel = new Ordine();
					//CREZIONE NUOVA RIGAORDINE
					RigaOrdineDao nuovaRiga = new RigaOrdineDao(ConnectToDB.getConnection());
					int id_riga_ordine = nuovaRiga.nuovaRigaOrdine(indirizzo, cap, citta,provincia,prezzo_totale, 1);
					//FINE CREAZIONE NUOVA RIGAORDINE
					orderModel.setId_prodotto(Integer.parseInt(prodottoId));
					orderModel.setId_utente(auth.getID());
					orderModel.setQuantity(productQuantity);
					orderModel.setData(formatter.format(date));
					orderModel.setIdRigaOrdine(id_riga_ordine);
					OrdineDao orderDao = new OrdineDao(ConnectToDB.getConnection());
					boolean result = orderDao.insertOrder(orderModel);
					//OPERAZIONI DI DECREMENTO STOCK
					prodotto = new ProdottoDao(ConnectToDB.getConnection());
					int nuovo_stock = prodotto.getStockFromId(orderModel.getIdProdotto()) - 1;
					boolean result_update_stock = prodotto.setNewStock(orderModel.getIdProdotto(),nuovo_stock);
					//FINE OPERAZIONI DECREMENTO STOCK
					if(result || result_update_stock) 
					{
						//RIMOZIONE ELEMENTO DA CARRELLO SE PRESENTE
						cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
						if(cart_list!= null) {
							for(Cart c:cart_list) {
								if(c.getId() == Integer.parseInt(prodottoId)) 
								{
									cart_list.remove(cart_list.indexOf(c));
									break;
								}
							}
						}
						response.sendRedirect("ordini.jsp");
					}
					else 
					{
						response.sendRedirect("LoginAndRegistration.jsp");
					}
				}
				
				
				
				
			}
			else {
				response.sendRedirect("LoginAndRegistration.jsp");
			}
			
			
		}
		catch(Exception e ) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
