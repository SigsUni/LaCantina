<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import="it.unisa.lacantina.model.service.*" %>
<%@page import="java.util.*" %>
     
<%
     Utente auth = (Utente)request.getSession().getAttribute("auth"); 
               		if(auth != null)
               		{
               	request.setAttribute("auth",auth);
               		}
               		
               		ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
               		
               		
               		if(cart_list != null){
               	CarrelloService cService = new CarrelloService();
               	float totale = cService.getTotalCartPrice(cart_list);
               	request.setAttribute("cart_list", cart_list);
               	 request.setAttribute("totale", totale); 
               		}
     %>
<!DOCTYPE html>
<html>
<head>
 		<link rel="icon" type="image/png" href="IMG/logo_lacantina.png">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"rel="stylesheet">
        
       <!--   <style type="text/css">
        
        .table tbody td{
        vartical-align: middle;}
        
        .btn-incre, .btn-decre{
        
        box-shadow: none;
        font-size:25px;
        
        }
        
        </style>
         -->
        
<meta charset="UTF-8">
<title>Carrello</title>
</head>
<body>
 <jsp:include page="/fragments/header.jsp"></jsp:include>
 <br>
 <br>
 <br>
 <br>
 <br>
  
  
  
  
 <div class = "container">
 
 <div class ="d-flex py-3"><h3>Conto:€ ${ (totale>0)?totale:0}</h3>
 <a class="mx-3 btn btn-primary" href ="<%=request.getContextPath()%>/acquisto_carrello.jsp">CheckOut</a></div>
 <table class = "table table-loght">
 
 <thread>
 <tr>
 <th scope = "col">Nome</th>
 <th scope = "col">Categoria</th>
 <th scope = "col">Prezzo</th>
 <th scope = "col">Acquista</th>
 <th scope = "col">Annulla</th>
 </tr>
 
 <tbody>
 <%
 if (cart_list!= null){
  	for(Carrello c:cart_list)
  	{
 %>
 			
 		<tr>
 	 		<td><%=c.getProdotto().getNome() %></td>
 	 			<td><%=c.getProdotto().getCategoria() %></td>
 	 				<td><%=c.getProdotto().getPrezzo() %></td>
 	 					<td> 
 	 						<form method="post"
      class="form-inline"
      action="<%= request.getContextPath() %>/acquisto_singolo_prodotto.jsp">

    		<input type="hidden" name="id" value="<%= c.getProdotto().getId() %>">
    		<input type="hidden" name="prezzo" value="<%= c.getProdotto().getPrezzo() %>">
    		<input type="hidden" name="quantity" value="<%= c.getQuantity() %>">
    		<input type="hidden" name="nome" value ="<%=c.getProdotto().getNome()%>">

    	<div class="form-group d-flex justify-content-between">
       	 	<div class="d-flex align-items-center gap-1">

            <a class="btn btn-sm btn-decre px-1 py-0"
               href="quantity-inc-dec?action=dec&id=<%=c.getProdotto().getId()%>">
                <i class="fas fa-minus-square"></i>
            </a>

            <input type="text"
                   class="form-control form-control-sm text-center"
                   style="width: 40px;"
                   value="<%= c.getQuantity() %>"
                   readonly>

            <% if (c.getProdotto().checkStock(c.getQuantity() + 1)) { %>
                <a class="btn btn-sm btn-incre px-1 py-0"
                   href="quantity-inc-dec?action=inc&id=<%=c.getProdotto().getId()%>">
                    <i class="fas fa-plus-square"></i>
                </a>
            <% } %>

            <button type="submit" class="btn btn-primary btn-sm">Buy</button>

        </div>
    </div>
</form>
 	 					</td>
 	 						<td><a class = "btn btn-sm btn-danger" href="remove-from-cart?id=<%=c.getProdotto().getId()%>">Rimuovi</a></td>
 	 			</tr>
 	<%}
 	} %>
 
 
 
 </tbody>
 
 </table>
 </div>
 
 
 
 <jsp:include page="/fragments/footer.jsp"></jsp:include>

</body>
</html>