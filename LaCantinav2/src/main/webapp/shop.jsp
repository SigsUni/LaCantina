<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.*" %>

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
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop - LaCantina</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <link href="./CSS/shopcss.css" rel="stylesheet" type="text/css">
</head>

<body>  
    <jsp:include page="/fragments/header.jsp"></jsp:include>
    
    <div class="page-wrapper">
        
        <div class="page-header-content">
            <h1 class="page-title">Shop La Cantina</h1>
            <p class="text-muted" style="max-width: 700px; margin: 0 auto;">
                Benvenuti nello Shop. Scopri i prodotti tipici: <strong>Olio EVO</strong>, <strong>Vini</strong> e <strong>Limoncello</strong>.
            </p>
        </div>

        <div class="text-center mb-5">
            <h2 style="color:#2a6973; font-weight:300; text-transform: uppercase; letter-spacing: 2px;">Cosa desideri?</h2>
            <% if(!categoriaSelezionata.equals("tutto")) { %>
                <a href="shop.jsp" class="btn btn-outline-secondary btn-sm mt-2 rounded-pill">Mostra Tutto</a>
            <% } %>
        </div>
        
        <% if(categoriaSelezionata != null){ %>
            <div class="container mb-5">
                <div class="row g-4">
        <%  
        if(prodotti != null && !prodotti.isEmpty())
        {
            for(Prodotto p : prodotti){
                
                // Filtro Categoria
                if(p.getCategoria().equals(categoriaSelezionata) || categoriaSelezionata.equals("tutto"))
                {
                    // Controllo Attivo
                    if(p.checkActive()){
                        boolean isInStock = p.checkSingleStock(); 
        %>
            
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        
                        <div class="card-index-style">
                            
                            <a href="dettaglio_prodotto.jsp?id=<%=p.getId()%>">
                                <img class="product-img-index" src="<%= request.getContextPath() %>/IMG/<%= p.getImmagine() %>" alt="<%= p.getNome() %>">
                            </a>

                            <div class="card-body">
                                <h5 class="card-title"><%= p.getNome() %></h5>
                                <div class="price">€ <%= String.format("%.2f", p.getPrezzo()) %></div>
                                
                                <% if(isInStock) { %>
                                    <div class="text-success small mb-2"><i class="fas fa-circle"></i> Disponibile (<%= p.getStock() %>)</div>
                                <% } else { %>
                                    <div class="text-danger small mb-2"><i class="fas fa-circle"></i> Esaurito</div>
                                <% } %>
                                
                                <div class="text-muted-custom">Cat: <%= p.getCategoria() %></div>
                                <div class="text-muted-custom mb-3">Fornitore: <%= fdao.getNomeById(p.getIdFornitore()) %></div>
                                    
                                <p class="text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                    <%= p.getDescrizione() %>
                                </p>

                                <div class="d-flex justify-content-between gap-2 mt-3">
                                    <% if(isInStock) { %>
                                        
                                        <a href="<%= request.getContextPath() %>/acquisto_singolo_prodotto.jsp?quantity=1&id=<%= p.getId() %>&prezzo=<%=p.getPrezzo() %>&nome=<%=p.getNome() %>" 
                                           class="btn-cantina-fill flex-fill">
                                           Acquista
                                        </a>
                                        
                                        <a href="add-to-cart?id=<%=p.getId()%>&prezzo=<%=p.getPrezzo() %>" 
                                           class="btn-cantina-outline flex-fill" title="Aggiungi al Carrello">
                                           <i class='bx bx-cart-add' style="font-size: 1.2rem;"></i>
                                        </a>

                                    <% } else { %>
                                        <button class="btn btn-disabled w-100" disabled>Non disponibile</button>
                                    <% } %>
                                </div>
                                
                            </div>
                        </div>
                        </div>
                    
        <%  
                    } // fine if active
                } // fine if categoria
            } // fine for
        } else { %>
            <div class="col-12 text-center py-5">
                <h4>Nessun prodotto trovato.</h4>
            </div>
        <% } %>
             </div> </div> <%} %>
        
        <hr style="margin: 40px auto; width: 80%;">
        
        <div class="hero-section">
            <div class="card-grid">

                <a class="cat-card" href="./shop.jsp?categoria=olio-extravergine-oliva">
                  <div class="cat-bg" style="background-image: url(./IMG/olive_card.jpg)"></div>
                  <div class="cat-content">
                    <p class="mb-0 small text-uppercase">Categoria</p>
                    <h3 style="font-family: 'Dancing Script';">Olio EVO</h3>
                  </div>
                </a> 

                <a class="cat-card" href="./shop.jsp?categoria=vino-rosso">
                  <div class="cat-bg" style="background-image: url(./IMG/uva_rossa_card.png)"></div>
                  <div class="cat-content">
                    <p class="mb-0 small text-uppercase">Categoria</p>
                    <h3 style="font-family: 'Dancing Script';">Vino Rosso</h3>
                  </div>
                </a>

                <a class="cat-card" href="./shop.jsp?categoria=vino-bianco">
                  <div class="cat-bg" style="background-image: url(./IMG/uva_bianca_card.jpg)"></div>
                  <div class="cat-content">
                    <p class="mb-0 small text-uppercase">Categoria</p>
                    <h3 style="font-family: 'Dancing Script';">Vino Bianco</h3>
                  </div>
                </a>

                <a class="cat-card" href="./shop.jsp?categoria=limoncello">
                  <div class="cat-bg" style="background-image: url(./IMG/limoni_card.jpg)"></div>
                  <div class="cat-content">
                    <p class="mb-0 small text-uppercase">Categoria</p>
                    <h3 style="font-family: 'Dancing Script';">Limoncello</h3>
                  </div>
                </a>

            </div> 
        </div>

    </div> 
    <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>

</body>
</html>