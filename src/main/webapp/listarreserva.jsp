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
<%
    // Obtener la fecha actual
    Date fechaActualww = new Date();

    // Crear un formateador de fecha
    SimpleDateFormat formateadorFechaww = new SimpleDateFormat("yyyy-MM-dd");

    // Formatear la fecha
    String fechaFormateadaww = formateadorFechaww.format(fechaActualww);
  // Crear un formateador para convertir a formato compatible con "date" (yyyy-MM-dd)
  

%>
<main id="main" class="main">
    
    <form action="#" method="post" id="form"  onsubmit="return false" class="row g-3"> 
       
        <div class="container text-center">
            <div class="row">
               <h1>Lista de reservas</h1>
<div class="text-center">
    <button type="button" class="btn btn-primary" onclick="location.href = 'reservas.jsp'" name="boton">Agregar</button>
    <!-- comment 
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
    <button class="btn btn-secondary" id="imprimir-informe">Imprimir Informe</button> -->
</div>
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title">Tabla de reservas</h2>
                            <!-- Default Table -->
                            
                            <table class="table" >
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">fecha de la reserva</th>
                                        <th scope="col">persona</th>
                                        <th scope="col">estado</th>
                                        <th scope="col">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody id="resultados">
                                </tbody>
                            </table>
                            <!-- End Default Table Example -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="basicModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"></h5>
                        <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        
                        <input type="hidden" name="pkanul" id="pkanul">
                        <p>¿Está seguro de querer eliminar la reserva?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="anulreserva">Sí</button>
                    </div>
                </div>
            </div>
        </div> 
    </form>
</main><!-- End #main -->
<%@include file="footer.jsp"%>
<script>
    $(document).ready(function () {
        llenadoreserva();
    });
    function llenadoreserva() {
        $.ajax({
            data: {listar: 'listarre'},
            url: 'jsp/reserva.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                $("#resultados").html(response);
                //sumador();
                
            }
        });
    }
   $("#anulreserva").click(function () {
        idpkreserva = $("#pkanul").val();
        $.ajax({
            data: {listar: 'anularreserva',idpkreserva:idpkreserva},
            url: 'jsp/reserva.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                llenadoreserva();
                //sumador();

            }
        });
    });
</script>

<script>
    document.getElementById('imprimir-informe').addEventListener('click', function() {
        var fechaInicio = document.getElementById('idfechaa').value;
        var fechaFin = document.getElementById('idfechab').value;
        var E = document.getElementById('e').value;
        
        // Verifica que las fechas no sean nulas
        if (!fechaInicio || !fechaFin) {
            alert("Por favor, selecciona ambas fechas.");
            return;
        }
        
        // Construir la URL para el informe
        var url = 'reportreserva.jsp?idfechaa=' + encodeURIComponent(fechaInicio) + '&idfechab=' + encodeURIComponent(fechaFin) + '&e=' + encodeURIComponent(E);
        
        // Abrir la URL en una nueva pestaña
        window.open(url, '_blank');
    });
</script>

