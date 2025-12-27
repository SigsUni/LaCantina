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
                    	  		response.sendRedirect("/uliveto/admin-pages/admin_index.jsp");
                    	  	}
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

<style type="text/css">

	h3,h4{
		
		color:crimson;
		text-align:center;
	
	}


</style>

<meta charset="UTF-8">
<title>Errore</title>
<%@include file = "admin_includes/header.jsp" %>
</head>
<body>
<%@include file = "admin_includes/navbar.jsp" %>

<div class="container">
<h3> Errore durante l'inserimento di un nuovo prodotto</h3>
<h4><a href = 'insert_product.jsp'> Controllare i campi e ritentare</a> </h4>

</div>

<%@include file = "admin_includes/footer.jsp" %>
</body>
</html>