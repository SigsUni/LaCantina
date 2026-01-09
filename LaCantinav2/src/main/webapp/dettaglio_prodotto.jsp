<%@page import="it.unisa.lacantina.model.domain.Utente"%>
<%@page import="it.unisa.lacantina.model.domain.Carrello"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // --- SIMULAZIONE DATI ---
    String nomeProdotto = "Vino Rosso Riserva";
    String descProdotto = "Un vino eccezionale prodotto con uve selezionate. "
            + "Invecchiato per 24 mesi in botti di rovere, presenta note di frutti di bosco, spezie e vaniglia. "
            + "Perfetto da abbinare a carni rosse e formaggi stagionati. Gradazione 14%.";
    String prezzoProdotto = "24.50";
    String imgProdotto = "IMG/vino_rosso.png"; 
    String categoria = "Vini Rossi";
    String id = request.getParameter("id"); 
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= nomeProdotto %> - La Cantina</title>
    
    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link href="./CSS/product-detail.css" rel="stylesheet" type="text/css">
    
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="product-container watch fade-in">
        
        <div class="product-image-col">
            <img src="<%= imgProdotto %>" alt="Immagine Prodotto" onerror="this.src='https://via.placeholder.com/400x500?text=No+Image'">
        </div>

        <div class="product-info-col">
            <div class="product-category"><%= categoria %></div>
            <h1 class="product-title"><%= nomeProdotto %></h1>
            <div class="product-price">€ <%= prezzoProdotto %></div>
            
            <div class="product-description">
                <p><%= descProdotto %></p>
            </div>

            <form action="add-to-cart" method="post" class="cart-action">
                <input type="hidden" name="id" value="<%= id != null ? id : "0" %>">
                
                <label for="quantity" style="font-weight: bold;">Quantità:</label>
                <input type="number" id="quantity" name="quantity" class="qty-input" value="1" min="1" max="10">
                
                <button type="submit" class="btn-add-cart">
                    <i class='bx bx-cart-add'></i> AGGIUNGI AL CARRELLO
                </button>
            </form>
            
            <div style="margin-top: 20px; font-size: 0.9rem; color: #888;">
                <i class='bx bx-check-circle' style="color: green;"></i> Disponibilità Immediata<br>
                <i class='bx bx-truck'></i> Spedizione in 24/48h
            </div>
        </div>

    </div>

    <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>
</body>
</html>