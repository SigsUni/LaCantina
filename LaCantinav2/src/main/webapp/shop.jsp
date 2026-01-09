<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.*" %>

<%
Utente auth = (Utente)request.getSession().getAttribute("auth"); 
	if(auth != null)
	{
		request.setAttribute("auth",auth);
	} 
	
	
	String categoriaSelezionata = request.getParameter("categoria");
	
	if(categoriaSelezionata == null){
		categoriaSelezionata =  "tutto";
	}
	
	ProdottoDao pd = new ProdottoDao(ConnectToDB.getConnection());
	List<Prodotto> prodotti = pd.getAllProdotti();
	ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
	FornitoreDao fdao = new FornitoreDao(ConnectToDB.getConnection());
	if(cart_list!=null){
		request.setAttribute("cart_list", cart_list);
	}
%>
<!DOCTYPE html>
<html >
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" contex="ie=edge">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.product-img {
    height: 160px;        /* riduci a piacere */
    object-fit: cover;    /* evita deformazioni */
}
</style>
  
        <title>
            Shop
        </title>
        <link href="./CSS/shopcss.css" rel="stylesheet" type="text/css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
    </head>

    <body>  
        <jsp:include page="/fragments/header.jsp"></jsp:include>
		
	
		<h1><center>Shop LaCantina</center></h1>

		<!-- nuovo -->
		<div class="panel">
        <div class="panel-description">
       	<br>	<br>
          <giustify>
<p>Benvenuti dello Shop LaCantina, All&rsquo;interno &egrave; possibile trovare una selezione di prodotti tipici campani, tra cui <strong>olio extravergine d&rsquo;oliva</strong>, <strong>limoncello artigianale</strong>, <strong>vino bianco</strong> e <strong>vino rosso</strong>, tutti ottenuti nel pieno rispetto delle tradizioni locali e dei pi&ugrave; alti standard di produzione.</p>

<p>Per rendere l&rsquo;esperienza d&rsquo;acquisto semplice e intuitiva, LaCantina mette a disposizione un sistema di <strong>filtraggio dinamico</strong> che consente all&rsquo;utente di visualizzare rapidamente i prodotti della categoria desiderata. Selezionando la casella corrispondente, &egrave; possibile esplorare esclusivamente gli articoli di proprio interesse, garantendo una navigazione chiara, immediata ed efficace.</p>

<p><strong>LaCantina: il gusto autentico della Campania, a portata di click.</strong></p>
                </giustify>
                
        </div>
    </div>
		
           <!--separatore-->
        <div class="panel2">
          <div class="contenitore">
            <h1 class="watch fade-in titolo">
              Cosa desideri?
            </h1>
          </div>
          </div>
		
    
    <%if(categoriaSelezionata!=null){%>
    	<div class="container my-5">
	    
    	<div class="card-header my-3 fs-4"> Prodotti Selezionati </div>
    		<div class="row g-4">
    <%	
    if(!prodotti.isEmpty())
    {
    	for(Prodotto p:prodotti){
    		
            /* Filtro per categoria */
            if(p.getCategoria().equals(categoriaSelezionata) || categoriaSelezionata.equals("tutto"))
            {
                /* Controllo se il prodotto è attivo */
                if(p.checkActive()){
                    boolean isInStock = p.checkSingleStock(); 
    %>
    		
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">

    					<div class="card w-100 h-100 shadow-sm">
        
       						 <a href="dettaglio_prodotto.jsp"><!-- /* request.getContextPath() %>/ fdao.getNomeById(p.getIdFornitore())%>*/ -->
                                 <img class="card-img-top product-card-image" src="<%= request.getContextPath() %>/IMG/<%= p.getImmagine() %>" alt="<%= p.getNome() %>">
                             </a>

        						<div class="card-body d-flex flex-column">
           							<h5 class="card-title"><%= p.getNome() %></h5>
            						<h6 class="price text-muted">Prezzo: <%= p.getPrezzo() %> &euro;</h6>
            						
                                    <% if(isInStock) { %>
                                        <h6 class="stock text-success">Stock: <%= p.getStock() %></h6>
                                    <% } else { %>
                                        <h6 class="stock text-danger">Stock: <b>Out of Stock</b></h6>
                                    <% } %>
                                    
            						<h6 class="category small">Categoria: <%= p.getCategoria() %></h6>
            						<h6 class="category small mb-2">Fornitore: <%= fdao.getNomeById(p.getIdFornitore())%></h6>
           							 
                                    <p class="card-text flex-grow-1 small"><%= p.getDescrizione() %></p>

            						<div class="mt-3 d-flex justify-content-between gap-2">
                                        <% if(isInStock) { %>
            							    <a href="<%= request.getContextPath() %>/acquisto_singolo_prodotto.jsp?quantity=1&id=<%= p.getId() %>&prezzo=<%=p.getPrezzo() %>&nome=<%=p.getNome() %>" class="btn btn-primary btn-sm flex-fill">Acquista</a>
              								<a href="add-to-cart?id=<%=p.getId()%>&prezzo=<%=p.getPrezzo() %>" class="btn btn-outline-primary btn-sm flex-fill">Carrello</a>
                                        <% } else { %>
                                            <button class="btn btn-secondary btn-sm w-100" disabled>Non disponibile</button>
                                        <% } %>
            						</div>
            						
       							 </div>
    					</div>
				</div>
				
    	<%	
                } // fine if active
    	    } // fine if categoria
        } // fine for
    } // fine if empty
    %>
         </div> </div> <%} %>
    
    <hr>
    
    <div style="background-color: #ffffff; padding: 40px 0;"> 
        
        <div class="hero-section" style="min-height: auto; padding: 20px; background: transparent;">
            
            <div class="card-grid">

                <a class="card" href="./shop.jsp?categoria=olio-extravergine-oliva">
                  <div class="card__background" style="background-image: url(./IMG/olive_card.jpg)"></div>
                  <div class="card__content">
                    <p class="card__category">Categoria</p>
                    <h3 class="card__heading">Olio EVO</h3>
                  </div>
                </a> 

                <a class="card" href="./shop.jsp?categoria=vino-rosso">
                  <div class="card__background" style="background-image: url(./IMG/uva_rossa_card.png)"></div>
                  <div class="card__content">
                    <p class="card__category">Categoria</p>
                    <h3 class="card__heading">Vino Rosso</h3>
                  </div>
                </a>

                <a class="card" href="./shop.jsp?categoria=vino-bianco">
                  <div class="card__background" style="background-image: url(./IMG/uva_bianca_card.jpg)"></div>
                  <div class="card__content">
                    <p class="card__category">Categoria</p>
                    <h3 class="card__heading">Vino Bianco</h3>
                  </div>
                </a>

                <a class="card" href="./shop.jsp?categoria=limoncello">
                  <div class="card__background" style="background-image: url(./IMG/limoni_card.jpg)"></div>
                  <div class="card__content">
                    <p class="card__category">Categoria</p>
                    <h3 class="card__heading">Limoncello</h3>
                  </div>
                </a>

            </div> 
        </div>
    </div>
    
 <jsp:include page="/fragments/footer.jsp"></jsp:include>

        
<script type="text/javascript" src="./JS/index.js"></script>

    </body>
</html>