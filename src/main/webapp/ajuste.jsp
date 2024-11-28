<%-- 
    Document   : ajuste
    Created on : 13 sept. 2024, 17:19:53
    Author     : david
--%>


<%@include file="header.jsp"%>
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
<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form"  class="">
    <input type="hidden" name="listar" id="listar" value="modificar">
    <input type="hidden" name="idajuste" id="idajuste">

    <div class="container ">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <!-- comment --> 
                        
                        <h1 class="card-title text-center" >Formulario de los ajustes</h1>
                       
                       
   
        
       <div class="container mt-5">
    <div class="row justify-content-center">
        
        <!-- Selección de Libro -->
        <div class="col-md-6 mb-3">
            <label for="idlibro" class="form-label fw-bold">Libro</label>
            <select name="idlibro" id="idlibro" class="select2 form-control">
                <!-- Opciones del select -->
            </select>
        </div>

        <!-- Fecha del Ajuste -->
        <div class="col-md-6 mb-3">
            <label for="fecha_ajuste" class="form-label fw-bold">Fecha del ajuste</label>
            <input type="text" class="form-control" id="fecha_ajuste" name="fecha_ajuste" 
                   placeholder="Ingrese Fecha" value="<%= fechaFormateada %>" readonly>
        </div>

        <!-- Cantidad + Botones de Ajuste -->
       <div class="col-md-6 mb-3">
    <label for="cantidad_ajuste" class="form-label fw-bold">Cantidad</label>
    <!-- Contenedor para input con botones integrados -->
    <div class="input-group">
        <input type="number" class="form-control" id="cantidad_ajuste" name="cantidad_ajuste" 
               placeholder="Ingrese la cantidad" style="max-width: 300px;" value="1" step="1">
        <button class="btn btn-success" type="button" id="incrementBtn">
            <i class="bi bi-plus-circle"></i>
        </button>
        <button class="btn btn-danger" type="button" id="decrementBtn">
            <i class="bi bi-dash-circle"></i>
        </button>
    </div>
</div>

        <!-- Botón Cargar e Imprimir -->
        <div class="col-12 text-center">
            <button type="button" class="btn btn-primary me-2" id="boton" name="boton">Confirmar</button>
            <!--- <a class="btn btn-secondary" target="_blank" href="reportcategoria.jsp">Imprimir</a> --->
        </div>
        
    </div>
</div>



        
    


                        
                    </div>
                </div>
            </div>
        </div>

        <!-- La tabla debajo del formulario -->
       <div class="row">
    <div class="col">
        <div class="card">
            <div class="card-body">
                <h1 class="card-title text-center">Tabla de ajustes</h1>
                <div class="col-6">
                    <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                </div>
                <table class="table" id="resultado">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Cantidad de ajuste</th>
                            <th scope="col">libro</th>
                            <th scope="col">Fecha de ajuste</th>
                            <th scope="col">Opciones</th>
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
        buscarlibros();

        $("#boton").on("click", function () {
            var idajuste = $("#idajuste").val().trim();
            var cantidad_ajuste = $("#cantidad_ajuste").val().trim();
            var idlibro = $("#idlibro").val().trim();
            var fecha_ajuste = $("#fecha_ajuste").val().trim();
                
              if (idlibro === "" || idlibro === null) {
        alert("Por favor, selecciona un libro antes de continuar.");
        return; // Detener el proceso si no hay un libro seleccionado
    }
            var datosform = $("#form").serialize();
            console.log("Datos del formulario: ", datosform);
            $.ajax({
                data: datosform,
                url: 'jsp/ajuste.jsp',
                type: 'post',
                success: function (response) {
                    $("#mensaje").html(response);
                    rellenardatos();
                    setTimeout(function () {
                        $("#mensaje").html("");
                        $("#cantidad_ajuste").val("");
                         $("#idlibro").val(null).trigger('change');  // 
                        $("#fecha_ajuste").val("");
                        $("#listar").val("modificar");
                        
                    }, 2000);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        });
    });

    function rellenardatos() {
        $.ajax({
            data: { listar: 'listar' },
            url: 'jsp/ajuste.jsp',
            type: 'post',
            success: function (response) {
                $("#resultado tbody").html(response);
                 
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
function buscarlibros() {
    return $.ajax({
        data: {listar: 'buscarlibros'},
        url: 'jsp/consulta_libros.jsp',
        type: 'post',
        success: function (response) {
            $("#idlibro").html(response); // Recarga las opciones
        }
    });
}

function rellenaredit(id, cantidad, libro, fecha) {
    $("#idajuste").val(id);
    $("#cantidad_ajuste").val(cantidad);
    $("#fecha_ajuste").val(fecha);

    // Cargar las opciones y seleccionar el valor
    
        // Selecciona el valor en el select
        $("#idlibro").val(libro).trigger('change');
    

    $("#listar").val("modificar");
}


</script>
<script>
    document.getElementById('incrementBtn').addEventListener('click', function() {
        var input = document.getElementById('cantidad_ajuste');
        input.value = parseInt(input.value) + parseInt(input.step);
    });

    document.getElementById('decrementBtn').addEventListener('click', function() {
        var input = document.getElementById('cantidad_ajuste');
        var newValue = parseInt(input.value) - parseInt(input.step);
        if (newValue >= 0) { // Evita valores negativos
            input.value = newValue;
        }
    });
</script>