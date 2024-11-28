<%-- 
    Document   : metododepago
    Created on : 24 nov. 2024, 15:54:15
    Author     : david
--%>
<%@include file="header.jsp"%>
<main id="main" class="main">
    
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3">
    <input type="hidden" name="listar" id="listar" value="cargar">
    <input type="hidden" name="idmetododepago" id="idmetododepago">

    <div class="container ">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <!-- comment --> 
                        
                        <h1 class="card-title text-center" >Formulario de los metodo de pago</h1>
                       <div id="mensaje"></div>

                        <div class="col-6 mx-auto " >
                         <label for="descripcion" class="form-label">Descripcion del metodo</label>   
                            <input type="text" class="form-control" id="descripcion" name="descripcion" placeholder="Ingrese la descripcion del metodo de pago">
                        </div>
                        <br>
                        <div class="text-center">
                            <button type="button" class="btn btn-primary" id="boton" name="boton">Cargar</button>
                            <a class="btn btn-secondary" target="_blank" href="reportmetodo.jsp">Imprimir</a>
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
                        <h1 class="card-title text-center">Tabla de los metodo de pago</h1>
                        <div class="col-6">
                        <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                        </div>
                        <table class="table" id="resultado">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">descripcion de los metodo de pago</th>
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

    <div class="modal fade" id="basicModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="listar_Eliminar" id="listar_Eliminar">
                    <input type="hidden" name="idmetododepago" id="idmetododepago">
                    <p>¿Está seguro de querer eliminar el dato de el metodo de pago?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="eliminarregistro">Sí</button>
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
    });

    function rellenardatos() {
        $.ajax({
            data: { listar: 'listar' },
            url: 'jsp/metodo.jsp',
            type: 'post',
            success: function (response) {
                $("#resultado tbody").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    $(document).ready(function () {
    $("#boton").on("click", function () {
        var descripcion = $("#descripcion").val().trim();

        if (descripcion === "") {
            $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese los datos para la descripcion del metodo de pago.</div>");
        }  else {
            var datosform = $("#form").serialize();
            $.ajax({
                data: datosform,
                url: 'jsp/metodo.jsp',
                type: 'post',
                success: function (response) {
                    $("#mensaje").html(response);
                    rellenardatos();
                    setTimeout(function () {
                        $("#mensaje").html("");
                        $("#descripcion").val("");
                        $("#listar").val("cargar");
                        $("#descripcion").focus();
                    }, 2000);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    });
});





    function rellenaredit(idmetododepago, descripcion) {
        $("#idmetododepago").val(idmetododepago);
        $("#descripcion").val(descripcion);
        $("#listar").val("modificar");
    }

    $('#eliminarregistro').on("click", function () {
        var listar = $("#listar_Eliminar").val();
        var pk = $("#idmetododepago").val();
        $.ajax({
            data: { listar: "eliminar", idpk: pk },
            url: 'jsp/metodo.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                rellenardatos();
                setTimeout(function () {
                    $("#mensaje").html("");
                    $("#descripcion").val("");
                    $("#listar").val("cargar");
                    $("#idmetododepago").focus();
                }, 2000);
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
</script>

