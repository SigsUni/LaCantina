package it.unisa.lacantina.controller.UserControl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import it.unisa.lacantina.model.dao.UtenteDao;
import it.unisa.lacantina.model.domain.Utente;
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    response.setContentType("text/html;charset=UTF-8");

	    // Leggo i parametri
	    String nome = request.getParameter("login_nome");
	    String cognome = request.getParameter("login_cognome");
	    String email = request.getParameter("login_email");
	    String password = request.getParameter("login_password");

	    // Validazione campi non vuoti
	    if (nome == null || nome.isEmpty() || cognome == null || cognome.isEmpty() ||
	        email == null || email.isEmpty() || password == null || password.isEmpty()) {
	        
	        request.setAttribute("errorMessage", "Tutti i campi sono obbligatori");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	        return;
	    }

	    // Unisco nome e cognome
	    String fullName = nome + " " + cognome;

	    // Regex per email
	    String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
	    if (!email.matches(emailRegex)) {
	        request.setAttribute("errorMessage", "Email non valida");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	        return;
	    }

	    // Regex per password
	    String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
	    if (!password.matches(passwordRegex)) {
	        request.setAttribute("errorMessage", "Password non valida. Deve contenere almeno 8 caratteri, una maiuscola, una minuscola, un numero e un carattere speciale.");
	        request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	        return;
	    }

	    // Connessione al DB sicura
	    try (Connection con = ConnectToDB.getConnection()) {
	        if (con == null) {
	            request.setAttribute("errorMessage", "Errore di connessione al database");
	            request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	            return;
	        }

	        UtenteDao udao = new UtenteDao(con);

	        // Controllo se l'email esiste già
	        if (udao.UserCheck(email)) {
	            request.setAttribute("errorMessage", "Registrazione fallita, Email già presente");
	            request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	            return;
	        }

	        // Registro l'utente
	        boolean registered = udao.userRegistration(fullName, email, password);
	        if (!registered) {
	            request.setAttribute("errorMessage", "Registrazione fallita, riprova");
	            request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
	            return;
	        }

	        // Recupero utente registrato e lo salvo in sessione
	        Utente user = udao.getSingleUtente(email);
	        request.getSession().setAttribute("auth", user);
	        request.setAttribute("successMessage", "Registrazione e login effettuati con successo");
	        request.getRequestDispatcher("/success_generico.jsp").forward(request, response);

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