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
              			response.sendRedirect("/LaCantinav2/index.jsp");
              		}
              	}
              	else
              	{
              		response.sendRedirect("/LaCantinav2/index.jsp");
              	}
              	
              	ProdottoDao pd = new ProdottoDao(ConnectToDB.getConnection());
              	List<Prodotto> products = pd.getAllProdotti();
              	FornitoreDao fdao = new FornitoreDao(ConnectToDB.getConnection());
            %>  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LaCantina</title>
  <%@include file = "admin_includes/header.jsp" %>
</head>
<body>
<%@include file = "admin_includes/navbar.jsp" %>

<div class = "container">
	<% if(auth!=null ){%>
	<br>
	<h4><p>Benvenuto ADMIN</p></h4>
	<br>
	<%}%>
	<div class = "card-header my-3">TUTTI I PRODOTTI</div>
	
	<div class="row g-3">
	
	<% 
	if(!products.isEmpty())
	{
		for(Prodotto p:products)
		{%>
			<%if(p.checkActive()){ %>
			<div class="col-12 col-md-6 col-lg-4 gy-3">
			<div class="card w-100" style="width: 8rem;">
				<a href="#">
  				<img class="card-img-top" src="<%= request.getContextPath() %>/IMG/<%= p.getImmagine() %>" alt="Card image cap"></a>
  					<div class="card-body">
    				<h5 class="card-title"><%= p.getNome() %></h5>
    				<h6 class = "price">Prezzo €<%= p.getPrezzo() %></h6>
    				<h6 class = "category">Categoria: <%= p.getCategoria() %></h6>
    				<h6 class="category">Fornitore: <%= fdao.getNomeById(p.getIdFornitore())%></h6>
    				<h6 class = "stock">Stock: <% if(p.getStock()!=0){%> <%= p.getStock()%> <%}else{ %><b><font color="red" >Out of Stock</font></b><%} %></h6>
    				<div class = "mt-3 justify-content -between ">
    				</div>
    				<div class="form-group d-flex justify-content-between w-50">
    				
    				<form action="<%= request.getContextPath() %>/add-stock" method="GET" class="form-inline d-flex" >
					<input type="number" name ="stock_add" class="form-control w-100" value="" placeholder="">
				  	ID <input type="text" name="id" class="form-control w-75"  value="<%=p.getId() %>" readonly>
				  	<button type="submit" class="btn btn-primary">Aggiungi</button>
				  	</form>
				  	
				  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  	
				  	<form action="<%= request.getContextPath() %>/remove-stock"delete-stock" method="GET" class="form-inline d-flex">
				  	<input type="number" name ="stock_remove" class="form-control w-100" value="" placeholder="">
				  	ID <input type="text" name="id" class="form-control w-75"  value="<%=p.getId() %>" readonly>
				  	<button type="submit" class="btn btn-danger">&nbsp;Rimuovi&nbsp;</button>
				  	</form>
						</div>
    				 
    					<a href="<%= request.getContextPath() %>/delete-prodotto?id=<%=p.getId()%>" class="btn btn-danger col-md-8 ">ELIMINA PRODOTTO</a> 
    				<div class = "mt-3 justify-content -between ">
    				<p class="card-text"><%=p.getDescrizione() %></p>
    				</div>
    				
  				</div>
			</div>
		</div>
			
		<%}
			}
		}
	
	%>
	
	</div>
	</div>


	

 <%@include file = "admin_includes/footer.jsp" %>
</body>
</html>