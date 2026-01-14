<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.model.service.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Utente auth = (Utente)request.getSession().getAttribute("auth"); 
    if(auth == null) {
        response.sendRedirect("/LaCantinav2/LoginAndRegistration.jsp");
        return;
    }
    
    ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
    float totale = 0;
    
    if(cart_list != null) {    
        CarrelloService cService = new CarrelloService();
        totale = cService.getTotalCartPrice(cart_list);
        request.setAttribute("cart_list", cart_list);
        request.setAttribute("totale", totale); 
    }
%>  

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout Carrello - La Cantina</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="./CSS/checkout.css" rel="stylesheet" type="text/css">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>
    
    <div class="page-wrapper">
        
        <div class="card-checkout">
        
            <div class="main-header">
                Conferma Ordine Carrello
                <h6><i class="fas fa-info-circle"></i> Controlla gli articoli prima di pagare</h6>
            </div>
            
            <div class="card-body">
                <form action="<%=request.getContextPath()%>/check-out" method="POST">

                    <div class="form-group mb-5">
                        <div class="section-title">
                            <span><i class="fas fa-shopping-basket"></i> Articoli nel Carrello</span>
                            <span class="badge bg-success" style="font-size: 1rem;">
                                Totale: € <%= (totale > 0) ? String.format("%.2f", totale) : "0.00" %>
                            </span>
                        </div>
                        
                        <div class="cart-summary-container">
                        <%
                        if (cart_list != null && !cart_list.isEmpty()){
                            for(Carrello c : cart_list){
                        %>
                            <div class="cart-item-row row align-items-center">
                                <input type="hidden" name="insert-id" value="<%=c.getProdotto().getId()%>">
                                
                                <div class="col-md-5">
                                    <label class="small text-muted">Prodotto</label>
                                    <input type="text" class="form-control form-control-sm input-transparent" 
                                           name="insert-nome" value="<%=c.getProdotto().getNome()%>" readonly>
                                </div>
                                
                                <div class="col-md-3">
                                    <label class="small text-muted">Quantità</label>
                                    <input type="text" class="form-control form-control-sm input-transparent" 
                                           name="insert-quantity" value="<%=c.getQuantity() %>" readonly>
                                </div>
                                
                                <div class="col-md-4 text-end">
                                    <label class="small text-muted">Prezzo Unitario</label>
                                    <input type="text" class="form-control form-control-sm input-transparent input-price" 
                                           name="insert-prezzo" value="€ <%=c.getProdotto().getPrezzo()%>" readonly>
                                </div>
                            </div>
                        <%  
                            }
                        } else { 
                        %>
                            <div class="text-center py-3 text-muted">Il carrello è vuoto.</div>
                        <% } %>
                        </div>
                    </div>

                    <div class="form-group mb-5">
                        <div class="section-title"><i class="far fa-credit-card"></i> Pagamento</div>
                        <div class="row g-3">
                            <div class="col-12">
                                <label>Numero Carta</label>
                                <input type="text" class="form-control" name="insert-indirizzo-carta" placeholder="0000 0000 0000 0000" required>
                            </div>
                            <div class="col-12">
                                <label>Intestatario</label>
                                <input type="text" class="form-control" name="insert-intestatario" placeholder="MARIO ROSSI" required>
                            </div>
                            <div class="col-md-6">
                                <label>Scadenza</label>
                                <input type="text" class="form-control" name="insert-scadenza" placeholder="MM/AA" required>
                            </div>
                            <div class="col-md-6">
                                <label>CVV</label>
                                <input type="password" class="form-control" name="insert-cvv" placeholder="***" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="section-title"><i class="fas fa-shipping-fast"></i> Spedizione</div>
                        <div class="row g-3">
                            <div class="col-12">
                                <label>Indirizzo</label>
                                <input type="text" class="form-control" name="insert-indirizzo" placeholder="Via Roma, 10" required>
                            </div>
                            <div class="col-md-4">
                                <label>CAP</label>
                                <input type="text" class="form-control" name="insert-cap" placeholder="00000" required>
                            </div>
                            <div class="col-md-4">
                                <label>Città</label>
                                <input type="text" class="form-control" name="insert-citta" placeholder="Città" required>
                            </div>
                            <div class="col-md-4">
                                <label>Provincia</label>
                                <input type="text" class="form-control" name="insert-provincia" placeholder="PR" required>
                            </div>
                        </div>
                        
                        <div class="mt-5">
                            <button type="submit" class="btn-confirm">
                                Paga Ora (€ <%= (totale > 0) ? String.format("%.2f", totale) : "0.00" %>) <i class="fas fa-check"></i>
                            </button>
                        </div>
                    </div>
                    
                </form>
                <script src="<%= request.getContextPath() %>/JS/AcquistoMultiploProdottoValidation.js"></script>
            </div>
        </div> </div> <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>