<%@page import = "cn.uliveto.connection.DbCon" %>
<%@page import ="cn.uliveto.model.*" %>
<%@page import = "java.util.*" %>
<%@page import = "cn.uliveto.dao.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    Utente auth = (Utente)request.getSession().getAttribute("auth"); 
  	
    List<Ordine> orders = null;
    
    
   
  
    
  	if(auth!=null)
  	{
  		request.setAttribute("auth",auth);
  		
  		if(auth.getId() != 2)
  		{
  			response.sendRedirect("/uliveto/index.jsp");
  		}
  		
  		OrderDao orderDao = new OrderDao(DbCon.getConnection());
  		orders = new OrderDao(DbCon.getConnection()).all_userOrders();
  		
  	}
  	else
  	{
  		response.sendRedirect("/uliveto/index.jsp");
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
			<th scope= "col">Data</th>
			<th scope ="col">Utente</th>
			<th scope= "col">Nome</th>
			<th scope= "col">Categoria</th>
			<th scope= "col">Quantità</th>
			<th scope= "col">Prezzo</th>
			<th scope= "col">Cancella</th>
			
		</tr>
		
		<tbody>
			<% 
			if(orders!=null){
				
				for(Ordine o:orders)
				{%>
				
				<tr>
					
					<td><%=o.getDate() %></td>
					<td><%=o.getUsername() %></td>
					<td><%=o.getName() %></td>
					<td><%=o.getCategory() %></td>
					<td><%=o.getQuantity() %></td>
					<td>€<%=o.getPrice() %></td>
					
					<td><a class = "btn btn-sm btn-danger" href="/uliveto/cancel-order?id=<%=o.getOrderId() %>"> Elimina</a></td>
					
					
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