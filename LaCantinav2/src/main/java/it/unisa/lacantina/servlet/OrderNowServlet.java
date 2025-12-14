package it.unisa.lacantina.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import it.unisa.lacantina.model.Ordine;
import it.unisa.lacantina.model.User;

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
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
			Date date = new Date();
			
			User auth = (User)request.getSession().getAttribute("auth");
			if(auth!=null) 
			{
				
				String prodottoId = request.getParameter("id");
				int productQuantity = Integer.parseInt(request.getParameter("quantity"));
				if(productQuantity<=0) {
					response.sendRedirect("index.jsp");
				}else {
					
					Ordine orderModel = new Ordine();
					orderModel.setId(Integer.parseInt(prodottoId));
					orderModel.setId_utente(auth.getID());
					orderModel.setData(formatter.format(date));
					
					
					
					
				}
				
				
				
				
			}
			else {
				response.sendRedirect("LoginAndRegistration.jsp")
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
