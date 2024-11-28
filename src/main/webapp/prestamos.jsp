<%@include file="header.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Obtener la fecha actual
    Date fechaActual = new Date();
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat formateadorFecha2 = new SimpleDateFormat("dd-MM-yyyy");
    String fechaFormateada = formateadorFecha.format(fechaActual);
    String fechaFormateada2 = formateadorFecha2.format(fechaActual);
%>

<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form-prestamo" onsubmit="return false" class="row g-3">
        <input type="hidden" name="listar" id="listar" value="cargar">

        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h2 class="card-title text-primary text-center mb-4">Datos del Préstamo</h2>
                            <input type="hidden" name="idlibro" id="idlibro" class="form-control">
                            <input type="hidden" name="idpersona" id="idpersona" class="form-control">

                            <!-- Persona -->
                            <div class="row mb-3">
                                <div class="col-6">
                                    <label for="idpersona" class="form-label">Persona</label>
                                    <select name="idreserva" id="idreserva" class="select2 form-control" onchange="dividirPersona(this.value)">
                                        <!-- Opciones cargadas dinámicamente -->
                                    </select>
                                </div>

                                <!-- CI Persona -->
                                <div class="col-6">
                                    <label for="ci_persona" class="form-label">CI</label>
                                    <input type="number" class="form-control" id="ci_persona" name="ci_persona" readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <!-- Usuario -->
                                <div class="col-6">
                                    <label for="idusuario" class="form-label">Usuario</label>
                                    <input type="hidden" id="idusuario" name="idusuario" value="<% out.print(sesion.getAttribute("idusuario")); %>">
                                    <input type="text" class="form-control" value="<% out.print(sesion.getAttribute("user")); %>" readonly>
                                </div>

                                <!-- Fecha Préstamo -->
                                <div class="col-6">
                                    <label for="fechaprestamo" class="form-label">Fecha del Préstamo</label>
                                    <input type="text" class="form-control" id="fechaprestamo" name="fechaprestamo" value="<%= fechaFormateada %>" readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <!-- Fecha Devolución -->
                                <div class="col-6">
                                    <label for="fechadevolucion" class="form-label">Fecha de Devolución</label>
                                    <input type="date" class="form-control" id="fechadevolucion" name="fechadevolucion">
                                </div>
                                <!-- Cantidad -->
                                <div class="col-6 ">
                                    <label for="cantidad_reserva" class="form-label">Cantidad</label>
                                    <input type="number" class="form-control" id="cantidad_reserva" name="cantidad" placeholder="Ingrese la cantidad" readonly>
                                </div>
                            </div>

                            <!-- Tabla de Libros Reservados -->
                            <div class="container my-4">
                                <div class="card shadow-sm">
                                    <div class="card-body">
                                        <h3 class="card-title text-primary text-center mb-4">Libros Reservados</h3>
                                        <table class="table table-bordered table-hover" id="tabla-libros-reservados">
                                            <thead class="table-primary">
                                                <tr>
                                                    <th>Título del Libro</th>
                                                    <th>Cantidad</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Botón para agregar detalle -->
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-primary" id="agregar-detalle">Agregar Préstamo</button>
                                <div id="respuesta" class="mt-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabla para mostrar los libros agregados -->
            <div class="container my-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-primary text-center mb-4">Libros Agregados</h2>
                        <table class="table table-bordered table-hover" id="tabla">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Libro</th>
                                    <th>Cantidad</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Modal de Confirmación -->
            <div class="modal fade" id="basicModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Confirmación</h5>
                            <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="pkdel" id="pkdel">
                            <p>¿Está seguro de querer eliminar los datos del registro?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="delreserva">Sí</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Botones de acción -->
            <div class="text-center mt-4">
                <button type="button" class="btn btn-danger me-2" id="cancelar-prestamo">Cancelar Préstamo</button>
                <button type="button" class="btn btn-success" id="registrar-prestamo">Registrar Préstamo</button>
            </div>
        </div>
    </form>
</main>




<%@include file="footer.jsp"%>

<script>
   $(document).ready(function () {
    buscarLibrosReservado();
});
function buscarLibrosReservado() {
    $.ajax({
        data: { listar: 'buscarLibrosreservado' },
        url: 'jsp/cosulta_reserva.jsp',
        type: 'post',
        success: function(data) {
            const $temp = $('<div>').html(data);
            const htmlResponse = $temp.find('#idreserva').html();
            console.log('Contenido de #idreserva:', htmlResponse);

            if (htmlResponse) {
                $("#idreserva").html(htmlResponse);

                // Asegúrate de que se seleccione el primer valor
                $('#idreserva').val($('#idreserva option:first').val()).change();  // Establece el primer valor y dispara el evento change

                const idPersonaSeleccionada = $('#idreserva').val();
                console.log('idPersonaSeleccionada:', idPersonaSeleccionada); 

                if (idPersonaSeleccionada) {
                    mostrarLibrosReservados(idPersonaSeleccionada);
                } else {
                    console.log('No se ha seleccionado una persona.');
                }
            } else {
                console.error('No se encontró el elemento #idreserva en los datos recibidos.');
            }
        },
        error: function(xhr, status, error) {
            console.error("Error al cargar la consulta de reservas: " + error);
        }
    });
}
$('#idreserva').change(function() {
    var idReservaSeleccionada = $(this).val();  // Este es el valor del select
    console.log('ID Reserva Seleccionada:', idReservaSeleccionada);

    if (idReservaSeleccionada) {
        var selectedOption = $('#idreserva option:selected');
        
        // Obtener los datos de la reserva: libro y cantidad
        var tituloLibro = selectedOption.data('titulo_libro');
        var cantidadReserva = selectedOption.data('cantidad_reserva');
        
        console.log('Título del Libro:', tituloLibro);
        console.log('Cantidad de Reserva:', cantidadReserva);

        // Aquí puedes hacer lo que necesites con el título del libro y la cantidad
        mostrarReserva(tituloLibro, cantidadReserva);
    } else {
        console.log('No se ha seleccionado una reserva.');
    }
});

