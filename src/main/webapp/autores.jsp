<%@include file="header.jsp"%>
<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3">
        <input type="hidden" name="listar" id="listar" value="cargar">
        <input type="hidden" name="idautor" id="idautor">
        <div class="container ">
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Formulario de los autores</h2>
                            <!-- Vertical Form -->
                            <div class="row">
                                <div class="col-6 mx-auto ">
                                    <label for="nombre_autor" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" id="nombre_autor" name="nombre_autor" placeholder="Ingrese el nombre">
                                   
                                </div>
                                <div class="col-6 mx-auto ">
                                    <label for="apellido_autor" class="form-label">Apellido</label>
                                    <input type="text" class="form-control" id="apellido_autor" name="apellido_autor" placeholder="Ingrese el apellido">
                                   
                                </div>
                            </div>
                            <div class="col-6 mx-auto ">
                                    <label for="codigo_autor" class="form-label">Codigo del autor</label>
                                    <input type="text" class="form-control" id="codigo_autor" name="codigo_autor" placeholder="Ingrese el codigo para indentificar al autor">
                                   
                                </div>
                            <br>
                                <div class="text-center">
                                    <button type="button" class="btn btn-primary" id="boton" name="boton">Cargar</button>
                                <a class="btn btn-secondary" target="_blank" href="reportautores.jsp">Imprimir</a>
                                </div>
                           
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Tabla de los autores</h2>
                            <div class="col-6  ">
                            <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                            <!-- Default Table --></div>
                            <table class="table" id="resultado">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Apellido</th>
                                        <th scope="col">codigo</th>
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
                        <input type="hidden" name="listar_Eliminar" id="listar_Eliminar">
                        <input type="hidden" name="idautort" id="idautort">
                        <p>¿Está seguro de querer eliminar los datos del autor?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="eliminarregistro">Sí</button>
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
            data: { listar: 'listar' },
            url: 'jsp/autor.jsp',
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
        var nombreAutor = $("#nombre_autor").val().trim();
        var apellidoAutor = $("#apellido_autor").val().trim();
        var codigoAutor = $("#codigo_autor").val().trim();

        if (nombreAutor === "") {
            $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el nombre del autor.</div>");
        } else if (!/^[a-zA-Z]+$/.test(nombreAutor)) {
            $("#mensaje").html("<div class='alert alert-danger' role='alert'>El nombre del autor solo puede contener letras.</div>");
        } else if (apellidoAutor === "") {
            $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el apellido del autor.</div>");
        } else if (!/^[a-zA-Z]+$/.test(apellidoAutor)) {
            $("#mensaje").html("<div class='alert alert-danger' role='alert'>El apellido del autor solo puede contener letras.</div>");
        }else if (codigoAutor === "") {
            $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el coidgo del autor.</div>");
        } else {
            let datosform = $("#form").serialize();
            $.ajax({
                data: datosform,
                url: 'jsp/autor.jsp',
                type: 'post',
                success: function (response) {
                    $("#mensaje").html(response);
                    rellenardatos();
                    setTimeout(function () {
                        $("#mensaje").html("");
                        $("#nombre_autor").val("");
                        $("#apellido_autor").val("");
                        $("#codigo_autor").val("");
                        $("#listar").val("cargar");
                        $("#nombre_autor").focus();
                    }, 2000);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    });
});



    function rellenaredit(id, nombre, apellido, codigo) {
        $("#idautor").val(id);
        $("#nombre_autor").val(nombre);
        $("#apellido_autor").val(apellido);
        $("#codigo_autor").val(codigo);
        $("#listar").val("modificar");
    }

    $('#eliminarregistro').on("click", function () {
        var listar = $("#listar_Eliminar").val();
        var pk = $("#idautor").val();
        $.ajax({
            data: { listar: "eliminar", idpk: pk },
            url: 'jsp/autor.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                rellenardatos();
                setTimeout(function () {
                    $("#mensaje").html("");
                    $("#nombre_autor").val("");
                    $("#apellido_autor").val("");
                    $("#codigo_autor").val("");
                    $("#listar").val("cargar");
                    $("#nombre_autor").focus();
                }, 2000);
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
</script>
