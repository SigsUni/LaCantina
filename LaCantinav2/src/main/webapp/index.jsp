<%@page import="it.unisa.lacantina.util.ConnectToDB" %>
<%@page import="it.unisa.lacantina.model.domain.Utente" %>
<%@page import="it.unisa.lacantina.model.domain.Carrello" %>
<%@page import="java.util.*" %>
<%
Utente auth = (Utente)request.getSession().getAttribute("auth"); 
	if(auth != null)
	{
		request.setAttribute("auth",auth);
		
		if(auth.getID()==2){
			response.sendRedirect(request.getContextPath()+"/admin-pages/admin_index.jsp");
		}
	} 
	ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
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
    
        <title>
            Home Page
        </title>
        <link href="./CSS/index.css" rel="stylesheet" type="text/css">
        <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
    </head>

    <body>  
        <jsp:include page="/fragments/header.jsp"></jsp:include>
            <!--SCROLL CON VIDEO2-->
                <video class="video-bg" src="presentazione.mp4" autoplay muted loop></video>      
                <div class="section watch"> 
                  <video class="video-bg" src="./IMG/presentazione.mp4" autoplay muted loop></video>      
                  <h2 class="title" style= "margin-left: 38%;">UNA NUOVA ERA DI<br>PRODOTTI GENUINI</h2>
              </div>
              <div class="section watch">
                  <h2 class="title" style="margin-left: 26%;">FATTI TRASPORTARE  DALLA TRADIZIONE</h2>
              </div>
              <div class="section watch">
                  <h2 class="title" style="margin-left: 38%;">Scopri La Cantina</h2>
              </div>
        
        <!--separatore-->
        <div class="panel2">
          <div class="contenitore">
            <h2 class="watch fade-in titolo">
              LA NOSTRA STORIA:
            </h2>
          </div>
          </div>

		<!-- nuovo -->
		<div class="panel">
        <img src="./IMG/aboutus_lacantina.png" alt="Descrizione immagine" class="panel-image">
        <div class="panel-description">
            <p>Fabrizio, Gabriele, Alessandro tre ragazzi con la passione per il proprio territorio e stanchi dei soliti prodotti con provenienza ambigua e di qualit&agrave; discutibile decidono con la collaborazione delle migliori aziende agricole del territorio campano di rimodernare il mercato.
                  L'obiettivo &egrave; semplice, distribuire prodotti bio a Km0 con l'uso delle materie prime provenienti dai principali produttori del territorio campano, valorizzando il territorio e promuovendo la tradizione italiana.
                </p>
                <a href="aboutUs.jsp" class="btn">Scopri di pi&ugrave;</a>
                
        </div>
    </div>
		<!--vecchio  
        <div class="panel">
        <div class="div-separato">
          
        <section class="about" id="about">
            <div class="about-img">
                <img class="watch fade-in" src="./IMG/aboutus.png" alt="" height="500px" width="700px">
            </div>
            <div class="watch fade-in about-text">
                <p class="watch fade-in">
                  Augusto, Antonio, Federica e Francesco si incontrarono per la prima volta durante il loro secondo anno di universit&agrave;.
                  L'incontro avvenne durante una lezione di progettazione di tecnologie e software per il web. La professoressa assegn&ograve; loro un progetto di gruppo: 
                  sviluppare un sito web innovativo. La passione comune per la musica elettrica li spinse a lavorare insieme, dando inizio a una collaborazione che avrebbe cambiato le loro vite...
                </p>
                
                <div class="button-container ">
                  <button style="margin-left: auto;">Scopri di pi&ugrave;</button>
              </div>
            </div>
            
        </section>
        </div>
        </div>
        -->
        
        <!--separatore-->
        <div class="panel2">
          <div class="contenitore">
            <h2 class="watch fade-in titolo">
              I Nostri Prodotti
            </h2>
          </div>
          </div>

        <!--Card-->
        <div class="panel">
          <div class="card-grid">
            <a class="card" href="./shop.jsp?categoria=olio-extravergine-oliva">
              <div class="card__background" style="background-image: url(./IMG/olive_card.jpg)"></div>
              <div class="card__content">
                <p class="card__category">Categoria</p>
                <h3 class="card__heading">Olio Extravergine d'oliva</h3>
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
            <a class="card" href="./shop.jsp?categoria=limoncello">
              <div class="card__background" style="background-image: url(./IMG/limoni_card.jpg)"></div>
              <div class="card__content">
                <p class="card__category">Categoria</p>
                <h3 class="card__heading">Limoncello</h3>
              </div>
            </a>
          <div>
      </div>
    </div>
    </div>
      
      <!--separatore-->
      <div class="panel2">
        <div class="contenitore">
          <h2 class="watch fade-in titolo">
            Nuovi Arrivi
          </h2>
        </div>
        </div>

      <!--NUOVI-->
      <div class="panel">
      <div class="container">
        <div class="watch fade-in imgBx">
          <img src="./IMG/oliva.png">
        </div>
        <div class="watch fade-in details">
            <div class="watch fade-in content">
                <h2>E poi?<br>
                    <span>Novit&agrave; in arrivo</span>
                </h2>
                <p>
                 	Tra i nostri principali obiettivi c'è quello di fornire una qualità genuina ed elevata ai nostri prodotti e per questo motivo LaCantina
                 	attualmente non fornisce altri prodotti lavorati dal territorio campano, ma si riserva di portarne in futuro, continuate a seguirci e presto
                 	ci saranno novità in arrivo
                 </p>
          </div>
        </div>
    </div>
  </div>

 <jsp:include page="/fragments/footer.jsp"></jsp:include>

        
<script type="text/javascript" src="./JS/index.js"></script>

    </body>
</html>