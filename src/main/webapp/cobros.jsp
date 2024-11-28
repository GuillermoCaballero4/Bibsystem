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
  // Crear un formateador para convertir a formato compatible con "date" (yyyy-MM-dd)
  

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
    <div id="mensaje"></div>
   
    <div class="col">
        <div class="card">
            <div class="card-body">
                <h2 class="card-title text-center">Tabla de los cobros</h2>
                    <input type="hidden" name="fecha_co" id="fecha_co" value="<%= fechaFormateada %>">
                
                   <!-- comment    
<div class="col-6">
    <label for="idfechaa">Fecha Inicio:</label>
    
    <input type="date" name="idfechaa" id="idfechaa" value="<%= fechaFormateadaww %>"/>
        
    
    <label for="idfechab">Fecha Fin:</label>
    <input type="date" name="idfechab" id="idfechab" value="<%= fechaFormateadaww %>"/>
       
    

    
</div>
    <button class="btn btn-secondary" id="imprimir-informe">Imprimir Informe</button> --> 

                    <div class="col-6">          
                    <input type="text" id="filtroInput" class="form-control" onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                </div>
                <table class="table" id="resultado">
                    <thead>
                        <tr>
                            
                            <th scope="col">Nombre Persona</th>
                            <th scope="col">Monto de la Multa</th>
                            <th scope="col">Motivo Multa</th>
                            <th scope="col">Fecha Cobro</th>
                            <th scope="col">Estado Cobro</th>
                            <th scope="col">Opciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Aquí se llenará con datos desde el servidor -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal para confirmar cobro -->
    <div class="modal fade" id="cobroModal" tabindex="-1" aria-labelledby="cobroModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cobroModalLabel">Confirmar Cobro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                
                <p id="mensajeCobro">¿Está seguro de que desea cobrar a este usuario?</p>
                <input type="hidden" id="idpersona" name="idpersona">
                <input type="hidden" id="iddevolucion" name="iddevolucion">
                <input type="hidden" name="idcobro_multa" id="idcobro_multa" >
                <!-- Campo de Método de Pago -->
                <label for="metodoPago" class="form-label">Método de Pago</label>
                <select class="form-select" id="metodoPago" name="idmetododepago">
                    <option value="" disabled selected>Seleccione un método de pago</option>
                    
                </select>

                <!-- Campo de Monto de la Multa -->
                <div class="mb-3">
                    <label for="monto_multa" class="form-label">Monto de la Multa</label>
                    <input type="number" class="form-control" id="monto_multa" name="monto_multa" value="60000" readonly>
                </div>

                <!-- Campo para ingresar el Monto Pagado -->
                <div class="mb-3">
                    <label for="montoPagado" class="form-label">Monto Pagado</label>
                    <input type="number" class="form-control" id="montoPagado" placeholder="Ingrese el monto pagado">
                </div>

                <!-- Campos adicionales ocultos al inicio -->
                <div id="campoReferencia" class="mb-3" style="display: none;">
                    <label for="numeroReferencia" class="form-label">Número de Referencia / Comprobante</label>
                    <input type="text" class="form-control" id="numeroReferencia" placeholder="Ingrese el número de referencia">
                </div>
                <div id="campoUltimosDigitos" class="mb-3" style="display: none;">
    <label for="ultimosDigitos" class="form-label">Últimos 4 Dígitos de la Tarjeta</label>
    <input type="number" class="form-control" id="ultimosDigitos" maxlength="4" placeholder="Ingrese los últimos 4 dígitos" min="0" max="9999">
</div>

                <div id="campoNombreBanco" class="mb-3" style="display: none;">
                    <label for="nombreBanco" class="form-label">Nombre del Banco</label>
