package it.unisa.lacantina.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.util.ConnectToDB;

/**
 * Servlet implementation class AdminAddStock
 */
@WebServlet("/add-stock")
public class AdminAddStockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAddStockServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset = UTF-8");
		
		try(PrintWriter out = response.getWriter())
		{
			int id = Integer.parseInt(request.getParameter("id"));
			int stock_input = Integer.parseInt(request.getParameter("stock_add"));
			ProdottoDao productdao = new ProdottoDao(ConnectToDB.getConnection());
			
			int stock = productdao.getStockFromId(id);
			productdao.setNewStock(id, stock+stock_input);
			
			response.sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
		}
		catch(Exception e)
		{
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
