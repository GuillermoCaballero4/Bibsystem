<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Obtener la fecha actual
    Date fechaActual = new Date();

    // Crear un formateador de fecha
    SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");
    String fechaFormateada = formateadorFecha.format(fechaActual);

    SimpleDateFormat formateadorFechaww = new SimpleDateFormat("yyyy-MM-dd");
    String fechaFormateadaww = formateadorFechaww.format(fechaActual);
%>
<%@ include file="header.jsp" %>

<main id="main" class="main">
    <div class="container">
        <h1 class="text-center my-4">Reservas</h1>
        <div class="card shadow-sm p-4">
            <form action="reportreserva.jsp" method="post" target="_blank">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="idfechaa" class="form-label">Fecha Inicio:</label>
                        <input type="date" class="form-control" name="idfechaa" id="idfechaa" value="<%= fechaFormateadaww %>">
                    </div>
                    <div class="col-md-6">
                        <label for="idfechab" class="form-label">Fecha Fin:</label>
                        <input type="date" class="form-control" name="idfechab" id="idfechab" value="<%= fechaFormateadaww %>">
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="e" class="form-label">Estado</label>
                        <select class="form-select select2" name="e" id="e">
                            <option value="Todos">Todos</option>
                            <option value="Finalizado">Finalizado</option>
                            <option value="Anulado">Anulado</option>
                            <option value="Cancelado">Cancelado</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="nombre_usu" class="form-label">Usuario</label>
                        <select class="form-select select2" name="nombre_usu" id="nombre_usu">
                            <!-- Datos cargados dinámicamente -->
                        </select>
                    </div>
                </div>
                <div class="d-flex justify-content-center">
                    <button type="submit" class="btn btn-secondary px-5">Imprimir Informe</button>
                </div>
            </form>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

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
