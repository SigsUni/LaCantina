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
    <meta http-equiv="X-UA-Compatible" contex="ie=edge">
    <title>Chi Siamo - La Cantina</title>
    
    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="panel2" style="margin-top: 100px;"> <div class="contenitore">
            <h2 class="watch fade-in titolo">
                Chi Siamo
            </h2>
        </div>
    </div>

    <div class="panel">
        <img src="./IMG/aboutus_lacantina.png" alt="Il Team La Cantina" class="panel-image watch fade-in">
        <div class="panel-description watch fade-in">
            <h3>Tradizione e Innovazione</h3>
            <p>
                Fabrizio, Gabriele, Alessandro: tre ragazzi con la passione per il proprio territorio e stanchi dei soliti prodotti con provenienza ambigua.
                Decidono, con la collaborazione delle migliori aziende agricole del territorio campano, di rimodernare il mercato.
                <br><br>
                L'obiettivo &egrave; semplice: distribuire prodotti <strong>bio a Km0</strong> con l'uso delle materie prime provenienti dai principali produttori locali, valorizzando il territorio e promuovendo la tradizione italiana.
            </p>
        </div>
    </div>

    <div class="panel2">
        <div class="contenitore">
            <h2 class="watch fade-in titolo">
                I Nostri Valori
            </h2>
        </div>
    </div>

    <div class="panel">
        <div class="card-grid">
            <div class="card">
                <div class="card__background" style="background-color: #2a6973; display: flex; align-items: center; justify-content: center;">
                    <i class='bx bx-leaf' style="font-size: 4rem; color: white;"></i>
                </div>
                <div class="card__content">
                    <p class="card__category">Filosofia</p>
                    <h3 class="card__heading">100% Bio</h3>
                </div>
            </div>
            
            <div class="card">
                <div class="card__background" style="background-color: #2a6973; display: flex; align-items: center; justify-content: center;">
                    <i class='bx bx-map' style="font-size: 4rem; color: white;"></i>
                </div>
                <div class="card__content">
                    <p class="card__category">Territorio</p>
                    <h3 class="card__heading">Km Zero</h3>
                </div>
            </div>

            <div class="card">
                <div class="card__background" style="background-color: #2a6973; display: flex; align-items: center; justify-content: center;">
                    <i class='bx bx-heart' style="font-size: 4rem; color: white;"></i>
                </div>
                <div class="card__content">
                    <p class="card__category">Qualit&agrave;</p>
                    <h3 class="card__heading">Passione</h3>
                </div>
            </div>
            
             <div class="card">
                <div class="card__background" style="background-color: #2a6973; display: flex; align-items: center; justify-content: center;">
                    <i class='bx bx-store' style="font-size: 4rem; color: white;"></i>
                </div>
                <div class="card__content">
                    <p class="card__category">Eccellenza</p>
                    <h3 class="card__heading">Locale</h3>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>
</body>
</html>