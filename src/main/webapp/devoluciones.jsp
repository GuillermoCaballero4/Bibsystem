<%-- 
    Document   : devoluciones
    Created on : 6 ago. 2024, 20:20:37
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
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3">
        <input type="hidden" name="listar" id="listar" value="cargar">
        <input type="hidden" name="idlibro" id="idlibro" class="form-control">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h2 class="card-title text-primary text-center mb-4">Datos de la Devolución</h2>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <label for="idreserva" class="form-label">Persona</label>
                                    <select class="select2 form-control" name="idreserva" id="idreserva" onchange="dividirpersona(this.value)">
                                        <!-- Opciones cargadas dinámicamente -->
                                    </select>
                                </div>

                                <div class="col-6">
                                    <label for="ci_persona" class="form-label">CI</label>
                                    <input type="number" class="form-control" id="ci_persona" name="ci_persona" readonly placeholder="CI">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <label for="idusuario" class="form-label">Usuario</label>
                                      <input type="hidden" id="idusuario" name="idusuario" value="<% out.print(sesion.getAttribute("idusuario")); %>" readonly>
                                    <input type="text" class="form-control" value="<% out.print(sesion.getAttribute("user"));%>" readonly>
                                </div>

                                <div class="col-6">
                                    <label for="fechafinreserva" class="form-label">Fecha de Devolución Esperada</label>
                                    <input type="date" class="form-control" id="fechadevolucion" name="fechadevolucion" readonly>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <label for="fechareserva" class="form-label">Fecha de Devolución Real</label>
                                    <input type="text" class="form-control" id="fechareserva" name="fecha_de_la_dev" value="<%= fechaFormateada %>" readonly>
                                </div>

                                <div class="col-6">
                                    <label for="cantidad" class="form-label">Cantidad Devuelta</label>
                                    <input type="number" class="form-control" id="cantidad" name="cantidad_dev" placeholder="Ingrese la cantidad devuelta">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <input type="hidden" class="form-control" id="motivo_multa" name="motivo_multa" placeholder="Escriba el motivo de la multa">
                                </div>

                                <div class="col-6">
                                    <input type="hidden" class="form-control" id="monto_multa" name="monto_multa" placeholder="Monto de la multa" value="0">
                                </div>
                            </div>

                            <input type="hidden" id="idprestamo" name="idprestamo">

                            <!-- Tabla para mostrar los libros agregados -->
                            <div class="container my-4">
                                <div class="card shadow-sm">
                                    <div class="card-body">
                                        <h2 class="card-title text-primary text-center mb-4">Libros Prestados</h2>
                                        <table class="table table-bordered table-hover" id="tabla">
                                            <thead class="table-primary">
                                                <tr>
                                                    <th>Libro</th>
                                                    <th>Cantidad</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-primary" id="botonagregar">Agregar</button>
                                <div id="respuesta" class="mt-3"></div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h2 class="card-title text-primary text-center mb-4">Registro de la Devolución</h2>

                            <table class="table table-bordered table-hover" id="resultados">
                                <thead class="table-primary">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Libro</th>
                                        <th scope="col">Cantidad Devuelta</th>
                                        <th scope="col">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>

                            <!-- Total de multas -->
                            <div class="row mt-3">
                                <div class="col text-right">
                                    <strong>Total Multa: </strong>
                                    <span id="total_multa">0</span>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-danger me-2" id="cancelardev">Cancelar</button>
                                <button type="button" class="btn btn-success" id="finaldev">Registrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

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
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="deldevolucion">Sí</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Multa -->
    <div class="modal fade" id="modalMulta" tabindex="-1" role="dialog" aria-labelledby="modalMultaLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalMultaLabel">Motivo y Monto de la Multa</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="motivo_multa_modal" class="form-label">Motivo de la Multa</label>
                        <input type="text" class="form-control" id="motivo_multa_modal" name="motivo_multa_modal" placeholder="Escriba el motivo de la multa">
                    </div>
                    <div class="form-group">
                        <label for="monto_multa_modal" class="form-label">Monto de la Multa</label>
                        <input type="number" class="form-control" id="monto_multa_modal" name="monto_multa_modal" value="0" placeholder="Monto de la multa">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="agregarMulta" data-dismiss="modal">Agregar Multa</button>
                </div>
            </div>
        </div>
    </div>
</main>


