package it.unisa.lacantina.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import it.unisa.lacantina.model.domain.Carrello;

/**
 * Servlet implementation class QuantityIncDecServlet
 */
@WebServlet("/quantity-inc-dec")
public class QuantityIncDecServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			
			String action = request.getParameter("action");
			int id = Integer.parseInt(request.getParameter("id"));
			
			ArrayList<Carrello> cart_list = (ArrayList<Carrello>) request.getSession().getAttribute("cart-list");
			
			
			if(action != null && id>=1) {
				
				if(action.equals("inc")) {
					for(Carrello c:cart_list) {
						if(c.getProdotto().getId() == id) {
							
							int quantity = c.getQuantity();
							quantity++;
							c.setQuantity(quantity);
							response.sendRedirect("carrello.jsp");
						}
					}
				}
				else if(action.equals("dec")) {
					
					for(Carrello c:cart_list) {
						if(c.getProdotto().getId() == id) {
							
							int quantity = c.getQuantity();
							if(quantity>1)
							quantity--;
							c.setQuantity(quantity);
							response.sendRedirect("carrello.jsp");
						}
					}
					
				}
				else
				{
					response.sendRedirect("carrello.jsp");
				}
			}
		}
		
	}

}
