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
import java.util.ArrayList;
import java.util.Date;

import it.unisa.lacantina.model.dao.OrdineDao;
import it.unisa.lacantina.model.dao.ProdottoDao;
import it.unisa.lacantina.model.dao.RigaOrdineDao;
import it.unisa.lacantina.model.domain.Carrello;
import it.unisa.lacantina.model.domain.Ordine;
import it.unisa.lacantina.model.domain.Prodotto;
import it.unisa.lacantina.model.domain.RigaOrdine;
import it.unisa.lacantina.model.domain.Utente;
import it.unisa.lacantina.util.ConnectToDB;

/**
 * Servlet implementation class OrderNowServlet
 */
@WebServlet("/order-now")
public class OrderNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    	

        Connection con = null;

        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect("LoginAndRegistration.jsp");
                return;
            }

            Utente auth = (Utente) session.getAttribute("auth");
            if (auth == null) {
                response.sendRedirect("LoginAndRegistration.jsp");
                return;
            }

            // PARAMETRI
            int prodottoId = Integer.parseInt(request.getParameter("insert-id"));
            int quantity = Integer.parseInt(request.getParameter("insert-quantity"));
            String indirizzo = request.getParameter("insert-indirizzo");
            String cap = request.getParameter("insert-cap");
            String citta = request.getParameter("insert-citta");
            String provincia = request.getParameter("insert-provincia");

            if (quantity <= 0 || indirizzo == null || cap == null || citta == null || provincia == null) {
                throw new Exception("Dati ordine non validi");
            }

            con = ConnectToDB.getConnection();
            if (con == null) {
                throw new Exception("Connessione al database non disponibile");
            }

            con.setAutoCommit(false);

            ProdottoDao prodottoDao = new ProdottoDao(con);
            OrdineDao ordineDao = new OrdineDao(con);
            RigaOrdineDao rigaDao = new RigaOrdineDao(con);

            int stockAttuale = prodottoDao.getStockFromId(prodottoId);
            if (stockAttuale < quantity) {
                throw new Exception("Stock insufficiente");
            }

            float prezzoProdotto = prodottoDao.getSingleProdotto(prodottoId).getPrezzo();
            float prezzoTotale = prezzoProdotto * quantity;

            // CREAZIONE RIGA ORDINE
            int idRigaOrdine = rigaDao.nuovaRigaOrdine(
                    indirizzo, cap, citta, provincia, prezzoTotale, quantity
            );

            if (idRigaOrdine <= 0) {
                throw new Exception("Errore creazione riga ordine");
            }

            // CREAZIONE ORDINE
            Ordine ordine = new Ordine();
            ordine.setId_prodotto(prodottoId);
            ordine.setId_utente(auth.getID());
            ordine.setQuantity(quantity);
            ordine.setPrezzoAcquisto(prezzoTotale);
            ordine.setIdRigaOrdine(idRigaOrdine);
            ordine.setData(new SimpleDateFormat("dd/MM/yyyy").format(new Date()));

            if (!ordineDao.insertOrder(ordine)) {
                throw new Exception("Errore inserimento ordine");
            }

            // AGGIORNAMENTO STOCK
            if (!prodottoDao.setNewStock(prodottoId, stockAttuale - quantity)) {
                throw new Exception("Errore aggiornamento stock");
            }

            con.commit();

            // RIMOZIONE DAL CARRELLO (DOPO COMMIT)
            ArrayList<Carrello> cart =
                    (ArrayList<Carrello>) session.getAttribute("cart-list");

            if (cart != null) {
                cart.removeIf(c -> c.getProdotto().getId() == prodottoId);
            }

            response.sendRedirect("ordini.jsp");

        } catch (Exception e) {

            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            e.printStackTrace();
            request.setAttribute("errorMessage","Errore durante l'ordine: " + e.getMessage());
            try {
				request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
			} catch (ServletException | IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

        } finally {
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