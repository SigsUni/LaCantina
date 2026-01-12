<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="it.unisa.lacantina.model.domain.*" %>
<%@page import="it.unisa.lacantina.model.dao.*" %>
<%@page import="it.unisa.lacantina.util.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.*" %>

<%
    Utente auth = (Utente)request.getSession().getAttribute("auth"); 
    if(auth != null) {
        request.setAttribute("auth",auth);
    } 
    else{
    	  request.setAttribute("errorMessage", "Operazione non consentita");
		  request.getRequestDispatcher("/errore_generico.jsp").forward(request, response);
    }
    ArrayList<Carrello> cart_list = (ArrayList<Carrello>) session.getAttribute("cart-list");
    if(cart_list != null){
        request.setAttribute("cart_list", cart_list);
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop - LaCantina</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <link href="./CSS/shopcss.css" rel="stylesheet" type="text/css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-info text-white text-center">
            <h3>✅ Successo</h3>
        </div>

        <div class="card-body text-center">
            <%
                String msg = (String) request.getAttribute("successMessage");
                if (msg != null) {
            %>
                <div class="alert alert-warning">
                    <%= msg %>
                </div>
            <%
                }
            %>

            <a href="<%= request.getContextPath() %>/" class="btn btn-primary">
                Torna alla Home
            </a>
        </div>
    </div>
</div>

<script>
    
    setTimeout(function() {
        window.location.href = "<%= request.getContextPath() %>/index.jsp";
    }, 2000);
</script>

  <jsp:include page="/fragments/footer.jsp"></jsp:include>
    <script type="text/javascript" src="./JS/index.js"></script>

</body>

</html>