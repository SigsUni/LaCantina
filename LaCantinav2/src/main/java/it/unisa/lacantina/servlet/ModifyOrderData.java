package it.unisa.lacantina.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import it.unisa.lacantina.control.ProdottoDao;
import it.unisa.lacantina.control.RigaOrdineDao;
import it.unisa.lacantina.model.ConnectToDB;

/**
 * Servlet implementation class ModifyOrderData
 */
@WebServlet("/modifica-dati")
public class ModifyOrderData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset= UTF-8");
		
		try (PrintWriter out = response.getWriter())
		{
			String indirizzo = request.getParameter("insert-indirizzo");
			String provincia = request.getParameter("insert-provincia");
			String cap = request.getParameter("insert-cap");
			String citta = request.getParameter("insert-citta");
			String stato_ordine = request.getParameter("stato_ordine");
			int id = Integer.parseInt(request.getParameter("insert-id"));
			
			
			try 
			{
				RigaOrdineDao rigaOrdinedao = new RigaOrdineDao(ConnectToDB.getConnection());
				
				boolean x = rigaOrdinedao.UpdateData(id,indirizzo, provincia, cap, citta, stato_ordine);
				
				
				if(x == true)
				{
					response.sendRedirect("/LaCantinav2/index.jsp");
				}
				else
				{
					response.sendRedirect("/LaCantinav2/index.jsp");
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
