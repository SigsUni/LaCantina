<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@page import="it.unisa.lacantina.model.*" %>
    <%@page import="it.unisa.lacantina.control.*" %>
    <%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<% 
		User auth = (User)request.getSession().getAttribute("auth"); 
		RigaOrdineDao riga_ordine = new RigaOrdineDao(ConnectToDB.getConnection());

		List<Ordine> ordini = null;
		if(auth != null)
		{
			request.setAttribute("auth",auth);
			ordini = new OrdineDao(ConnectToDB.getConnection()).userOrders(auth.getID());
		}
		else{
			response.sendRedirect("LoginAndRegistration.jsp");
		}
		
		ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
		List<Cart> cartProduct = null;
		if(cart_list != null){
			request.setAttribute("cart_list", cart_list);
		}
%>
<meta charset="UTF-8">
<title>Ordini</title>

      <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" contex="ie=edge">
      
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> <!--  BOOTSTRAP IMPORT -->
    
        <title>
            Home Page
        </title>
       
        <link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
</head>
<body>
<jsp:include page="/fragments/header.jsp"></jsp:include>

<br>
<br>
<br>
<br>
<br>
<div class="container">

	<div class ="card-header my-3">Ordini</div>
	<table class = "table table-light">
	<thead>
	<tr>
	<th scope = "col">ID</th>
	<th scope = "col">Data</th>
	<th scope = "col">Prodotto</th>
	<th scope = "col">Prezzo</th>
	<th scope = "col">Quantità</th>
	<th scope = "col">Stato</th>
	</tr>
	</thead>
	<tbody>
	<%
		if(ordini !=null){
			
			for(Ordine o:ordini){%>
			<tr>
				<td><%= o.getIdRigaOrdine() %>
				<td><%= o.getData() %></td>
				<td><%= o.getNome() %></td>
				<td><%= o.getPrezzo() %></td>
				<td><%= o.getQuantity() %></td>
				<td><a class = "btn btn-sm btn-danger" href="<%= request.getContextPath() %>/gestisci_ordine.jsp?id=<%= o.getIdRigaOrdine() %>">Gestisci</a></td>
				
			<tr>
			<% }
			
		}
	
	
	%>
	
	
	</tbody>
	</table>
	
</div>

 <jsp:include page="/fragments/footer.jsp"></jsp:include>
</body>
</html>