<select class="form-select" id="nombreBanco">
    <option value="" disabled selected>Seleccione un banco</option>
    <option value="banco_nacional_de_fomento">Banco Nacional de Fomento</option>
    <option value="banco_basa">Banco Basa</option>
    <option value="banco_bbva">Banco BBVA</option>
    <option value="banco_continental">Banco Continental</option>
    <option value="banco_itau">Banco Itaú</option>
    <option value="banco_regional">Banco Regional</option>
    <option value="vision_banco">Visión Banco</option>
    <option value="banco_familiar">Banco Familiar</option>
</select>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="confirmarCobro">Cobrar</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modalanular" tabindex="-1" aria-labelledby="miModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        
        <input type="hidden" id="idanular" class="form-control" />
      </div>
      <div class="modal-body">
          
        <h5 class="modal-title" id="miModalLabel">¿Desea anular el cobro?</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="anularcobro">Confirmar</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="modalregenerar" tabindex="-1" aria-labelledby="miModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        
        <input type="hidden" id="idrecibo" class="form-control" />
      </div>
      <div class="modal-body">
          
        <h5 class="modal-title" id="miModalLabel">¿Desea regenerar el cobro?</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="regenerarcobro">Confirmar</button>
      </div>
    </div>
  </div>
</div>
    




</main>
<%@include file="footer.jsp"%>

