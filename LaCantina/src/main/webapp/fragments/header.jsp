<!DOCTYPE html>
<html lang="it">
<head>


<!-- INSERIRE IMPORT -->

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link href="./CSS/header.css" rel="stylesheet" type="text/css">
<script src="./JS/header.js"></script>
</head>
<body>
	<!-- HEADER -->
	<header class="header">
		<div class="header__content">
			<a class="header__logo" href="./index.jsp"> <img src="./IMG/logo_lacantina.png"
				class="logo" alt="Logo">
			</a>
			<ul class="header__menu desktop-only">
				<li><a href="./index.jsp">Home</a></li>
				<li><a href="./shop.jsp">Shop</a></li>
				<li><a href="./aboutUs.jsp">About us</a></li>
				<li><a href="./contatti.jsp">Contatti</a></li>
			</ul>



<!--                 INSERIRE COLLEGAMENTO CON LA SESSIONE UTENTE -->  
			
			
			

			<div class="header__icons">
				<a href="./carrello.jsp" aria-label="Visualizza il carrello"> <img
					src="./IMG/shoppingbag.png" class="menu-icon" id="carrello"
					alt="Carrello">
				</a> <img src="./IMG/menu2.png" class="menu-icon" id="dropdownIcon"
					alt="Menu" tabindex="0" aria-expanded="false"
					aria-controls="dropdownMenu">
				<div class="dropdown-menu" id="dropdownMenu" role="menu"
					aria-hidden="true">
					<ul>
						<li class="mobile-only"><a href="./index.jsp">Home</a></li>
						<li class="mobile-only"><a href="./shop.jsp">Shop</a></li>
						<li class="mobile-only"><a href="./aboutUs.jsp">About us</a></li>
						<li class="mobile-only"><a href="./contatti.jsp">Contatti</a></li>
						<li><a href="./LoginAndRegistration.jsp">Accedi</a></li>
						<li><a href="./LoginAndRegistration.jsp">Registrati</a></li>
						<!--  INSERIRE CONTROLLI PER FAR VISUALIZZARE LOGIN OPPURE REGISTER -->
					</ul>
				</div>
			</div>
		</div>
	</header>
</body>
</html>