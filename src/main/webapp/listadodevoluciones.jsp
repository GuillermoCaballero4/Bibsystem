<%-- 
    Document   : listadodevoluciones
    Created on : 6 ago. 2024, 18:26:38
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
                <h1>Lista de devoluciones</h1>
                    <div class="text-center">
                                    <button type="button" class="btn btn-primary"  onclick="location.href = 'devoluciones.jsp'" name="boton">Agregar</button>
                                    <!-- comment            <label for="idfechaa">Fecha Inicio:</label>
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
                            <h2 class="card-title">Tabla de devoluciones</h2>
                            <!-- Default Table -->
                            <input type="text" id="filtroInput2" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                            <table class="table" >
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">fecha de la devolucion</th>
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
                        <input type="hidden" id="pkprestamo" name="pkprestamo">
                        <input type="hidden" name="pkanul" id="pkanul">
                        <input type="hidden" id="idlibro" name="idlibro">
                           <input type="hidden" id="cantidad_reserva" name="cantidad_reserva">
                        <p>¿Está seguro de querer anular la devolcion?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="anuldev">Sí</button>
                    </div>
                </div>
            </div>
        </div> 
    </form>
</main><!-- End #main -->
<script>
function filtrarTabla() {
    var input, filter, table, tr, td, i, j, txtValue;
    input = document.getElementById("filtroInput2");
    filter = input.value.toUpperCase();
    table = document.getElementById("resultados");
    tr = table.getElementsByTagName("tr");

    for (i = 1; i < tr.length; i++) {
        tr[i].style.display = "none"; // Ocultar todas las filas inicialmente
        td = tr[i].getElementsByTagName("td");
        for (j = 0; j < td.length; j++) { // Recorrer todas las celdas de la fila
            if (td[j]) {
                txtValue = td[j].textContent || td[j].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = ""; // Mostrar la fila si coincide con el filtro
                    break; // Dejar de buscar en esta fila si ya encontró una coincidencia
                }
            }
        }
    }
}

</script>
<%@include file="footer.jsp"%>
<script>
    $(document).ready(function () {
        llenadoreserva();
    });
    function llenadoreserva() {
        $.ajax({
            data: {listar: 'listarre'},
            url: 'jsp/devolucion.jsp',
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
   $("#anuldev").click(function () {
        idpkreserva = $("#pkanul").val();
        idprestamo = $("#pkprestamo").val();
        cantidad_reserva = $("#cantidad_reserva").val();
        idlibro = $("#idlibro").val();
        $.ajax({
            data: {listar: 'anuldev',idpkreserva:idpkreserva, idprestamo : idprestamo,cantidad_reserva:cantidad_reserva,idlibro:idlibro},
            url: 'jsp/devolucion.jsp',
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
        var url = 'reportdevolciones.jsp?idfechaa=' + encodeURIComponent(fechaInicio) + '&idfechab=' + encodeURIComponent(fechaFin) + '&e=' + encodeURIComponent(E);
        
        // Abrir la URL en una nueva pestaña
        window.open(url, '_blank');
    });
    
    
    
</script>
<script>
 
//document.getElementById("idfechab").innerHTML = d + "/" + m + "/" + y;

</script>

