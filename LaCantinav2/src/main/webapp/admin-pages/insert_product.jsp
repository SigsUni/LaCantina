<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	Utente auth = (Utente)request.getSession().getAttribute("auth"); 
		  	
		  	if(auth!=null)
		  	{
		  		request.setAttribute("auth",auth);
		  		
		  		if(auth.getID() != 2)
		  	  	{
		  	  		response.sendRedirect("/uliveto/index.jsp");
		  	  	}
		  	}
		  	else
		  	{
		  		response.sendRedirect("/uliveto/index.jsp");
		  	}
		  	
		  	ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
		  	
		  	if(cart_list!=null)
		  	{	
		  		request.setAttribute("cart_list",cart_list);
		  	}
	%>  



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nuovo prodotto</title>
<%@include file = "admin_includes/header.jsp" %>
</head>
<body>
<%@include file = "admin_includes/navbar.jsp" %>
<div class= "container">

	<div class = "card w-50 mx-auto my-5">
	
	<!-- card in generale -->
	
	<div class = "card-header text-center">
	Nuovo inserimento
	
	<!--  card-header -->
	
	</div>
	
	<div class = "card-body">
	
	<!-- card body --> 
	

<form action ="<%= request.getContextPath() %>/insert-product" method = "GET" >

<div class= "form-group">

	<label>Nome prodotto</label>
	<input type = "text" class = "form-control" name = "insert-nome" placeholder = "Inserisci nome prodotto" required>

</div>

<div class= "form-group">

	<label>Categoria</label>
	<input type = "text" class = "form-control" name = "insert-categoria" placeholder = "Inserisci categoria" required>

</div>

<div class = "form-group">
	
	<div class="mb-3">
  	<label>Descrizione</label>
  	<textarea class="form-control" name="insert-descrizione" rows="3" placeholder="Inserisci la descrizione" required></textarea>
</div>

<div class= "form-group">

	<label>Stock</label>
	<input type = "number" class = "form-control" name = "insert-stock" placeholder = "quanti prodotti ci sono?" required>

</div>

<div class= "form-group">

	<label>Prezzo</label>
	<input type = "number" class = "form-control" name = "insert-prezzo" placeholder = "Inserisci prezzo" required>

</div>

<div class= "form-group">

	<label>Immagine</label>
	<input type = "text" class = "form-control" name = "insert-immagine" placeholder = "inserisci img.jpg" required>

</div>
	
	<button type = "submit" class = "btn btn-primary"> INSERISCI </button>
	
	</div>
</form>

</div>
</div>
</div>

<%@include file = "admin_includes/footer.jsp" %>
</body>
</html>