<!DOCTYPE html>
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
	<br>
	<br>
		<br>
	<br>
	<div class="container" id="container">
		<div class="form-container sign-up">
			<form action="./RegistrationServlet" method="post">
				<h1>Crea il tuo account</h1>
				<input type="text" name="nome" placeholder="Nome"> <input
					type="text" name="cognome" placeholder="Cognome"> <input
					type="email" name="email" placeholder="Email"> <input
					type="password" name="password" placeholder="Password">
				<button>Registrati</button>
			</form>
		</div>

		<div class="form-container sign-in">
			<form action="./LoginServlet" method="post">
				<h1>Accedi al tuo account</h1>
				<input type="text" name="email" placeholder="Email"> <input
					type="password" name="password" placeholder="Password"> <a
					href="#">Password Dimenticata?</a>
				<button>Accedi</button>
				</form>
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