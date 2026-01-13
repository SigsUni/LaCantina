<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Utente auth = (Utente)request.getSession().getAttribute("auth"); 
          
    if(auth!=null) {
        request.setAttribute("auth",auth);
    } else {
        response.sendRedirect("/LaCantinav2/index.jsp");
        return; // Importante fermare l'esecuzione dopo il redirect
    }
    
    ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
    
    if(cart_list!=null) {   
        request.setAttribute("cart_list",cart_list);
    }
    
    RigaOrdineDao riga_ordine = new RigaOrdineDao(ConnectToDB.getConnection());
    // Controllo ID per evitare errori
    String idParam = request.getParameter("id");
    if(idParam == null || idParam.isEmpty()) {
        response.sendRedirect("ordini.jsp");
        return;
    }
    RigaOrdine info_ordine = riga_ordine.getInfoById(Integer.parseInt(idParam));
%>  

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Ordine - La Cantina</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
    
    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link href="./CSS/manage-order.css" rel="stylesheet" type="text/css">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="page-wrapper">
        
        <div class="page-header-content">
            <h1 class="page-title">Dettagli Ordine</h1>
        </div>

        <div class="card-manage">
            
            <div class="card-header-custom">
                Gestisci qui il tuo ordine, <%= auth.getName() %>
                <h6>
                    <i class='bx bx-info-circle'></i> 
                    Se lo stato è spedito o consegnato, le modifiche sono disabilitate.
                </h6>
            </div>
            
            <div class="card-body-custom">
            
            <% if(info_ordine.getStatoOrdine().equals("attesa di conferma") || info_ordine.getStatoOrdine().equals("preso in carico")){ %>
                
                <form action="<%= request.getContextPath() %>/modifica-dati" method="POST">
                    
                    <div class="mb-3">
                        <label>ID Ordine</label>
                        <input type="text" class="form-control" name="insert-id" value="<%=info_ordine.getId() %>" readonly>
                    </div>

                    <div class="mb-3">
                        <label>Indirizzo di Spedizione</label>
                        <input type="text" class="form-control" name="insert-indirizzo" id="insert-indirizzo" value="<%=info_ordine.getIndirizzo() %>" required>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label>CAP</label>
                            <input type="text" class="form-control" name="insert-cap" id="insert-cap" value="<%=info_ordine.getCap() %>" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Città</label>
                            <input type="text" class="form-control" name="insert-citta" id="insert-citta" value="<%=info_ordine.getCitta() %>" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Provincia</label>
                            <input type="text" class="form-control" name="insert-provincia" id="insert-provincia" value="<%=info_ordine.getProvincia() %>" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label>Prezzo Totale (€)</label>
                        <input type="text" class="form-control" name="insert-prezzo" id="insert-prezzo" value="<%= String.format("%.2f", info_ordine.getPrezzoTotale()) %>" readonly>
                    </div>

                    <div class="mb-4">
                        <label for="stato_ordine">Stato Ordine:</label>
                        <select id="stato_ordine" name="stato_ordine" class="form-select">
                            <option value="<%=info_ordine.getStatoOrdine() %>" selected><%=info_ordine.getStatoOrdine() %></option>
                            <option value="annullato">Richiedi Annullamento</option>
                        </select>
                    </div>

                    <button type="submit" class="btn-confirm">
                        CONFERMA MODIFICHE <i class='bx bx-check'></i>
                    </button>
                </form>
                
                <script src="<%= request.getContextPath() %>/JS/GestisciOrdineValidation.js"></script>

            <% } else { %>
                
                <form>
                    <div class="mb-3">
                        <label>ID Ordine</label>
                        <input type="text" class="form-control" value="<%=info_ordine.getId() %>" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label>Indirizzo</label>
                        <input type="text" class="form-control" value="<%=info_ordine.getIndirizzo() %>" readonly>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label>CAP</label>
                            <input type="text" class="form-control" value="<%=info_ordine.getCap() %>" readonly>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Città</label>
                            <input type="text" class="form-control" value="<%=info_ordine.getCitta() %>" readonly>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Provincia</label>
                            <input type="text" class="form-control" value="<%=info_ordine.getProvincia() %>" readonly>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label>Prezzo Totale (€)</label>
                        <input type="text" class="form-control" value="<%= String.format("%.2f", info_ordine.getPrezzoTotale()) %>" readonly>
                    </div>

                    <div class="mb-3">
                        <label>Stato Attuale</label>
                        <div class="form-control" style="background: #eef; color: #2a6973; font-weight: bold;">
                            <%=info_ordine.getStatoOrdine().toUpperCase() %>
                        </div>
                    </div>
                </form>
                
            <% } %>

            </div> </div> </div> <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>