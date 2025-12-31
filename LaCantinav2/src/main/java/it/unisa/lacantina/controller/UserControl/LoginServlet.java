package it.unisa.lacantina.controller.UserControl;
import it.unisa.lacantina.model.dao.UtenteDao;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.util.ConnectToDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.sendRedirect("index.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			out.print(email+password);
			UtenteDao udao = new UtenteDao(ConnectToDB.getConnection());
			Utente user = udao.userLogin(email, password);
			
			if(user!=null)
			{
				request.getSession().setAttribute("auth", user);
				
				out.println("<html><head>");
				if(user.getID()!=2) {
			    out.println("<meta http-equiv='refresh' content='2;url=" 
			                + request.getContextPath() + "/index.jsp'>");
			    out.println("</head><body>");
			    out.println("<h2>Login effettuato!</h2>");
			    out.println("</body></html>");
			    }
				else 
				{
					response.sendRedirect("/LaCantinav2/admin-pages/admin_index.jsp");
				}
			    out.println("</head><body>");
			    out.println("<h2>Login effettuato!</h2>");
			    out.println("</body></html>");
			}
			else
			{
				out.println("<html><head>");
			    out.println("<meta http-equiv='refresh' content='3;url=" 
			                + request.getContextPath() + "/LoginAndRegistration.jsp'>");
			    out.println("</head><body>");
			    out.println("<h2>Login errato!</h2>");
			    out.println("<p>Verrai reindirizzato alla pagina precedente tra 3 secondi... ritenta</p>");
			    out.println("</body></html>");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
