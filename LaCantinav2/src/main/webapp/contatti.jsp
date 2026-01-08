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
    <title>Contatti - La Cantina</title>
    
    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link href="./CSS/contact.css" rel="stylesheet" type="text/css">
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="panel2" style="margin-top: 100px;">
        <div class="contenitore">
            <h2 class="watch fade-in titolo">Scrivici</h2>
        </div>
    </div>

    <div class="panel">
        <div class="panel-description" style="width: 100%; text-align: center;">
            <p style="margin-bottom: 30px;">Hai domande? Compila il form qui sotto.</p>
            <div class="form-container watch fade-in">
                <form action="SendEmailServlet" method="post"> 
                    <div class="form-group">
                        <input type="text" name="nome" class="form-input" placeholder="Il tuo Nome" required>
                    </div>
                    <div class="form-group">
                        <input type="email" name="email" class="form-input" placeholder="La tua Email" required>
                    </div>
                    <div class="form-group">
                        <textarea name="messaggio" class="form-input" rows="5" placeholder="Il tuo Messaggio" required></textarea>
                    </div>
                    <button type="submit" class="btn-submit">INVIA MESSAGGIO</button>
                </form>
            </div>
        </div>
    </div>

    <div class="panel2">
        <div class="contenitore">
            <h2 class="watch fade-in titolo">Dove Siamo & Recapiti</h2>
        </div>
    </div>

    <div class="panel">
        <div class="contact-grid">
            
            <a class="horizontal-card watch fade-in" href="https://www.google.com/maps/search/Universit%C3%A0+degli+Studi+di+Salerno+Fisciano/@40.7753875,14.7874837,17z" target="_blank">
                <div class="icon-box">
                    <i class='bx bx-map'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Sede (Clicca per Mappa)</div>
                    <div class="info-text">Via Giovanni Paolo II, Fisciano (SA)</div>
                </div>
            </a>

            <div class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <i class='bx bx-envelope'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Email</div>
                    <div class="info-text">lacantina@gmail.com</div>
                </div>
            </div>

            <div class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <i class='bx bx-phone'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Telefono</div>
                    <div class="info-text">081 514 1933</div>
                </div>
            </div>

             <div class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <i class='bx bxl-instagram'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Seguici su Instagram</div>
                    <div class="info-text">@LaCantina</div>
                </div>
            </div>
			
			<div class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <i class='bx bxl-facebook-circle'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Seguici Facebook</div>
                    <div class="info-text">@LaCantina</div>
                </div>
            </div>
            
            <div class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <i class='bx bxl-twitter'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Seguici su X</div>
                    <div class="info-text">@LaCantina</div>
                </div>
            </div>
			
        </div>
    </div>

    <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>
</body>
</html>