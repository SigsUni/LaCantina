<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Utente auth = (Utente)request.getSession().getAttribute("auth"); 
if(auth != null) {
    request.setAttribute("auth",auth);
} 

String categoriaSelezionata = request.getParameter("categoria");
if(categoriaSelezionata == null){
    categoriaSelezionata = "tutto";
}

ProdottoDao pd = new ProdottoDao(ConnectToDB.getConnection());
List<Prodotto> prodotti = pd.getAllProdotti();

FornitoreDao fdao = new FornitoreDao(ConnectToDB.getConnection());

ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
if(cart_list != null){
    request.setAttribute("cart_list", cart_list);
}





    // --- SIMULAZIONE DATI ---
    String descProdottoVinoRosso = "Un vino eccezionale prodotto con uve selezionate. "
            + "Invecchiato per 24 mesi in botti di rovere, presenta note di frutti di bosco, spezie e vaniglia. "
            + "Perfetto da abbinare a carni rosse e formaggi stagionati. Gradazione 14%.";
    
    String descProdottoLimoncello = "Un liquore artigianale ottenuto da limoni selezionati. "
            + "Preparato secondo la tradizione, sprigiona intense note agrumate e un gusto fresco e armonioso. "
            + "Ideale da gustare freddo a fine pasto o come base per cocktail. Gradazione 30%.";
    
    String descProdottoOlio = "Un olio extra vergine di oliva di alta qualità ottenuto da olive accuratamente selezionate. "
            + "Estratto a freddo, presenta un profilo aromatico equilibrato con sentori erbacei e note di mandorla. "
            + "Perfetto per esaltare piatti a crudo, verdure e cucina mediterranea.";
    
    String descProdottoVinoBianco = "Un vino bianco raffinato prodotto con uve selezionate. "
            + "Vinificato a temperatura controllata, offre profumi floreali e note di frutta fresca. "
            + "Ideale in abbinamento a piatti di pesce, crostacei e formaggi freschi. Gradazione 12,5%.";
    int id = Integer.parseInt(request.getParameter("id")); 
    
    
    
    
    Prodotto p = pd.getSingleProdotto(id);
    Fornitore f = fdao.getSingleFornitore(p.getIdFornitore());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= p.getNome() %> - La Cantina</title>
    
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
            <img src="<%= request.getContextPath() %>/IMG/<%= p.getImmagine() %>"  alt="Immagine Prodotto" onerror="this.src='https://via.placeholder.com/400x500?text=No+Image'">
        </div>

        <div class="product-info-col">
            <div class="product-category"><%= p.getCategoria() %></div>
            <h1 class="product-title"><%= p.getNome() %></h1>
            <div class="product-price">€ <%= p.getPrezzo() %></div>
            
            <div class="product-description">
                <p><%= p.getDescrizione()%></p>
            </div>
            
            <%if(p.getCategoria().equals("vino-rosso")){ %>
            <div class="product-description">
                <p><%= descProdottoVinoRosso%></p>
            </div>
            <%} %>
            
             <%if(p.getCategoria().equals("olio-extravergine-oliva")){ %>
            <div class="product-description">
                <p><%= descProdottoOlio%></p>
            </div>
            <%} %>
            
            <%if(p.getCategoria().equals("vino-bianco")){ %>
            <div class="product-description">
                <p><%= descProdottoVinoBianco%></p>
            </div>
            <%} %>
            
            <%if(p.getCategoria().equals("limoncello")){ %>
            <div class="product-description">
                <p><%= descProdottoLimoncello%></p>
            </div>
            <%} %>
            
            <div class="product-description">
                <p>
                nome fornitore :  <%=f.getNome()%>
                </p>
             	<p>
             	anno di inizio fornitore : <%=f.getAnnoNascita() %> 
             	 </p>
           		<p> provenienza: <%=f.getProvincia() %>, <%= f.getCitta() %>, <%= f.getIndirizzo() %>
           		</p>
                
                
                </p>
            </div>

                <a href="add-to-cart?id=<%=p.getId()%>&prezzo=<%=p.getPrezzo() %>" 
                                           class="btn-cantina-outline flex-fill" title="Aggiungi al Carrello">
                <button type="submit" class="btn-add-cart">
                    <i class='bx bx-cart-add'></i> AGGIUNGI AL CARRELLO
                </button>
                </a>
            
            
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