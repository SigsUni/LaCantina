package it.unisa.lacantina.controller.AdminOperationControl;

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
 * Servlet implementation class AdminInsertNewProduct
 */
@WebServlet("/insert-product")
public class AdminInsertNewProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminInsertNewProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset= UTF-8");
		
		try (PrintWriter out = response.getWriter())
		{
			String name = request.getParameter("insert-nome");
			String categoria = request.getParameter("insert-categoria");
			String descrizione = request.getParameter("insert-descrizione");
			int Stock = Integer.parseInt(request.getParameter("insert-stock"));
			String immagine = request.getParameter("insert-immagine");
			float prezzo= Float.parseFloat(request.getParameter("insert-prezzo"));
			int id_fornitore = Integer.parseInt(request.getParameter("fornitore_id"));
			
			
			try 
			{
				ProdottoDao productdao = new ProdottoDao(ConnectToDB.getConnection());
				
				boolean x = productdao.insertProduct(name,id_fornitore,categoria,descrizione,Stock,prezzo,immagine);
				
				
				if(x == true)
				{
					response.sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
				}
				else
				{
					response.sendRedirect("/LaCantinav2/admin-pages/insert_error.jsp");
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
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
