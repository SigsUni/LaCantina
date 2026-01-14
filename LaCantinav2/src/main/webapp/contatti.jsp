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
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contatti - La Cantina</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="./CSS/index.css" rel="stylesheet" type="text/css">
    <link href="./CSS/contact.css" rel="stylesheet" type="text/css">
    
    <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body style="background-color: #ffffff !important;">
    
    <jsp:include page="/fragments/header.jsp"></jsp:include>

    <div class="main-contact-wrapper">

        <h2 class="page-title watch fade-in">Scrivici</h2>
        <p class="page-subtitle watch fade-in">Hai domande sui nostri prodotti o vuoi collaborare? Compila il form sottostante.</p>
            
        <div class="form-container watch fade-in">
            <form id="contactForm"> 
                <div class="form-group">
                    <input type="text" id="nome" name="nome" class="form-input" placeholder="Il tuo Nome" required>
                </div>
                <div class="form-group">
                    <input type="email" id="email" name="email" class="form-input" placeholder="La tua Email" required>
                </div>
                <div class="form-group">
                    <textarea id="messaggio" name="messaggio" class="form-input" rows="5" placeholder="Il tuo Messaggio" required></textarea>
                </div>
                <button type="submit" class="btn-submit">INVIA MESSAGGIO</button>
            </form>
        </div>

        <h2 class="page-title watch fade-in" style="margin-top: 80px;">Dove Siamo & Recapiti</h2>
        <div style="width: 50px; height: 3px; background: #2a6973; margin: 10px auto 50px auto;"></div>

        <div class="contact-grid">
            
            <a class="horizontal-card watch fade-in" href="https://goo.gl/maps/unisa_fisciano" target="_blank">
                <div class="icon-box">
                    <i class='bx bx-map'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Sede (Clicca per Mappa)</div>
                    <div class="info-text">Via Giovanni Paolo II, Fisciano</div>
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

             <a href="https://www.instagram.com" target="_blank" class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <i class='bx bxl-instagram'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Instagram</div>
                    <div class="info-text">@LaCantina</div>
                </div>
            </a>

            <a href="https://www.facebook.com" target="_blank" class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <i class='bx bxl-facebook-circle'></i>
                </div>
                <div class="info-box">
                    <div class="info-category">Facebook</div>
                    <div class="info-text">La Cantina</div>
                </div>
            </a>

            <a href="https://twitter.com" target="_blank" class="horizontal-card watch fade-in">
                <div class="icon-box">
                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" style="fill: white;">
                        <path d="M18.901 1.153h3.68l-8.04 9.19L24 22.846h-7.406l-5.8-7.584-6.638 7.584H.474l8.6-9.83L0 1.154h7.594l5.243 6.932ZM17.61 20.644h2.039L6.486 3.24H4.298Z"></path>
                    </svg>
                </div>
                <div class="info-box">
                    <div class="info-category">Social</div>
                    <div class="info-text">@LaCantina</div>
                </div>
            </a>

        </div>

    </div>

    <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var form = document.getElementById('contactForm');
            if (form) {
                form.addEventListener('submit', function(event) {
                    event.preventDefault(); 
                    var nome = document.getElementById('nome').value;
                    alert("Grazie " + nome + "! Il tuo messaggio è stato inviato correttamente.");
                    form.reset(); 
                });
            }
        });
    </script>
</body>
</html>