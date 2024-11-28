<%@include file="header.jsp"%> 
<main id="main" class="main">

    <div class="pagetitle">
        <h1>Bibsystem</h1>
        
    </div><!-- End Page Title -->

    <h1>Bienvenido al sistema: <% out.print(sesion.getAttribute("user")); %></h1>
    
   

</main><!-- End #main -->

<%@include file="footer.jsp"%>