<script>
    $(document).ready(function () {
        rellenardatos();
        rellenardatosmetododepago();
    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/consulta_cobro.jsp',
            type: 'post',
            success: function (response) {
                $("#resultado tbody").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
function rellenardatosmetododepago() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/consultametodo.jsp',
            type: 'post',
            success: function (response) {
                $("#metodoPago").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
  function abrirModalCobro(idpersona, nombre_persona, iddevolucion,monto_multa,idcobro_multa) {
      
    document.getElementById('mensajeCobro').innerText = "¿Está seguro de que desea cobrar a " + nombre_persona + "?";
    document.getElementById('idpersona').value = idpersona;  // Asegúrate de pasar el id de la persona aquí
    document.getElementById('iddevolucion').value = iddevolucion;
    document.getElementById('monto_multa').value = monto_multa;
    document.getElementById('idcobro_multa').value = idcobro_multa;
    // Asegúrate de pasar el id de la persona aquí
    // Abrir el modal manualmente usando Bootstrap 5
    var modal = new bootstrap.Modal(document.getElementById('cobroModal'), {
        keyboard: false
    });
    modal.show();
}
$(document).ready(function () {
    $("#confirmarCobro").on("click", function () {
        var idpersona = $("#idpersona").val().trim();
        var idDevolucion = $("#iddevolucion").val().trim(); // Asegúrate de que este ID sea correcto
        var montoMulta = parseFloat($("#monto_multa").val());
        var montoPagado = parseFloat($("#montoPagado").val());
        var fecha_co = $("#fecha_co").val();
        var metodoPago = $("#metodoPago").val();
        var idcobro_multa = $("#idcobro_multa").val();
        // Validar que los campos existan y tengan valores
        if (!idDevolucion) {
            console.error("El campo ID Devolución no existe o está vacío.");
            $("#mensajeCobro").html("<div class='alert alert-danger' role='alert'>ID Devolución no encontrado.</div>");
            return;
        }
 if (!metodoPago) {
            console.error("No se seleciono el metodo de pago.");
            $("#mensajeCobro").html("<div class='alert alert-danger' role='alert'>Porfavor ingrese un metodo de pago.</div>");
            return;
        }
        if (idpersona === "" || isNaN(montoPagado) || idDevolucion === "") {
            $("#mensajeCobro").html("<div class='alert alert-danger' role='alert'>Datos no válidos. Asegúrate de ingresar el monto pagado y ID Devolución.</div>");
        } else if (montoPagado < montoMulta) {
            $("#mensajeCobro").html("<div class='alert alert-danger' role='alert'>El monto pagado es insuficiente.</div>");
        } else {
            var vuelto = montoPagado - montoMulta;

            // Crear el objeto de datos a enviar
            var datosCobro = {
                idpersona: idpersona,
                iddevolucion: idDevolucion,
                monto_multa: montoMulta,
                fecha_co: fecha_co,
                metodoPago: metodoPago,
                idcobro_multa: idcobro_multa
                
            };

            $.ajax({
                data: $.param(datosCobro),
                url: 'jsp/cobrarMulta.jsp',
                type: 'post',
                success: function (response) {
                    console.log("Respuesta del servidor:", response);
                    $("#mensajeCobro").html("<div class='alert alert-success' role='alert'>Cobro realizado. Vuelto: " + vuelto + "</div>");
                    rellenardatos();
                   // alert(response);
                    setTimeout(function () {
                        $("#mensajeCobro").html("");
                        var modal = bootstrap.Modal.getInstance(document.getElementById('cobroModal'));
                        modal.hide();
                    }, 2000);
                },
                error: function (error) {
                    console.log("Error en la solicitud AJAX:", error);
                    $("#mensajeCobro").html("<div class='alert alert-danger' role='alert'>Error al realizar el cobro.</div>");
                }
            });
        }
    });
});





</script>
<script>
    document.getElementById('imprimir-informe').addEventListener('click', function() {
        var fechaInicio = document.getElementById('idfechaa').value;
        var fechaFin = document.getElementById('idfechab').value;
        var monto_multa = document.getElementById('monto_multa').value;
        // Verifica que las fechas no sean nulas
        if (!fechaInicio || !fechaFin) {
            alert("Por favor, selecciona ambas fechas.");
            return;
        }
        
        // Construir la URL para el informe
        var url = 'reportcobro.jsp?idfechaa=' + encodeURIComponent(fechaInicio) + '&idfechab=' + encodeURIComponent(fechaFin) ;
        
        // Abrir la URL en una nueva pestaña
        window.open(url, '_blank');
    });
</script>
<script>
$(document).ready(function () {
    document.getElementById('metodoPago').addEventListener('change', function () {
        const campoReferencia = document.getElementById('campoReferencia');
        const campoUltimosDigitos = document.getElementById('campoUltimosDigitos');
        const campoNombreBanco = document.getElementById('campoNombreBanco');

        // Ocultar todos los campos adicionales por defecto
        campoReferencia.style.display = 'none';
        campoUltimosDigitos.style.display = 'none';
        campoNombreBanco.style.display = 'none';

        // Mostrar los campos adecuados según el método de pago seleccionado
        switch (this.value) {
            case '21':
                campoReferencia.style.display = 'block';
                campoNombreBanco.style.display = 'block';
                break;
            case '22':
            case '23':
                campoReferencia.style.display = 'block';
                campoUltimosDigitos.style.display = 'block';
                break;
            default:
                // No hacer nada si no se selecciona un método de pago válido
                break;
        }
    });
});


</script>
<script>
    document.getElementById('ultimosDigitos').addEventListener('input', function (e) {
        // Limitar a 4 dígitos
        if (this.value.length > 4) {
            this.value = this.value.slice(0, 4);
        }
    });
    
    
    
    $("#regenerarcobro").click(function () {
        
        idrecibo = $("#idrecibo").val();
    $.ajax({
        data: { idrecibo : idrecibo },
        url: 'jsp/regenerarcobro.jsp',
        type: 'post',
        success: function (response) {
            
            // Puedes agregar aquí la lógica que quieras si la llamada es exitosa
            // Por ejemplo, redirigir a otra página
             rellenardatos();
        
            
        }
    });
});
$("#anularcobro").click(function () {
        
        idanular = $("#idanular").val();
    $.ajax({
        data: { idanular : idanular },
        url: 'jsp/anularcobro.jsp',
        type: 'post',
        success: function (response) {
            
            // Puedes agregar aquí la lógica que quieras si la llamada es exitosa
            // Por ejemplo, redirigir a otra página
            
               rellenardatos();
        rellenardatosmetododepago();
        }
    });
});
</script>

    
   





