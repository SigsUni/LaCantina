<%@page import="it.unisa.lacantina.model.domain.Utente"%>
<%@page import="it.unisa.lacantina.model.domain.Carrello"%>
<%@page import="java.util.*"%>
<%
    Utente auth = (Utente) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
    ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Siamo - La Cantina</title>
    
    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link href="./CSS/about.css" rel="stylesheet" type="text/css">
    
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="panel2" style="margin-top: 100px;">
        <div class="contenitore">
            <h2 class="watch fade-in titolo">
                Chi Siamo
            </h2>
        </div>
    </div>

    <div class="panel panel-spacer">
        
        <img src="./IMG/aboutus_lacantina.png" alt="Il Team La Cantina" class="panel-image watch fade-in about-img-style">
        
        <div class="panel-description watch fade-in">
            <h3 style="margin-bottom: 20px;">Tradizione e Innovazione</h3>
            
            <p class="story-text">
                Fabrizio, Gabriele, Alessandro: tre ragazzi con la passione per il proprio territorio e stanchi dei soliti prodotti con provenienza ambigua.
                Decidono, con la collaborazione delle migliori aziende agricole del territorio campano, di rimodernare il mercato.
            </p>
            
            <p class="story-text">
                L'obiettivo &egrave; semplice: distribuire prodotti <strong>bio a Km0</strong> con l'uso delle materie prime provenienti dai principali produttori locali, valorizzando il territorio e promuovendo la tradizione italiana.
            </p>
            
            <p class="story-text">
                Crediamo che il cibo non sia solo nutrimento, ma un ponte tra passato e futuro. Ogni bottiglia, ogni prodotto che selezioniamo racconta la storia delle mani che lo hanno lavorato e della terra che lo ha nutrito.
            </p>
        </div>
    </div>

    <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>
</body>
</html>