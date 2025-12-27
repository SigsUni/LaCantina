<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    User auth = (User)request.getSession().getAttribute("auth"); 
  	
    List<Ordine> orders = null;
    UserDao NomeUser = null;
    
    
   
  
    
  	if(auth!=null)
  	{
  		request.setAttribute("auth",auth);
  		
  		if(auth.getID() != 2)
  		{
  			response.sendRedirect("/LaCantinav2/index.jsp");
  		}
  		
  		OrdineDao orderDao = new OrdineDao(ConnectToDB.getConnection());
  		orders = new OrdineDao(ConnectToDB.getConnection()).all_userOrders();
  		
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

<div class ="container">

	<div class ="card-header my-3">Tutti gli ordini</div>
	<table class="table table-light">
	<thead>
	
		<tr>
			<th scope ="col">ID</th>
			<th scope= "col">Data</th>
			<th scope ="col">Utente</th>
			<th scope= "col">Prodotto</th>
			<th scope= "col">Categoria</th>
			<th scope= "col">Quantità</th>
			<th scope= "col">Prezzo</th>
			<th scope= "col">Gestisci</th>
			
		</tr>
		
		<tbody>
			<% 
			if(orders!=null){
				
				for(Ordine o:orders)
				{
				NomeUser = new UserDao(ConnectToDB.getConnection());
				
				%>
				
				
				<tr>
					<td><%=o.getIdRigaOrdine() %></td>
					<td><%=o.getData() %></td>
					<td><%=NomeUser.getNomeById(o.getIdUtente()) %></td>
					<td><%=o.getNome() %></td>
					<td><%=o.getCategoria() %></td>
					<td><%=o.getQuantity() %></td>
					<td>€<%=o.getPrezzo() %></td>
					
					<td><a class = "btn btn-sm btn-danger" href="<%= request.getContextPath() %>/admin-pages/gestisci_ordini_admin.jsp?id=<%=o.getIdRigaOrdine()%>"> Gestisci Ordine</a></td>
					
					
				<% }
				
			}
		
		%>
		
		</tbody>
	
	
	
	</thead>
	
	
	
	
	
	
	
	
	</table>





</div>


<%@include file = "admin_includes/footer.jsp" %>
</body>
</html>