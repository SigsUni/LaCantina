<%@page import = "it.unisa.lacantina.control.*" %>
<%@page import = "it.unisa.lacantina.model.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    User auth = (User)request.getSession().getAttribute("auth"); 
  	
    List<Ordine> orders = null;
    UserDao NomeUser = null;
    
    
   RigaOrdine info_ordine = null;
   RigaOrdineDao riga_ordine = null;
  
    
  	if(auth!=null)
  	{
  		request.setAttribute("auth",auth);
  		
  		if(auth.getID() != 2)
  		{
  			response.sendRedirect("/LaCantinav2/index.jsp");
  		}
  		
  		OrdineDao orderDao = new OrdineDao(ConnectToDB.getConnection());
  		orders = new OrdineDao(ConnectToDB.getConnection()).all_userOrders();
  		
  		riga_ordine = new RigaOrdineDao(ConnectToDB.getConnection());
  	  	info_ordine = riga_ordine.getInfoById(Integer.parseInt(request.getParameter("id")));
  		
  	}
  	else
  	{
  		response.sendRedirect("/LaCantinav2/index.jsp");
  	}
  	
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
  	
  	if(cart_list!=null)
  	{	
  		request.setAttribute("cart_list",cart_list);
  	}
  %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordini</title>
<%@include file = "admin_includes/header.jsp" %>
</head>
<body>
<%@include file = "admin_includes/navbar.jsp" %>

<div class = "card-header text-center">
	<b>IMPOSTA I NUOVI DATI</b>
	
	<!--  card-header -->
	
	</div>
	<div class= "container">

	<div class = "card w-50 mx-auto my-5">
	
	<!-- card in generale -->
	
	
<div class = "card-body">
	
	<!-- card body --> 

<form action ="<%= request.getContextPath() %>/modifica-dati" method = "GET" >

<div class= "form-group">

	<label>Indirizzo</label>
	<input type = "text" class = "form-control" name = "insert-indirizzo" value ="<%=info_ordine.getIndirizzo() %>"  required>

</div>

<div class= "form-group">

	<label>CAP</label>
	<input type = "text" class = "form-control" name = "insert-cap" value = "<%=info_ordine.getCap() %>" required>

</div>

<div class = "form-group">
	
  	<label>CITTÀ</label>
  	<input type ="text" class="form-control" name = "insert-citta" value="<%=info_ordine.getCitta() %>" required>
</div>

<div class= "form-group">

	<label>Provincia</label>
	<input type = "text" class = "form-control" name = "insert-provincia" value = "<%=info_ordine.getProvincia() %>" required>

</div>

<div class= "form-group">

	<label>Prezzo totale ordine</label>
	<input type = "number" class = "form-control" name = "insert-prezzo" placeholder = "<%=info_ordine.getPrezzoTotale() %>" readonly required>

</div>

<div class= "form-group">

<label for="stato">Imposta uno stato ordine:</label>
  <select id="stato_ordine" name="stato_ordine">
    <option value="stato_attuale"><%=info_ordine.getStatoOrdine() %></option>
    <option value="attesa di conferma">attesa di conferma</option>
    <option value="preso in carico">preso in carico</option>
    <option value="spedito">spedito</option>
    <option value="in consegna">in consegna</option>
    <option value="annullato">annullato</option>
  </select>

</div>
<label>ID</label>
	<input type = "text" class = "form-control" name = "insert-id" value = "<%=info_ordine.getId() %>" required readonly>
	<br>
	<center><button type = "submit" class = "btn btn-primary"> CONFERMA MODIFICHE </button></center>
	
</div></div></div>

</form>

<%@include file = "admin_includes/footer.jsp" %>
</body>
</html>