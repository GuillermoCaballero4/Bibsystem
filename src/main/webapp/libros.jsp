<%@include file="header.jsp"%>
<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3">
        <input type="hidden" name="listar" id="listar" value="cargar">
        <input type="hidden" name="idlibro" id="idlibro">
        <div class="container ">
            <div class="row ">
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Formulario de los libros</h2>
                            <!-- Vertical Form -->
                           <div class="row">
                                <div class="col-6 mx-auto ">
                                    <label for="titulo_libro" class="form-label">Título</label>
                                    <input type="text" class="form-control" id="titulo_libro" name="titulo_libro" placeholder="Ingrese el título">
                                    <div class="invalid-feedback" id="tituloError">Por favor, ingrese el título.</div>
                                </div>
                                <div class="col-6 mx-auto ">
                                    <label for="idcategoria" class="form-label">Categoría</label>
                                    <select class="select2 form-control" id="idcategoria" name="idcategoria">
                                    </select>
                                    <div class="invalid-feedback" id="categoriaError">Por favor, seleccione una categoría.</div>
                                </div>
                           </div>
                            <div class="row">
                                <div class="col-6 mx-auto ">
                                    <label for="descripcion_libro" class="form-label">Descripción</label>
                                    <input type="text" class="form-control" id="descripcion_libro" name="descripcion_libro" placeholder="Ingrese la descripción">
                                    <div class="invalid-feedback" id="descripcionError">Por favor, ingrese la descripción.</div>
                                </div>
                                <div class="col-6 mx-auto ">
                                    <label for="idautor" class="form-label">Autor</label>
                                    <select class="select2 form-control" id="idautor" name="idautor">
                                    </select>
                                    <div class="invalid-feedback" id="autorError">Por favor, seleccione un autor.</div>
                                </div>
                            </div>
                            <div class="col-7 mx-auto ">
                                    <label for="isbn" class="form-label">Isbn</label>
                                   <input type="text" class="form-control" id="isbn" name="isbn" placeholder="Ingrese el isbn del libro">
                                    <div class="invalid-feedback" id="autorError">Por favor, seleccione un autor.</div>
                                </div>
                            <br>
                                <div class="text-center">
                                    <button type="button" class="btn btn-primary" id="boton" name="boton">Cargar</button>
                                <a class="btn btn-secondary" target="_blank" href="reportlibro.jsp">Imprimir</a>
                                </div>
                          
                        </div>
                    </div>
                </div>
               
            </div>
        </div>
         <div class="col">
                    <div class="card">
                        <div class="card-body ">
                            <h2 class="card-title text-center">Tabla de los libros</h2>
                            <div class="col-6  ">
                            <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                            <!-- Default Table -->
                            </div>
                            <table class="table" id="resultado">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Título</th>
                                        <th scope="col">Categoría</th>
                                        <th scope="col">Descripción</th>
                                        <th scope="col">Autor</th>
                                        <th scope="col">Isbn</th>
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
                        <input type="hidden" name="idlibro" id="idlibro">
                        <p>¿Está seguro de querer eliminar los datos del libro?</p>
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
        seleccionarcategorias();
        seleccionarautor();
    });

    function rellenardatos() {
        $.ajax({
            data: { listar: 'listar' },
            url: 'jsp/libro.jsp',
            type: 'post',
            success: function (response) {
                $("#resultado tbody").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function seleccionarautor() {
        $.ajax({
            url: 'jsp/consultar_autor.jsp',
            type: 'post',
            success: function (response) {
                $("#idautor").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function seleccionarcategorias() {
        $.ajax({
            url: 'jsp/consultar_categoria.jsp',
            type: 'post',
            success: function (response) {
                $("#idcategoria").html(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

   $(document).ready(function () {
    $("#boton").on("click", function () {
        var tituloLibro = $("#titulo_libro").val().trim();
            var descripcionLibro = $("#descripcion_libro").val().trim();
            var isbn = $("#isbn").val().trim();

            if (tituloLibro === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el título del libro.</div>");
            } else if ($("#idcategoria").val() === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, seleccione una categoría.</div>");
            } else if (descripcionLibro === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese la descripción del libro.</div>");
            } else if ($("#idautor").val() === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, seleccione un autor.</div>");
            } else if (isbn === "") {
                $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el isbn del libro.</div>");
            } else {
            let datosform = $("#form").serialize();
            $.ajax({
                data: datosform,
                url: 'jsp/libro.jsp',
                type: 'post',
                success: function (response) {
                    $("#mensaje").html(response);
                    rellenardatos();
                    setTimeout(function () {
                        $("#mensaje").html("");
                        $("#titulo_libro").val("");
                        $("#idcategoria").val("");
                        $("#descripcion_libro").val("");
                        $("#idautor").val("");
                        $("#listar").val("cargar");
                        $("#titulo_libro").focus();
                        $("#isbn").val("");
                    }, 2000);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    });
});


function rellenaredit(id, titulo, idcategoria, descripcion, idautor, isbn) {
    $("#idlibro").val(id);
    $("#titulo_libro").val(titulo);
    
    // Establece el valor seleccionado en el select
    $("#idcategoria").val(idcategoria).trigger('change');
    $("#descripcion_libro").val(descripcion);
    $("#idautor").val(idautor).trigger('change');
    $("#isbn").val(isbn);
    $("#listar").val("modificar");
}


    $('#eliminarregistro').on("click", function () {
        var listar = $("#listar_Eliminar").val();
        var pk = $("#idlibro").val();
        $.ajax({
            data: { listar: "eliminar", idpk: pk },
            url: 'jsp/libro.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                rellenardatos();
                setTimeout(function () {
                    $("#mensaje").html("");
                    $("#titulo_libro").val("");
                    $("#idcategoria").val("");
                    $("#descripcion_libro").val("");
                    $("#idautor").val("");
                    $("#isbn").val("");
                    $("#listar").val("cargar");
                    $("#titulo_libro").focus();
                }, 2000);
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
</script>
