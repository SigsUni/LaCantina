package it.unisa.lacantina.controller.CarrelloControl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.model.domain.Carrello;
import it.unisa.lacantina.model.domain.Prodotto;
import it.unisa.lacantina.util.ConnectToDB;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    try {
	        int id = Integer.parseInt(request.getParameter("id"));

	        ProdottoDao pdao = new ProdottoDao(ConnectToDB.getConnection());
	        Prodotto prodotto = pdao.getSingleProdotto(id);

	        HttpSession session = request.getSession();

	        ArrayList<Carrello> cartList =
	                (ArrayList<Carrello>) session.getAttribute("cart-list");

	        if (cartList == null) {
	            cartList = new ArrayList<>();
	        }

	        boolean exist = false;

	        for (Carrello c : cartList) {
	            if (c.getProdotto().getId() == id) {
	                c.setQuantity(c.getQuantity() + 1); // aumenta quantità
	                exist = true;
	                break;
	            }
	        }

	        if (!exist) {
	            Carrello item = new Carrello();
	            item.setProdotto(prodotto);
	            item.setQuantity(1);
	            cartList.add(item);
	        }

	        session.setAttribute("cart-list", cartList);
	        response.sendRedirect("shop.jsp");

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    }
	}
}