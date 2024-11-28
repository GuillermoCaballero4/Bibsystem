<%@include file="header.jsp"%>
<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3">
        <input type="hidden" name="listar" id="listar" value="cargar">
        <input type="hidden" name="idusuario" id="idusuario">
        <div class="container ">
            <div class="row ">
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Formulario de los usuarios</h2>
                            <div class="row">
                                <div class="col-6">
                                    <label for="nombre_usu" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" id="nombre_usu" name="nombre_usu" placeholder="Ingrese el nombre de usuario">

                                </div>
                                <div class="col-6">
                                    <label for="clave_usu" class="form-label">Clave</label>
                                    <input type="password" class="form-control" id="clave_usu" name="clave_usu" placeholder="Ingrese la clave de usuario">

                                </div>
                            </div>

                            <div class="col-6 mx-auto ">
                                <label for="idpersonal" class="form-label">Personal</label>
                                <select class="select2 form-control" id="idpersonal" name="idpersonal"></select>

                            </div>
                            <br>
                            <div class="text-center">
                                <button type="button" class="btn btn-primary" id="boton" name="boton">Cargar</button>
                           <a class="btn btn-secondary" target="_blank" href="reportusuario.jsp">Imprimir</a>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <h2 class="card-title text-center">Tabla de los usuarios</h2>
                    <div class="col-6">
                         <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                    </div>
                    <table class="table" id="resultado">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Clave</th>
                                <th scope="col">Personal</th>
                                <th scope="col">Opciones</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
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
                        <input type="hidden" name="idpersonat" id="idpersonat">
                        <p>¿Está seguro de querer eliminar los datos de los usuarios?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="eliminarregistro">Sí</button>
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
        seleccionarpersonal();
    });

    function rellenardatos() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/usuario.jsp',
            type: 'post',
            success: function (response) {
                $("#resultado tbody").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function seleccionarpersonal() {
        $.ajax({
            url: 'jsp/consulta_personal.jsp',
            type: 'post',
            success: function (response) {
                console.log("Respuesta de consulta_personal.jsp: ", response);
                $("#idpersonal").html(response);
            },
            error: function (error) {
                console.log("Error en seleccionarpersonal: ", error);
            }
        });
    }

    $(document).ready(function () {
        $("#boton").on("click", function () {
            let nombreusu = $("#nombre_usu").val().trim();
            let claveusu = $("#clave_usu").val().trim();

            if (nombreusu === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el nombre de usuario.</div>");
            } else if (!/^[a-zA-Z]+$/.test(nombreusu)) {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>El nombre de usuario solo puede contener letras.</div>");
            } else if (claveusu === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese la clave de usuario.</div>");
            } else if ($("#idpersonal").val() === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, seleccione un personal.</div>");
            } else {
                let datosform = $("#form").serialize();
                $.ajax({
                    data: datosform,
                    url: 'jsp/usuario.jsp',
                    type: 'post',
                    success: function (response) {
                        $("#mensaje").html(response);
                        rellenardatos();
                        setTimeout(function () {
                            $("#mensaje").html("");
                            $("#nombre_usu").val("");
                            $("#clave_usu").val("");
                            $("#idpersonal").val("");
                            $("#listar").val("cargar");
                            $("#nombre_usu").focus();
                        }, 2000);
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }
        });
    });

    function rellenaredit(id, nombre, clave, idpersonal) {
        $("#idusuario").val(id);
        $("#nombre_usu").val(nombre);
        $("#clave_usu").val(clave);
        $("#idpersonal").val(idpersonal).trigger('change');
        $("#listar").val("modificar");
    }

    $('#eliminarregistro').on("click", function () {
        let listar = $("#listar_Eliminar").val();
        let pk = $("#idusuario").val();
        $.ajax({
            data: {listar: "eliminar", idpk: pk},
            url: 'jsp/usuario.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                rellenardatos();
                setTimeout(function () {
                    $("#mensaje").html("");
                    $("#nombre_usu").val("");
                    $("#clave_usu").val("");
                    $("#idpersonal").val("");
                    $("#listar").val("cargar");
                    $("#nombre_usu").focus();
                }, 2000);
            },
            error: function (error) {
                console.log(error);
            }
        });
    });

</script>
