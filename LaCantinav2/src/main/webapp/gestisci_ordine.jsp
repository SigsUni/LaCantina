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
  		response.sendRedirect("/LaCantinav2/index.jsp");
  	}
  	
  	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
  	
  	if(cart_list!=null)
  	{	
  		request.setAttribute("cart_list",cart_list);
  	}
  	
  	RigaOrdineDao riga_ordine = new RigaOrdineDao(ConnectToDB.getConnection());
  	RigaOrdine info_ordine = riga_ordine.getInfoById(Integer.parseInt(request.getParameter("id")));
  
  %>  



<!DOCTYPE html>
<html>
<head>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Gestione Ordine</title>

</head>
<body>
<jsp:include page="/fragments/header.jsp"></jsp:include>
<br><br><br>
<div class= "container">

	<div class = "card w-50 mx-auto my-5">
	
	<!-- card in generale -->
	
	<div class = "card-header text-center">
	Gestisci qui il tuo ordine <%= auth.getName() %>
	<h6><i>n.b. se lo stato dell'ordine è spedito/consegnato non puoi modificare alcun campo</i>
	
	<!--  card-header -->
	
	</div>
	
	<div class = "card-body">
	
	<!-- card body --> 
	
<%if(info_ordine.getStatoOrdine().equals("attesa di conferma") || info_ordine.getStatoOrdine().equals("preso in carico")){ %>
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
	
	<div class="mb-3">
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
    <option value="annullato">Annullato</option>
  </select>


</div>
<label>ID</label>
	<input type = "text" class = "form-control" name = "insert-id" value = "<%=info_ordine.getId() %>" required readonly>
	
	<button type = "submit" class = "btn btn-primary"> CONFERMA MODIFICHE </button>
	
	</div>
</form>
<%} else{%>
<form action ="" method = "GET" >

<div class= "form-group">

	<label>Indirizzo</label>
	<input type = "text" class = "form-control" name = "insert-indirizzo" value ="<%=info_ordine.getIndirizzo() %>"  readonly >

</div>

<div class= "form-group">

	<label>CAP</label>
	<input type = "text" class = "form-control" name = "insert-cap" value = "<%=info_ordine.getCap() %>" readonly >

</div>

<div class = "form-group">
	
	<div class="mb-3">
  	<label>CITTÀ</label>
  	<input type ="text" class="form-control" name = "insert-citta" value="<%=info_ordine.getCitta() %>" readonly >
</div>

<div class= "form-group">

	<label>Provincia</label>
	<input type = "text" class = "form-control" name = "insert-provincia" value = "<%=info_ordine.getProvincia() %>" readonly >

</div>

<div class= "form-group">

	<label>Prezzo totale ordine</label>
	<input type = "number" class = "form-control" name = "insert-prezzo" placeholder = "<%=info_ordine.getPrezzoTotale() %>" readonly >

</div>

<div class= "form-group">

<label for="stato">Stato ordine:</label>
  <input type = "text" class = "form-control" placeholder = "<%=info_ordine.getStatoOrdine() %>" readonly >
  

</div>
<label>ID</label>
	<input type = "text" class = "form-control" name = "insert-id" value = "<%=info_ordine.getId() %>" required readonly>
	</div>
</form>
<%} %>

</div>
</div>
</div>

 <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>