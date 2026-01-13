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


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    response.setContentType("text/html;charset=UTF-8");

	    String email = request.getParameter("email");
	    String password = request.getParameter("password");

	    try {
	        UtenteDao udao = new UtenteDao(ConnectToDB.getConnection());
	        Utente user = udao.userLogin(email, password);

	        if (user != null) {
	            request.getSession().setAttribute("auth", user);

	            if (user.getID() != 2) {
	                request.setAttribute("successMessage", "Login Effettuato con successo");
	            } else {
	                request.setAttribute("successMessage", "Benvenuto Admin");
	            }

	            request.getRequestDispatcher("/success_generico.jsp").forward(request, response);
	            return;
	        }

	        request.setAttribute("errorMessage", "Credenziali Errate, riprova");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Errore interno, riprova più tardi");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	    }
	}


}
