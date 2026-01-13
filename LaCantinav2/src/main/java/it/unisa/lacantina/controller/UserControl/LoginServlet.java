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
import java.sql.Connection;
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

	    // VALIDAZIONE PARAMETRI
	    if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
	        request.setAttribute("errorMessage", "Email e password obbligatorie");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	        return;
	    }

	    // CONNESSIONE AL DB IN TRY-WITH-RESOURCES
	    try (Connection con = ConnectToDB.getConnection()) {

	        if (con == null) {
	            request.setAttribute("errorMessage", "Errore di connessione al database");
	            request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	            return;
	        }

	        UtenteDao udao = new UtenteDao(con);
	        Utente user = udao.userLogin(email, password);

	        if (user != null) {
	            // SALVO UTENTE IN SESSIONE
	            request.getSession().setAttribute("auth", user);

	            // MESSAGGIO SUCCESSO
	            if (user.getID() != 2) {
	                request.setAttribute("successMessage", "Login Effettuato con successo");
	            } else {
	                request.setAttribute("successMessage", "Benvenuto Admin");
	            }

	            request.getRequestDispatcher("/success_generico.jsp").forward(request, response);
	            return;
	        }

	        // UTENTE NON TROVATO
	        request.setAttribute("errorMessage", "Credenziali Errate, riprova");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);

	    } catch (SQLException e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Errore del database, riprova più tardi");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Errore interno, riprova più tardi");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	    }
	}

}