function mostrarReserva(tituloLibro, cantidadReserva) {
    // Aquí puedes actualizar el formulario o la vista con la información de la reserva
    $("#cantidad_reserva").val(cantidadReserva); // Actualiza la cantidad
    console.log("Reserva seleccionada:", tituloLibro, cantidadReserva);

    // Ahora actualizamos la tabla de libros reservados con la nueva reserva
    var newRow = `<tr>
                    <td>${tituloLibro}</td>
                    <td>${cantidadReserva}</td>
                  </tr>`;
    $('#tabla-libros-reservados tbody').html(newRow);  // Actualiza la tabla con la nueva fila
}








    $("#agregar-detalle").click(function () {
        $("#form-prestamo");
      datosForm = $("#form-prestamo").serialize();
      
      //alert(datosForm);
        $.ajax({
            data: datosForm,
            url: 'jsp/prestamo.jsp',
            type: 'post',
             beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                $("#respuesta").html(response);
               // alert('response');
                cargarDetalle();
            }
        });
    });

    function cargarDetalle() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/prestamo.jsp',
            type: 'post',
             beforeSend: function () {
               // $("#tabla").html("Procesando, espere por favor...");
                //alert(a);
            },
            success: function (response) {
                $("#tabla tbody").html(response);
                
            }
        });
    }

 $("#delreserva").click(function () {
        pkd = $("#pkdel").val();
      //  alert(pkd);
        $.ajax({
            data: {listar: 'eliminarprestamo', pkd: pkd},
            url: 'jsp/prestamo.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                console.log(response);
                
                cargarDetalle();


            }
        });
    });

    $("#cancelar-prestamo").click(function () {
        $.ajax({
            data: {listar: 'cancelarprestamo'},
            url: 'jsp/prestamo.jsp',
            type: 'post',
            success: function () {
                location.href = 'listadoprestamo.jsp';
            }
        });
    });

   $("#registrar-prestamo").click(function () {
        datosForm = $("#form-prestamo").serialize();
        idlibro = $("#idlibro").val();
    $.ajax({
        data: { listar: 'registrarprestamo', idlibro : idlibro },
        url: 'jsp/prestamo.jsp',
        type: 'post',
        success: function (response) {
            
            // Puedes agregar aquí la lógica que quieras si la llamada es exitosa
            // Por ejemplo, redirigir a otra página
            location.href = 'listadoprestamo.jsp';
            
        }
    });
});

function dividirPersona(idReserva) {
    // Seleccionar el option con el id de reserva
    const selectedOption = $('#idreserva option[value="' + idReserva + '"]');
    
    // Obtener los atributos data
    const ciPersona = selectedOption.attr('data-ci');
    const tituloLibro = selectedOption.attr('data-titulo_libro');
    const fechafinreserva = selectedOption.attr('data-fechafinreserva');
    const cantidad_reserva = selectedOption.attr('data-cantidad_reserva');
    const idlibro = selectedOption.attr('data-idlibro');
    const idpersona = selectedOption.attr('data-idpersona');
    
    // Asignar los valores a los campos
    $("#idlibro").val(idlibro);
    $("#ci_persona").val(ciPersona);
    $("#titulo_libro").val(tituloLibro);  // Agregar el título del libro al campo
    $("#fechafinreserva").val(fechafinreserva);
    $("#idreserva").val(idReserva);
    $("#cantidad_reserva").val(cantidad_reserva);
    $("#idpersona").val(idpersona);

    // Mostrar los libros reservados para esta persona
    cargarLibrosReservados(idReserva);
}

// Función para mostrar los libros reservados (usando los datos obtenidos)
function cargarLibrosReservados(idreserva) {
    $.ajax({
        data: { idreserva: idreserva, listar: 'librosReservados' },
        url: 'jsp/cargar_libros_reservados.jsp', // Página que procesa la solicitud en el servidor
        type: 'post',
        success: function(data) {
            const tbody = $('#tabla-libros-reservados tbody');
            tbody.empty();  // Limpiar la tabla antes de agregar los nuevos libros

            // Asegúrate de que los datos devueltos son válidos
            if (data) {
                tbody.append(data);  // Insertar la tabla HTML devuelta por el servidor
            } else {
                console.error('No se recibieron datos de libros reservados');
            }
        },
        error: function(xhr, status, error) {
            console.error("Error al cargar los libros reservados: " + error);
        }
    });
}







    
    
</script>
<script>
  const fechaActual = new Date().toISOString().split('T')[0];
  document.getElementById('fechadevolucion').setAttribute('min', fechaActual);
</script>