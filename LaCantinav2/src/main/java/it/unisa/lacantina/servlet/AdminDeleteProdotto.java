package it.unisa.lacantina.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import it.unisa.lacantina.control.ProdottoDao;
import it.unisa.lacantina.model.ConnectToDB;

/**
 * Servlet implementation class AdminDeleteProdotto
 */
@WebServlet("/delete-prodotto")
public class AdminDeleteProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDeleteProdotto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try
		{
		int id = Integer.parseInt(request.getParameter("id"));
		ProdottoDao productdao = new ProdottoDao(ConnectToDB.getConnection());
		
		productdao.DeleteById(id);
		
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
