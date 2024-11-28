<%-- 
    Document   : ajuste
    Created on : 13 sept. 2024, 17:19:53
    Author     : david
--%>


<%@include file="header.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>


<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form"  class="">
    <input type="hidden" name="listar" id="listar" value="modificar">
    <input type="hidden" name="idajuste" id="idajuste">

    <div class="container ">
       

        <!-- La tabla debajo del formulario -->
       <div class="row">
    <div class="col">
        <div class="card">
            <div class="card-body">
                <h1 class="card-title text-center">Tabla de disponibilidad</h1>
                <div class="col-6">
                    <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                </div>
                
                <table class="table" id="resultado">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">libro</th>
                            <th scope="col">Cantidad disponible</th>
                           <!-- <th scope="col">Opciones</th> -->
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
    </div>

    
</form>

</main><!-- End #main -->
<%@include file="footer.jsp"%>
<script>
    $(document).ready(function () {
        rellenardatos();
       // alert("hola");
    });  // Cerramos correctamente la función

    function rellenardatos() { 
        $.ajax({
            data: { listar: 'listar' },
            url: 'jsp/disponibilidad.jsp',
            type: 'post',
            success: function (response) {
                $("#resultado tbody").html(response);
              //  alert("Respuesta recibida: " + response); // Alert para verificar la respuesta
            },
            error: function (error) {
                console.log("Error en la solicitud AJAX: ", error);
              //  alert("Error en la solicitud AJAX.");
            }
        });
    }
</script>

