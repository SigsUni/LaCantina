<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Utente auth = (Utente)request.getSession().getAttribute("auth"); 
    if(auth == null) {
        response.sendRedirect("/LaCantinav2/LoginAndRegistration.jsp");
        return;
    }
    
    // Recupero Parametri
    String pId = request.getParameter("id");
    String pNome = request.getParameter("nome");
    String pQuantity = request.getParameter("quantity");
    String pPrezzo = request.getParameter("prezzo");
%>  

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acquisto Singolo - La Cantina</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="./CSS/checkout.css" rel="stylesheet" type="text/css">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>
    
    <div class="container">
        <div class="card card-checkout w-75 mx-auto"> 
            
            <div class="main-header">
                Completa il tuo Acquisto
                <h6><i class="fas fa-info-circle"></i> Ordine rapido di un singolo prodotto</h6>
            </div>
            
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/order-now" method="POST">
                
                    <div class="form-group mb-5">
                        <div class="section-title">
                            <span><i class="fas fa-receipt"></i> Riepilogo</span>
                            <span class="badge bg-success">Totale: € <%= pPrezzo %></span>
                        </div>
                        
                        <div class="cart-summary-container">
                            <div class="row align-items-center">
                                <input type="hidden" name="insert-id" value="<%= pId %>">
                                
                                <div class="col-md-6">
                                    <label class="small text-muted">Prodotto</label>
                                    <input type="text" class="form-control form-control-sm input-transparent" value="<%= pNome %>" readonly>
                                </div>
                                <div class="col-md-3">
                                    <label class="small text-muted">Quantità</label>
                                    <input type="text" class="form-control form-control-sm input-transparent" name="insert-quantity" value="<%= pQuantity %>" readonly>
                                </div>
                                <div class="col-md-3 text-end">
                                    <label class="small text-muted">Prezzo</label>
                                    <input type="text" class="form-control form-control-sm input-transparent input-price" name="insert-prezzo" value="<%= pPrezzo %>" readonly>
                                </div>
                            </div>
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
                                <input type="text" class="form-control" name="insert-indirizzo" placeholder="Via Roma, 1" required>
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
                            <button type="submit" class="btn-confirm">Conferma Ordine <i class="fas fa-check"></i></button>
                        </div>
                    </div>
                    
                </form>
                <script src="<%= request.getContextPath() %>/JS/AcquistoProdottoValidation.js"></script>
            </div>
        </div>
    </div>
    <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>