<!DOCTYPE html>
<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="java.util.*" %>
<%@page import="it.unisa.lacantina.model.*" %>

<%
Utente auth = (Utente)request.getSession().getAttribute("auth"); 

		if(auth!=null)
		{
	response.sendRedirect("index.jsp");
		}
		ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
		if(cart_list!=null){
	request.setAttribute("cart_list", cart_list);
		}
%>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="CSS/login.css">
<title>Sign-Up/Sign-In</title>
<link rel="icon" type="image/png" href="IMG/Finale.png">
</head>
<body>
	<jsp:include page="./fragments/header.jsp" />
	<div class="container" id="container">
		<div class="form-container sign-up">
			<form id="registrationForm" action="registration" method="post">
				<h1>Crea il tuo account</h1>
				<input type="text" id="nome" name="login_nome" placeholder="Nome">
				<input type="text" id="cognome" name="login_cognome" placeholder="Cognome">
				<input type="text" id="email" name="login_email" placeholder="Email">
				<input type="password" id="password" name="login_password" placeholder="Password">
					
					<div id="errorBox" style="color:red; margin-top:10px;"></div>
					
				<button type="submit">Registrati</button>
				
			</form>
			
			<script src="<%= request.getContextPath() %>/JS/RegistrationValidation.js"></script>
			
		</div>

		<div class="form-container sign-in">
			<form id="LoginForm" action="user-login" method="post">
				<h1>Accedi al tuo account</h1>
				<input type="text" id="email" name="email" placeholder="Email" required> <input
					type="password" name="password" placeholder="Password" required> <a
					href="#">Password Dimenticata?</a>
				<button type = "submit">Accedi</button>
				</form>
				
				<script src="<%= request.getContextPath() %>/JS/LoginValidation.js"></script>
		</div>

		<div class="toggle-container">
			<div class="toggle">
				<div class="toggle-panel toggle-left">
					<h1>Bentornato!</h1>
					<p>Effettua il login</p>
					<button class="hidden" id="login">Accedi</button>
				</div>
				<div class="toggle-panel toggle-right">
					<h1>Benvenuto!</h1>
					<p>Effettua la registrazione</p>
					<button class="hidden" id="register">Registrati</button>
				</div>
			</div>
		</div>
	</div>

	<script src="JS/loginScript.js"></script>
	<jsp:include page="./fragments/footer.jsp" />
</body>
</html>