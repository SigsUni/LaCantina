package it.unisa.lacantina.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import it.unisa.lacantina.model.Cart;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		
		try(PrintWriter out = response.getWriter()){
			
			ArrayList<Cart> cartList = new ArrayList<>();
			
			
			int id = Integer.parseInt(request.getParameter("id"));
			Cart cm = new Cart();
			cm.setId(id);
			cm.setQuantity(1);
			
			HttpSession session = request.getSession();
			ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
			
			
		if(cart_list == null) {
			cartList.add(cm);
			session.setAttribute("cart-list", cartList);
			out.println("session crerated and added the list");
		}
		else
		{
			cartList = cart_list;
			boolean exist = false;
			
			
			for(Cart c:cart_list) {
				
				if(c.getId() == id) {
					exist = true;
					out.println("product exist");
				}
				
			}
			if(!exist) {
				cartList.add(cm);
				out.println("product-added");
			}
		}
		
		for(Cart c:cart_list) {
			
			out.println(c.getId());
		}
			
			
		}
	}

}
