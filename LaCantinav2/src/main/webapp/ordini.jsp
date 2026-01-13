<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import="java.util.*" %>

<%
    // Verifica Utente
    Utente auth = (Utente)request.getSession().getAttribute("auth"); 
    List<Ordine> ordini = null;
    
    if(auth != null) {
        request.setAttribute("auth",auth);
        // Recupero Ordini dal DB
        try {
            ordini = new OrdineDao(ConnectToDB.getConnection()).userOrders(auth.getID());
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("LoginAndRegistration.jsp");
        return; 
    }
    
    // Recupero Carrello per icona header (opzionale)
    ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
    if(cart_list != null){
        request.setAttribute("cart_list", cart_list);
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>I miei Ordini - La Cantina</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link href="./CSS/orders.css" rel="stylesheet" type="text/css">
    
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="page-wrapper">
        
        <div class="page-header-content">
            <h1 class="page-title">Storico Ordini</h1>
            <p class="page-subtitle">Il riepilogo dei tuoi acquisti presso La Cantina</p>
        </div>

        <div class="orders-card watch fade-in">
            
            <% if(ordini != null && !ordini.isEmpty()){ %>
                <div class="table-responsive">
                    <table class="table custom-table">
                        <thead>
                            <tr>
                                <th scope="col">ID Ordine</th>
                                <th scope="col">Data</th>
                                <th scope="col" style="text-align: left; padding-left: 40px;">Prodotto</th>
                                <th scope="col">Prezzo</th>
                                <th scope="col">Quantità</th>
                                <th scope="col">Azioni</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(Ordine o : ordini){ %>
                            <tr>
                                <td><strong>#<%= o.getIdRigaOrdine() %></strong></td>
                                
                                <td><%= o.getData() %></td>
                                
                                <td class="product-name-cell">
                                    <%= o.getProdotto().getNome() %>
                                </td>
                                
                                <td style="color: #2a6973; font-weight: bold;">
                                    € <%= String.format("%.2f", o.getProdotto().getPrezzo()) %>
                                </td>
                                
                                <td>
                                    <span class="badge bg-secondary rounded-pill" style="font-size: 0.9rem; padding: 8px 12px;">
                                        <%= o.getQuantity() %>
                                    </span>
                                </td>
                                
                                <td>
                                    <a class="btn-manage" href="<%= request.getContextPath() %>/gestisci_ordine.jsp?id=<%= o.getIdRigaOrdine() %>">
                                        <i class='bx bx-cog'></i> Gestisci
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                
                <div class="empty-state">
                    <i class='bx bx-shopping-bag' style="font-size: 5rem; color: #eee;"></i>
                    <h3 style="margin-top: 20px; color: #555;">Nessun ordine trovato</h3>
                    <p style="color: #999;">Non hai ancora acquistato nulla.</p>
                    <a href="index.jsp" class="btn-manage" style="background: #2a6973; color: white; margin-top: 15px;">
                        Vai allo Shopping
                    </a>
                </div>
                
            <% } %>
            
        </div>
    </div>

    <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>
</body>
</html>