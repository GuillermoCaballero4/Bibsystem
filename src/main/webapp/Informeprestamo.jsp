<%-- 
    Document   : Informeprestamo
    Created on : 27 nov. 2024, 17:13:13
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
  // Crear un formateador para convertir a formato compatible con "date" (yyyy-MM-dd)
  

%>
<%@ include file="header.jsp"%>
<main id="main" class="main">

<h1>Prestamos  </h1>
<div class="text-center">
    <!-- Definir el formulario con el método GET (puedes usar POST si prefieres) -->
    <form action="reportprestamo.jsp" method="post" target="_blank">
        
        <label for="idfechaa">Fecha Inicio:</label>
        <input type="date" name="idfechaa" id="idfechaa" value="<%= fechaFormateadaww %>">
        
        <label for="idfechab">Fecha Fin:</label>
        <input type="date" name="idfechab" id="idfechab" value="<%= fechaFormateadaww %>">

        <label for="e">Estado</label>
        <select class="select2" name="e" id="e" style="width: 200px;">
            <option value="Todos">Todos</option>
            <option value="Finalizado">Finalizado</option>
            <option value="Anulado">Anulado</option>
            <option value="Cancelado">Cancelado</option>
        </select>

        <label for="nombre_usu">Usuario</label>
        <select class="select2" name="nombre_usu" id="nombre_usu" style="width: 200px;">
        </select>

        <!-- Botón de envío, tipo submit -->
        <button type="submit" class="btn btn-secondary">Imprimir Informe</button>
    </form>
</div>

</main><!-- End #main -->
<%@include file="footer.jsp"%>

<script>
    $(document).ready(function () {
        seleccionarusuario();
    });

    function seleccionarusuario() {
        $.ajax({
            url: 'jsp/consultar_usuario.jsp',
            type: 'post',
            success: function (response) {
                $("#nombre_usu").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
</script>

