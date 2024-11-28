
<%@include file="header.jsp"%> 
<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3">
        <input type="hidden" name="listar" id="listar"  value="cargar">
        <input type="hidden" name="idpersona" id="idpersona"  >
        <div class="container ">
            <div class="row ">
                <div class="col" >

                    <div class="card">
                        <div class="card-body">


                            <h2 class="card-title text-center">Formulario de las personas</h2>

                            <!-- Vertical Form -->
 <div class="row">
                            <div class="col-6">
                                <label for="nombre_persona" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre_persona" name="nombre_persona" placeholder="Ingrese el nombre">
                            </div>
                            <div class="col-6">
                                <label for="apellido_persona" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido_persona" name="apellido_persona" placeholder="Ingrese el apellido">
                            </div>
 </div>
 <div class="row">                           
                            <div class="col-6">
                                <label for="ci_persona" class="form-label">Ci</label>
                                <input type="number" class="form-control" id="ci_persona" name="ci_persona" placeholder="Ingrese el numero de cedula">
                            </div>
                            <div class="col-6">
                                <label for="telefono_persona" class="form-label">Telefono</label>
                                <input type="number" class="form-control" id="telefono_persona" name="telefono_persona" placeholder="Ingrese el numero de telefono">
                            </div>
 </div>
                            <br>
                            <div class="text-center">
                                <button type="button" class="btn btn-primary" id="boton" name="boton">Cargar</button>
<a class="btn btn-secondary" target="_blank" href="reportpersona.jsp">Imprimir</a>
                            </div>


                        </div>
                    </div>  
                </div>
                
            </div>
        </div>
        <div class="col">
                    <div class="card">
                        <div class="card-body">

                            <h2 class="card-title text-center">Tabla de personas</h2>
                            <div class="col-6">
                                
                            <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                            <!-- Default Table -->
                            </div>
                            <table class="table" id="resultado">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Apellido</th>
                                        <th scope="col">Ci</th>
                                        <th scope="col">Telefono</th>
                                        <th scope="col">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                            <!-- End Default Table Example -->
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
                        <input type="hidden" name="listar_Eliminar" id="listar_Eliminar"  >
                        <input type="hidden" name="idpersonat" id="idpersonat"  >
                        <p>¿Esta seguro de querer elminar los datos de la persona?<p/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="eliminarregistro">Si</button>
                    </div>
                </div>
            </div>
        </div><!-- End Basic Modal-->
    </form>

</main><!-- End #main -->
<%@include file="footer.jsp"%>
<script>
    $(document).ready(function () {
        rellenardatos();

    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/persona.jsp',
            type: 'post',

            success: function (response) {
                $("#resultado tbody").html(response);

            }
        });
    }
    $(document).ready(function () {
        $("#boton").on("click", function () {
            var nombrePersona = $("#nombre_persona").val().trim();
            var apellidoPersona = $("#apellido_persona").val().trim();
            var ciPersona = $("#ci_persona").val().trim();
            var telefonoPersona = $("#telefono_persona").val().trim();

            if (nombrePersona === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el nombre.</div>");
            } else if (!/^[a-zA-Z]+$/.test(nombrePersona)) {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>El nombre solo puede contener letras.</div>");
            } else if (apellidoPersona === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el apellido.</div>");
            } else if (!/^[a-zA-Z]+$/.test(apellidoPersona)) {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>El apellido solo puede contener letras.</div>");
            } else if (ciPersona === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el número de cédula.</div>");
            } else if (telefonoPersona === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el número de teléfono.</div>");
            } else {
                var datosform = $("#form").serialize();
                $.ajax({
                    data: datosform,
                    url: 'jsp/persona.jsp',
                    type: 'post',
                    success: function (response) {
                        $("#mensaje").html(response);
                        rellenardatos();
                        setTimeout(function () {
                            $("#mensaje").html("");
                            $("#nombre_persona").val("");
                            $("#apellido_persona").val("");
                            $("#ci_persona").val("");
                            $("#telefono_persona").val("");
                            $("#listar").val("cargar");
                            $("#nombre_persona").focus();
                        }, 2000);
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }
        });
    });



    function rellenaredit(a, b, c, d, e) {

        $("#idpersona").val(a);
        $("#nombre_persona").val(b);
        $("#apellido_persona").val(c);
        $("#ci_persona").val(d);
        $("#telefono_persona").val(e);
        $("#listar").val("modificar");
    }

    $('#eliminarregistro').on("click", function () {
        listar = $("#listar_Eliminar").val();
        pk = $("#idpersona").val();
        $.ajax({
            data: {listar: "eliminar", idpk: pk},
            url: 'jsp/persona.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                rellenardatos();


                setTimeout(function () {
                    $("#mensaje").html("");
                    $("#nombre_persona").val("");
                    $("#apellido_persona").val("");
                    $("#ci_persona").val("");
                    $("#telefono_persona").val("");
                    $("#listar").val("cargar");
                    $("#nombre_persona").focus();
                }, 2000);
            }
        });
    });


</script>