<%@include file="footer.jsp"%>
<script>
    $(document).ready(function () {
        buscarpersona();


    });
    function buscarpersona() {
        $.ajax({
            data: {listar: 'buscarpersona'},
            url: 'jsp/consulta_personadevolucion.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                $("#idreserva").html(response);
                // alert(response);

            }
        });
    }



    /* function buscarusuario() {
     $.ajax({
     data: {listar: 'buscarusuario'},
     url: 'jsp/consulta_usuario.jsp',
     type: 'post',
     beforeSend: function () {
     //$("#resultado").html("Procesando, espere por favor...");
     },
     success: function (response) {
     $("#idusuario").html(response);
     }
     });
     } */

    /*function dividirproveedor(a) {
     //alert(a)
     datos = a.split(',');
     //alert(datos[0]);
     // alert(datos[1]);
     $("#codproveedor").val(datos[0]);
     $("#ruc").val(datos[1]);
     }
     */
    /*
     function dividirproducto(a) {
     //alert(a)
     datos = a.split(',');
     //alert(datos[0]);
     // alert(datos[1]);
     $("#codproducto").val(datos[0]);
     $("#precio").val(datos[1]);
     }
     */
    $("#botonagregar").click(function () {

        datosform = $("#form").serialize();
       // alert(datosform);
        $.ajax({
            data: datosform,
            url: 'jsp/devolucion.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
              //  $("#respuesta").html(response);
                cargardetalle();
            }
        });
    });

    function cargardetalle() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/devolucion.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {

                $("#resultados tbody").html(response);
            }
        });
    }
    $("#deldevolucion").click(function () {
        pkd = $("#pkdel").val();
        $.ajax({
            data: {listar: 'elimredev', pkd: pkd},
            url: 'jsp/devolucion.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                // console.log(response);
                cargardetalle();


            }
        });
    });

    $("#cancelardev").click(function () {
        $.ajax({
            data: {listar: 'cancelardev'},
            url: 'jsp/devolucion.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                location.href = 'listadodevoluciones.jsp';

            }
        });
    });
    $("#finaldev").click(function () {
        motivo_multa = document.getElementById('motivo_multa').value;
        monto_multa = document.getElementById('monto_multa').value;
        $.ajax({
            data: {listar: 'finaldev',
            monto_multa: monto_multa,
            motivo_multa: motivo_multa},
            url: 'jsp/devolucion.jsp',
            type: 'post',
            beforeSend: function (resultado) {
             
        //alert(resultado);
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                // console.log(response);
                // alert(response);
                location.href = 'listadodevoluciones.jsp';

            }
        });
    });

    /*    $("#finaldev").click(function () {
     
     $.ajax({
     data: {listar: 'finaldevprestamo'},
     url: 'jsp/devolucion.jsp',
     type: 'post',
     beforeSend: function () {
     //$("#resultado").html("Procesando, espere por favor...");
     },
     success: function (response) {
     //console.log(response);
     alert(response);
     
     }
     });
     });
     */
    function dividirpersona(idreserva) {
        // Seleccionar el option con el id de reserva
        const selectedOption = $('#idreserva option[value="' + idreserva + '"]');

        // Obtener los atributos data
        const ciPersona = selectedOption.attr('data-ci');
        const tituloLibro = selectedOption.attr('data-titulo_libro');
        const fechadevolucion = selectedOption.attr('data-fechadevolucion');
        const cantidad = selectedOption.attr('data-cantidad');
        const idlibro = selectedOption.attr('data-idlibro');
        const idprestamo = selectedOption.attr('data-idprestamo');
        const idpersona = selectedOption.attr('data-idpersona');
        // Asignar los valores a los campos
        $("#idlibro").val(idlibro);
        $("#ci_persona").val(ciPersona);
        $("#titulo_libro").val(tituloLibro);
        $("#fechadevolucion").val(fechadevolucion);
        $("#idprestamo").val(idprestamo);
        $("#idreserva").val(idreserva);
        $("#cantidad").val(cantidad);
        $("#idpersona").val(idpersona);

        cargarLibrosReservados(idreserva);
    }
    function cargarLibrosReservados(idreserva) {
        $.ajax({
            data: {idreserva: idreserva, listar: 'librosReservados'},
            url: 'jsp/cargar_libros_reservados.jsp', // Página que procesa la solicitud en el servidor
            type: 'post',
            success: function (data) {
                const tbody = $('#tabla tbody');
                tbody.empty();  // Limpiar la tabla antes de agregar los nuevos libros

                // Asegúrate de que los datos devueltos son válidos
                if (data) {
                    tbody.append(data);  // Insertar la tabla HTML devuelta por el servidor
                } else {
                    console.error('No se recibieron datos de libros reservados');
                }
            },
            error: function (xhr, status, error) {
                console.error("Error al cargar los libros reservados: " + error);
            }
        });
    }

    document.getElementById('agregarMulta').addEventListener('click', function () {
        const motivo = document.getElementById('motivo_multa_modal').value;
        const monto = parseFloat(document.getElementById('monto_multa_modal').value);

        if (motivo && monto >= 0) {
            // Obtener los valores actuales de los campos ocultos
            let motivoActual = document.getElementById('motivo_multa').value;
            let montoActual = parseFloat(document.getElementById('monto_multa').value) || 0;

            // Acumular motivos

            //motivoActual = motivoActual ? `${motivoActual}, ${motivo}` : motivo;
            motivoActual += motivo;
            // Sumar montos
            montoActual += monto;

            // Actualizar los valores en los inputs ocultos
            document.getElementById('motivo_multa').value = motivoActual;
            document.getElementById('monto_multa').value = montoActual;

            // Sumar al total de la multa
            let total = parseFloat(document.getElementById('total_multa').textContent) || 0;
            total += monto;

            // Actualizar el total en la página
            document.getElementById('total_multa').textContent = total.toFixed(2);

            // Limpiar los campos del modal
            document.getElementById('motivo_multa_modal').value = '';  // Limpiar motivo
            document.getElementById('monto_multa_modal').value = '';   // Limpiar monto

            // Cerrar el modal
            $('#modalMulta').modal('hide');
        } else {
            alert('Por favor, ingrese un motivo y monto válidos');
        }
    });



</script>