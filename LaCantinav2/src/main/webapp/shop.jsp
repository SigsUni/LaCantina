<%@page import="it.unisa.lacantina.model.ConnectToDB" %>
<%@page import="it.unisa.lacantina.model.*" %>
<%@page import="it.unisa.lacantina.control.*" %>
<%@page import="java.util.List" %>
<% 
	User auth = (User)request.getSession().getAttribute("auth"); 
	if(auth != null)
	{
		request.setAttribute("auth",auth);
	} 
	
	
	String categoriaSelezionata = request.getParameter("categoria");
	
	ProdottoDao pd = new ProdottoDao(ConnectToDB.getConnection());
	List<Prodotto> prodotti = pd.getAllProdotti();
   
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
    	<div class = "container">
	    
    	<div class = "card-header my-3"> Prodotti Selezionati </div>
    		<div class = "row">
    <%	
    if(!prodotti.isEmpty())
    {
    	for(Prodotto p:prodotti){
    		%>
    		<%	
    if(p.getCategoria().equals(categoriaSelezionata) || categoriaSelezionata.equals("tutto"))
    {%>
    		
        			<div class="col-md-3 mb-4">

    					<div class="card w-100" style="width: 18rem;">
        
       						 <img class="card-img-top product-img" src="<%= p.getImmagine() %>">

        						<div class="card-body">
           							<h5 class="card-title"><%= p.getNome() %></h5>
            						<h6 class="price">Prezzo: <%= p.getPrezzo() %> &euro;</h6>
            						<h6 class="category">Categoria: <%= p.getCategoria() %></h6>
           							 <p class="card-text"><%= p.getDescrizione() %></p>

            						<div class="mt-3 d-flex justify-content-between">
               							 <a href="#" class="btn btn-primary btn-sm">Acquista</a>
              								  <a href="add-to-cart?id=<%=p.getId()%>" class="btn btn-primary btn-sm">Add to Cart</a>
            						</div>
       							 </div>

    					</div>
				</div>

    	
    		
    	<%	
    		
    	}
    }
    }
    
    
    
    %>
     </div>
        </div>
    
    <%} %>
    
    <div class="panel">
        
        
        <div class="card-grid">
            <a class="card" href="./shop.jsp?categoria=tutto">
              <div class="card__background" style="background-image: url(./IMG/immagine_prova.png)"></div>
              <div class="card__content">
                <p class="card__category">Categoria</p>
                <h3 class="card__heading">Tutti i prodotti</h3>
              </div>
            </a> 
          <div class="card-grid">
            <a class="card" href="./shop.jsp?categoria=olio-extravergine-oliva">
              <div class="card__background" style="background-image: url(./IMG/immagine_prova.png)"></div>
              <div class="card__content">
                <p class="card__category">Categoria</p>
                <h3 class="card__heading">Olio Extravergine d'oliva</h3>
              </div>
            </a> 
            <a class="card" href="./shop.jsp?categoria=vino-rosso">
              <div class="card__background" style="background-image: url(./IMG/immagine_prova.png)"></div>
              <div class="card__content">
                <p class="card__category">Categoria</p>
                <h3 class="card__heading">Vino Rosso</h3>
              </div>
            </a>
            <a class="card" href="./shop.jsp?categoria=vino-bianco">
              <div class="card__background" style="background-image: url(./IMG/immagine_prova.png)"></div>
              <div class="card__content">
                <p class="card__category">Categoria</p>
                <h3 class="card__heading">Vino Bianco</h3>
              </div>
            <a class="card" href="./shop.jsp?categoria=limoncello">
              <div class="card__background" style="background-image: url(./IMG/immagine_prova.png)"></div>
              <div class="card__content">
                <p class="card__category">Categoria</p>
                <h3 class="card__heading">Limoncello</h3>
              </div>
            </a>
          <div>
         
      </div>
    </div>
    </div>
    
 <jsp:include page="/fragments/footer.jsp"></jsp:include>

        
<script type="text/javascript" src="./JS/index.js"></script>

    </body>
</html>