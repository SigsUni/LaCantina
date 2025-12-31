package it.unisa.lacantina.controller.UserControl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


import it.unisa.lacantina.model.dao.UtenteDao;
import it.unisa.lacantina.util.ConnectToDB;


/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/registration")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
response.setContentType("text/html; charset= UTF-8");
		
		try (PrintWriter out = response.getWriter())
		{
			String name = request.getParameter("login_nome");
			String cognome = request.getParameter("login_cognome");
			String email = request.getParameter("login_email");
			String password = request.getParameter("login_password");
			name = name + " "+ cognome;
			
			
			try {
				UtenteDao udao = new UtenteDao(ConnectToDB.getConnection());
				boolean x = udao.UserCheck(email);
				
				if(x)
				{
					out.println("<html><head>");
				    out.println("<meta http-equiv='refresh' content='2;url=" 
				                + request.getContextPath() + "/LoginAndRegistration.jsp'>");
				    out.println("</head><body>");
				    out.println("<h2>Registrazione fallita Email già presente</h2>");
				    out.println("</body></html>");
				}
				else
				{
					boolean y = udao.userRegistration(name,email,password);
					
					if(y)
					{
						out.println("<html><head>");
					    out.println("<meta http-equiv='refresh' content='2;url=" 
					                + request.getContextPath() + "/LoginAndRegistration.jsp'>");
					    out.println("</head><body>");
					    out.println("<h2>Registrazione effettuata, effettua il login</h2>");
					    out.println("</body></html>");
					}
					else
					{
						out.println("<html><head>");
					    out.println("<meta http-equiv='refresh' content='2;url=" 
					                + request.getContextPath() + "/LoginAndRegistration.jsp'>");
					    out.println("</head><body>");
					    out.println("<h2>Registrazione fallita, riprova</h2>");
					    out.println("</body></html>");
					}
				}
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		
		}
	}

}