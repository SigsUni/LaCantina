package it.unisa.lacantina.controller.OrderControl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import it.unisa.lacantina.model.dao.OrdineDao;
import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.model.dao.RigaOrdineDao;
import it.unisa.lacantina.model.domain.Carrello;
import it.unisa.lacantina.model.domain.Ordine;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.util.ConnectToDB;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Connection con = null;

	    try {
	        // CONTROLLI PRELIMINARI
	        HttpSession session = request.getSession(false);
	        if (session == null) {
	            response.sendRedirect("LoginAndRegistration.jsp");
	            return;
	        }

	        Utente auth = (Utente) session.getAttribute("auth");
	        ArrayList<Carrello> cart_list =
	                (ArrayList<Carrello>) session.getAttribute("cart-list");

	        if (auth == null) {
	            response.sendRedirect("LoginAndRegistration.jsp");
	            return;
	        }

	        if (cart_list == null || cart_list.isEmpty()) {
	            response.sendRedirect("carrello.jsp");
	            return;
	        }

	        String indirizzo = request.getParameter("insert-indirizzo");
	        String provincia = request.getParameter("insert-provincia");
	        String cap = request.getParameter("insert-cap");
	        String citta = request.getParameter("insert-citta");

	        if (indirizzo == null || cap == null || citta == null || provincia == null) {
	            throw new Exception("Dati di spedizione mancanti");
	        }

	        // CONNESSIONE AL DB
	        con = ConnectToDB.getConnection();
	        if (con == null) {
	            throw new Exception("Connessione al database non disponibile");
	        }

	        con.setAutoCommit(false); // TRANSAZIONE

	        // CALCOLO TOTALE
	        float prezzo_totale = 0;
	        int num_oggetti = 0;

	        for (Carrello c : cart_list) {
	            prezzo_totale += c.getProdotto().getPrezzo() * c.getQuantity();
	            num_oggetti += c.getQuantity();
	        }

	        //INSERIMENTO RIGA ORDINE
	        RigaOrdineDao rigaDao = new RigaOrdineDao(con);
	        int id_riga_ordine = rigaDao.nuovaRigaOrdine(
	                indirizzo, cap, citta, provincia,
	                prezzo_totale, num_oggetti
	        );

	        if (id_riga_ordine <= 0) {
	            throw new Exception("Errore creazione riga ordine");
	        }

	        // INSERIMENTO ORDINI + STOCK
	        OrdineDao ordineDao = new OrdineDao(con);
	        ProdottoDao prodottoDao = new ProdottoDao(con);

	        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	        String data = formatter.format(new Date());

	        for (Carrello c : cart_list) {

	            int idProdotto = c.getProdotto().getId();
	            int qty = c.getQuantity();

	            int stockAttuale = prodottoDao.getStockFromId(idProdotto);
	            if (stockAttuale < qty) {
	                throw new Exception("Stock insufficiente per il prodotto ID " + idProdotto);
	            }

	            Ordine ordine = new Ordine();
	            ordine.setId_prodotto(idProdotto);
	            ordine.setId_utente(auth.getID());
	            ordine.setQuantity(qty);
	            ordine.setData(data);
	            ordine.setIdRigaOrdine(id_riga_ordine);
	            ordine.setPrezzoAcquisto(c.getProdotto().getPrezzo() * qty);

	            boolean ordineInserito = ordineDao.insertOrder(ordine);
	            if (!ordineInserito) {
	                throw new Exception("Errore inserimento ordine");
	            }

	            boolean stockAggiornato =
	                    prodottoDao.setNewStock(idProdotto, stockAttuale - qty);

	            if (!stockAggiornato) {
	                throw new Exception("Errore aggiornamento stock");
	            }
	        }

	        // COMMIT
	        con.commit();

	        // Svuoto carrello solo dopo successo
	        cart_list.clear();
	        session.setAttribute("cart-list", cart_list);

	        response.sendRedirect("ordini.jsp");

	    } catch (Exception e) {

	        // ROLLBACK
	        if (con != null) {
	            try {
	                con.rollback();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }

	        e.printStackTrace();

	        request.setAttribute("errorMessage",
	                "Errore durante il checkout: " + e.getMessage());
	        request.getRequestDispatcher("/errore_generico.jsp")
	                .forward(request, response);

	    } finally {

	        // CHIUSURA CONNESSIONE
	        if (con != null) {
	            try {
	                con.setAutoCommit(true);
	                con.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
		
	}

}
