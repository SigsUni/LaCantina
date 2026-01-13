<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import="it.unisa.lacantina.model.service.*" %>
<%@page import="java.util.*" %>

<%
    // Recupero Utente
    Utente auth = (Utente)request.getSession().getAttribute("auth"); 
    if(auth != null) {
        request.setAttribute("auth",auth);
    }
    
    // Recupero Carrello dalla Sessione
    ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
    float totale = 0;
    
    // Calcolo Totale
    if(cart_list != null && !cart_list.isEmpty()){
        try {
            CarrelloService cService = new CarrelloService();
            totale = cService.getTotalCartPrice(cart_list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("cart_list", cart_list);
        request.setAttribute("totale", totale); 
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il tuo Carrello - La Cantina</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">

    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link href="./CSS/cart.css" rel="stylesheet" type="text/css">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="page-wrapper">
        
        <div class="page-header-content">
            <h1 class="page-title">Il tuo Carrello</h1>
            <p class="text-muted">Rivedi i prodotti selezionati prima dell'acquisto</p>
        </div>

        <div class="cart-card">
            
            <% if (cart_list != null && !cart_list.isEmpty()) { %>
            
            <div class="table-responsive">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th scope="col" style="text-align: left; padding-left:30px;">Prodotto</th>
                            <th scope="col">Prezzo Singolo</th>
                            <th scope="col">Quantità & Azioni</th>
                            <th scope="col">Rimuovi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        for(Carrello c : cart_list) { 
                            // Controllo di sicurezza per evitare errori (pagina bianca)
                            if(c == null || c.getProdotto() == null) continue;
                        %>
                        <tr>
                            <td style="text-align: left; padding-left:30px;">
                                <span class="product-name"><%= c.getProdotto().getNome() %></span>
                                <span class="product-cat"><%= c.getProdotto().getCategoria() %></span>
                            </td>
                            
                            <td style="font-weight: 600; color:#2a6973;">
                                € <%= String.format("%.2f", c.getProdotto().getPrezzo()) %>
                            </td>
                            
                            <td> 
                                <form method="post" action="<%= request.getContextPath() %>/acquisto_singolo_prodotto.jsp" class="d-flex justify-content-center align-items-center">
                                    
                                    <input type="hidden" name="id" value="<%= c.getProdotto().getId() %>">
                                    <input type="hidden" name="prezzo" value="<%= c.getProdotto().getPrezzo() %>">
                                    <input type="hidden" name="nome" value ="<%=c.getProdotto().getNome()%>">

                                    <div class="d-flex align-items-center bg-light rounded-pill px-2 py-1 border">
                                        <a class="btn-qty" href="quantity-inc-dec?action=dec&id=<%=c.getProdotto().getId()%>">
                                            <i class="fas fa-minus-circle"></i>
                                        </a>

                                        <input type="text" name="quantity" class="qty-input bg-transparent border-0" value="<%= c.getQuantity() %>" readonly>

                                        <% if (c.getProdotto().checkStock(c.getQuantity() + 1)) { %>
                                            <a class="btn-qty" href="quantity-inc-dec?action=inc&id=<%=c.getProdotto().getId()%>">
                                                <i class="fas fa-plus-circle"></i>
                                            </a>
                                        <% } else { %>
                                            <span class="btn-qty text-muted" style="cursor:not-allowed"><i class="fas fa-plus-circle"></i></span>
                                        <% } %>
                                    </div>
                                    
                                    <button type="submit" class="btn-buy-single" title="Compra solo questo prodotto">
                                        Acquista <i class='bx bx-check'></i>
                                    </button>
                                </form>
                            </td>
                            
                            <td>
                                <a class="btn-remove" href="remove-from-cart?id=<%=c.getProdotto().getId()%>">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="cart-footer">
                <div>
                    <span class="total-label">Totale Carrello:</span>
                    <span class="total-price">€ <%= (totale > 0) ? String.format("%.2f", totale) : "0.00" %></span>
                </div>
                
                <a class="btn-checkout" href="<%=request.getContextPath()%>/acquisto_carrello.jsp">
                    Procedi al Checkout <i class='bx bx-right-arrow-alt'></i>
                </a>
            </div>

            <% } else { %>
                
                <div class="empty-cart-msg">
                    <i class='bx bx-cart' style="font-size: 5rem; color: #ddd; margin-bottom: 20px;"></i>
                    <h3>Il tuo carrello è vuoto</h3>
                    <p>Sembra che tu non abbia ancora aggiunto prodotti.</p>
                    <a href="index.jsp" class="btn-checkout" style="margin-top: 20px; display:inline-block;">Torna allo Shop</a>
                </div>
                
            <% } %>

        </div>
    </div>

    <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>