
<%@include file="header.jsp"%> 
<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3"> 
        <input type="hidden" name="listar" id="listar"  value="cargar">
        <input type="hidden" name="idpersonal" id="idpersonal">
        <div class="container ">
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Formulario de los personales</h2>

                            <!-- Vertical Form -->
                            <div class="row">      
                                <div class="col-6">
                                    <label for="nombre_personal" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" id="nombre_personal" name="nombre_personal" placeholder="Ingrese el nombre">
                                </div>
                                <div class="col-6">
                                    <label for="apellido_personal" class="form-label">Apellido</label>
                                    <input type="text" class="form-control" id="apellido_personal" name="apellido_personal" placeholder="Ingrese el apellido">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <label for="ci_personal" class="form-label">Ci</label>
                                    <input type="number" class="form-control" id="ci_personal" name="ci_personal" placeholder="Ingrese el numero de cedula">
                                </div>
                                <div class="col-6">
                                    <label for="telefono_personal" class="form-label">Teléfono</label>
                                    <input type="number" class="form-control" id="telefono_personal" name="telefono_personal" placeholder="Ingrese el numero de telefono">
                                </div>
                                <div class="col-12">
                                    <br>
                                    <div class="text-center">
                                        <button type="button" class="btn btn-primary" id="boton" name="boton">Cargar</button>
                                   <a class="btn btn-secondary" target="_blank" href="resportepersonales.jsp">Imprimir</a>
                                    </div>
                                </div>
                            </div>  
                        </div>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card">
                    <div class="card-body text-center">
                        <h2 class="card-title text-center">Tabla de los personales</h2>
                        <div class="col-6">
                            <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                        </div>
                        <!-- Default Table -->
                        <table class="table" id="resultado">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Apellido</th>
                                    <th scope="col">Ci</th>
                                    <th scope="col">Teléfono</th>
                                    <th scope="col">Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Aquí van los datos de la tabla -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="basicModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="listar_Eliminar" id="listar_Eliminar">
                            <input type="hidden" name="idpersonat" id="idpersonat">
                            <p>¿Está seguro de querer eliminar los datos de los personales?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="eliminarregistro">Sí</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</main>

                <%@include file="footer.jsp"%>
                <script>
                    $(document).ready(function () {
                        rellenardatos();

                    });

                    function rellenardatos() {
                        $.ajax({
                            data: {listar: 'listar'},
                            url: 'jsp/personal.jsp',
                            type: 'post',

                            success: function (response) {
                                $("#resultado tbody").html(response);

                            }, error: function (error) {
                                console.log(error);
                            }
                        });
                    }
                    $(document).ready(function () {
                        $("#boton").on("click", function () {
                            var nombrePersonal = $("#nombre_personal").val().trim();
                            var apellidoPersonal = $("#apellido_personal").val().trim();
                            var ciPersonal = $("#ci_personal").val().trim();
                            var telefonoPersonal = $("#telefono_personal").val().trim();

                            if (nombrePersonal === "") {
                                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el nombre</div>");
                            } else if (!/^[a-zA-Z]+$/.test(nombrePersonal)) {
                                $("#mensaje").html("<div class='alert alert-danger' role='alert'>El nombre solo puede contener letras.</div>");
                            } else if (apellidoPersonal === "") {
                                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el apellido.</div>");
                            } else if (!/^[a-zA-Z]+$/.test(apellidoPersonal)) {
                                $("#mensaje").html("<div class='alert alert-danger' role='alert'>El apellido solo puede contener letras.</div>");
                            } else if (ciPersonal === "") {
                                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el número de cédula.</div>");
                            } else if (telefonoPersonal === "") {
                                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el número de teléfono.</div>");
                            } else {
                                let datosform = $("#form").serialize();
                                $.ajax({
                                    data: datosform,
                                    url: 'jsp/personal.jsp',
                                    type: 'post',
                                    success: function (response) {
                                        $("#mensaje").html(response);
                                        rellenardatos();
                                        setTimeout(function () {
                                            $("#mensaje").html("");
                                            $("#nombre_personal").val("");
                                            $("#apellido_personal").val("");
                                            $("#ci_personal").val("");
                                            $("#telefono_personal").val("");
                                            $("#listar").val("cargar");
                                            $("#nombre_personal").focus();
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

                        $("#idpersonal").val(a);
                        $("#nombre_personal").val(b);
                        $("#apellido_personal").val(c);
                        $("#ci_personal").val(d);
                        $("#telefono_personal").val(e);
                        $("#listar").val("modificar");
                    }
                    $('#eliminarregistro').on("click", function () {
                        listar = $("#listar_Eliminar").val();
                        pk = $("#idpersonal").val();
                        $.ajax({
                            data: {listar: "eliminar", idpk: pk},
                            url: 'jsp/personal.jsp',
                            type: 'post',
                            success: function (response) {
                                $("#mensaje").html(response);
                                rellenardatos();


                                setTimeout(function () {
                                    $("#mensaje").html("");
                                    $("#nombre_personal").val("");
                                    $("#apellido_personal").val("");
                                    $("#ci_personal").val("");
                                    $("#telefono_personal").val("");
                                    $("#listar").val("cargar");
                                    $("#nombre_personal").focus();
                                }, 2000);
                            }
                        });
                    });
                </script>

