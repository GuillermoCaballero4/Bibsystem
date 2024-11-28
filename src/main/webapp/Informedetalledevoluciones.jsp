<%-- 
    Document   : Informedetalledevoluciones
    Created on : 27 nov. 2024, 17:28:53
    Author     : david
--%>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Obtener la fecha actual
    Date fechaActual = new Date();

    // Crear un formateador de fecha
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");

    // Formatear la fecha
    String fechaFormateada = formateadorFecha.format(fechaActual);
%>
<%
    // Obtener la fecha actual
    Date fechaActualww = new Date();

    // Crear un formateador de fecha
    SimpleDateFormat formateadorFechaww = new SimpleDateFormat("yyyy-MM-dd");

    // Formatear la fecha
    String fechaFormateadaww = formateadorFechaww.format(fechaActualww);
%>
<%@include file="header.jsp"%>
<main id="main" class="main">

<h1>Detalles de las devoluciones  </h1>
<div class="text-center">
    <!-- Formulario con método POST y target="_blank" -->
    <form action="reportreservadetalle.jsp" method="POST" target="_blank">
    
        <label for="idfechaa">Fecha Inicio:</label>
        <input type="date" name="idfechaa" id="idfechaa" value="<%= fechaFormateadaww %>">
        
        <label for="idfechab">Fecha Fin:</label>
        <input type="date" name="idfechab" id="idfechab" value="<%= fechaFormateadaww %>">
        
        <label for="titulo_libro" class="form-label">Libro</label>
        <select class="select2 form-control" name="titulo_libro" id="titulo_libro" style="width: 200px;">
            <!-- Los elementos del select se llenarán dinámicamente -->
        </select>

        <br><br>
        <!-- Botón de envío -->
        <button type="submit" class="btn btn-secondary">Imprimir Informe</button>
    </form>
</div>

</main><!-- End #main -->
<%@include file="footer.jsp"%>

<script>
    $(document).ready(function () {
        // Llenar el select de libros con datos obtenidos mediante AJAX
        seleccionarLibro();
    });
    
    function seleccionarLibro() {
        $.ajax({
            url: 'jsp/consultalibro.jsp',
            type: 'post',
            success: function (response) {
                // Cargar los libros en el select
                $("#titulo_libro").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
</script>

