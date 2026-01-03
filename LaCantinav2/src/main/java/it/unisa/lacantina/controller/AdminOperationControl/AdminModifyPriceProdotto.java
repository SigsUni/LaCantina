package it.unisa.lacantina.controller.AdminOperationControl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.util.ConnectToDB;

/**
 * Servlet implementation class AdminModifyPriceProdotto
 */
@WebServlet("/modify-price")
public class AdminModifyPriceProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminModifyPriceProdotto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			float prezzo = Float.parseFloat(request.getParameter("nuovo_prezzo"));
			int id =Integer.parseInt(request.getParameter("id"));
			ProdottoDao productdao = new ProdottoDao(ConnectToDB.getConnection());
			
		
			boolean result = productdao.ModifyPriceById(id,prezzo);
			if(result) {
				response.sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
			}
			else {
				response.sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
			}
		
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
