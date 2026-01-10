<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import = "java.util.*" %>
<%@page import="it.unisa.lacantina.model.service.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	Utente auth = (Utente)request.getSession().getAttribute("auth"); 
			  	
			  	if(auth!=null)
			  	{
			  		request.setAttribute("auth",auth);
			  		
			  	}
			  	else
			  	{
			  		response.sendRedirect("/LaCantinav2/LoginAndRegistration.jsp");
			  	}
			  	
			  	ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
		List<Carrello> cartProduct = null;
			  	
			  	if(cart_list!=null)
			  	{	
			  		request.setAttribute("cart_list",cart_list);

			CarrelloService cService = new CarrelloService();
			float totale = cService.getTotalCartPrice(cart_list);
			request.setAttribute("cart_list", cart_list);
			request.setAttribute("totale", totale); 
		}
	%>  



<!DOCTYPE html>
<html>
<head>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Acquisto Articoli</title>

</head>
<body>
<jsp:include page="/fragments/header.jsp"></jsp:include>
<br><br><br>
<div class= "container">

	<div class = "card w-50 mx-auto my-5">
	
	<!-- card in generale -->
	
	<div class = "card-header text-center">
	Effettua il tuo ordine
	<h6><i>n.b. sarà possbile modificare l'indirizzo di spedizione o cancellare l'ordine finquando l'articolo non sarà spedito</i>
	
	<!--  card-header -->
	
	</div>
	
	<div class = "card-body">
	
	<!-- card body --> 
	
<form action ="<%=request.getContextPath()%>/check-out" method = "GET" >

<div class= "form-group">

<div class = "card-header text-center">
	Riepilogo del tuo acquisto
	<h4><b><center>Prezzo Totale€ ${ (totale>0)?totale:0}</center></b></h4>
	<%
	if (cart_list!= null){
		 	for(Carrello c:cart_list){
	%>
	<div class= "form-group">
	
			
			<input type = "hidden" class = "form-control" name = "insert-id" value ="<%=c.getProdotto().getId()%>"  required readonly>
			
			<label>Prodotto</label>
			<input type = "text" class = "form-control" name = "insert-id" value ="<%=c.getProdotto().getNome()%>"  required readonly>
			
			<label>Quantità</label>
			<input type = "text" class = "form-control" name = "insert-quantity" value ="<%=c.getQuantity() %>"  required readonly>
			
			<label>Prezzo</label>
			<input type = "text" class = "form-control" name = "insert-prezzo" value ="<%=c.getProdotto().getPrezzo()%>"  required readonly>
		
		<br><br>
		</div>
	<%}}%>
	
	</div>

	
</div>

<div class= "form-group">

	<div class = "card-header text-center">
	Inserisci gli estremi di Pagamento
	</div>

	<label>Numero carta</label>
	<input type = "text" class = "form-control" name = "insert-indirizzo" id = "insert-indirizzo-carta" placeholder= "" required>
	
	<label>Intestatario</label>
	<input type = "text" class = "form-control" name = "insert-intestatario" id = "insert-intestatario"  placeholder= "ROSSI Mario" required>
	
	<label>Scadenza</label>
  	<input type ="text" class="form-control" name = "insert-scadenza" id = "insert-scadenza" placeholder = "mm/aa" required>
  	
  	<label>CVV</label>
	<input type = "password" class = "form-control" name = "insert-cvv" id = "insert-cvv"  placeholder= "***" required>

</div>

<div class= "form-group">

	<div class = "card-header text-center">
	Inserisci i dati di spedizione
	</div>

	<label>Indirizzo</label>
	<input type = "text" class = "form-control" name = "insert-indirizzo" id = "insert-indirizzo" placeholder= "via Giacomo Matteotti n.1" required>
	
	<label>CAP</label>
	<input type = "text" class = "form-control" name = "insert-cap"  id = "insert-cap"  placeholder= "84015" required>
	
	<label>CITTÀ</label>
  	<input type ="text" class="form-control" name = "insert-citta" id = "insert-citta" placeholder = "Nocera Superiore" required>
  	
  	<label>Provincia</label>
	<input type = "text" class = "form-control" name = "insert-provincia" id = "insert-provincia" placeholder= "Salerno" required>
	
	<br>
	<center>
	<button type = "submit" class = "btn btn-primary"> CONFERMA ORDINE </button>
	</center>

</div>


</div>
	
	

</form>
<script src="<%= request.getContextPath() %>/JS/AcquistoMultiploProdottoValidation.js"></script>
</div>
</div>


 <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>