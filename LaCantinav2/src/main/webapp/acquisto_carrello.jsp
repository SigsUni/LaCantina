<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%User auth = (User)request.getSession().getAttribute("auth"); 
  	
  	if(auth!=null)
  	{
  		request.setAttribute("auth",auth);
  		
  	}
  	else
  	{
  		response.sendRedirect("/LaCantinav2/LoginAndRegistration.jsp");
  	}
  	
  	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	List<Cart> cartProduct = null;
  	
  	if(cart_list!=null)
  	{	
  		request.setAttribute("cart_list",cart_list);

		ProdottoDao pDao = new ProdottoDao(ConnectToDB.getConnection());
		cartProduct = pDao.getCartProducts(cart_list);
		float totale = pDao.getTotalCartPrice(cart_list);
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
	
<form action ="<%= request.getContextPath() %>/check-out" method = "GET" >

<div class= "form-group">

<div class = "card-header text-center">
	Riepilogo del tuo acquisto
	<h4><b><center>Prezzo Totale€ ${ (totale>0)?totale:0}</center></b></h4>
	<%if (cart_list!= null){
			 	for(Cart c:cartProduct){%>
	<div class= "form-group">
	
			<label>ID Prodotto</label>
			<input type = "text" class = "form-control" name = "insert-id" value ="<%=c.getId()%>"  required readonly>
			
			<label>Prodotto</label>
			<input type = "text" class = "form-control" name = "insert-id" value ="<%=c.getNome()%>"  required readonly>
			
			<label>Quantità</label>
			<input type = "text" class = "form-control" name = "insert-quantity" value ="<%=c.getQuantity() %>"  required readonly>
			
			<label>Prezzo</label>
			<input type = "text" class = "form-control" name = "insert-prezzo" value ="<%=c.getPrezzo()%>"  required readonly>
		
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
	<input type = "text" class = "form-control" name = "insert-indirizzo" placeholder= "" required>
	
	<label>Intestatario</label>
	<input type = "text" class = "form-control" name = "insert-intestatario" placeholder= "ROSSI Mario" required>
	
	<label>Scadenza</label>
  	<input type ="text" class="form-control" name = "insert-scadenza" placeholder = "01/01/2028" required>
  	
  	<label>CVV</label>
	<input type = "password" class = "form-control" name = "insert-cvv" placeholder= "***" required>

</div>

<div class= "form-group">

	<div class = "card-header text-center">
	Inserisci i dati di spedizione
	</div>

	<label>Indirizzo</label>
	<input type = "text" class = "form-control" name = "insert-indirizzo" placeholder= "via Giacomo Matteotti n.1" required>
	
	<label>CAP</label>
	<input type = "text" class = "form-control" name = "insert-cap" placeholder= "84015" required>
	
	<label>CITTÀ</label>
  	<input type ="text" class="form-control" name = "insert-citta" placeholder = "Nocera Superiore" required>
  	
  	<label>Provincia</label>
	<input type = "text" class = "form-control" name = "insert-provincia" placeholder= "Salerno" required>
	
	<br>
	<center>
	<button type = "submit" class = "btn btn-primary"> CONFERMA ORDINE </button>
	</center>

</div>


</div>
	
	

</form>

</div>
</div>


 <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>