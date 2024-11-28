<%-- 
    Document   : donaciones
    Created on : 6 ago. 2024, 18:53:33
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

        <div class="container text-center">
            <div class="row">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h2 class="card-title">Datos de la Donación</h2>
                            <div class="row">
                                <div class="col-6">
                                    <label for="idpersona" class="form-label">Persona</label>
                                    <select class="select2 form-control" name="idpersona" id="idpersona" onchange="dividirpersona(this.value)">
                                        <!-- Opciones de personas cargadas desde la base de datos -->
                                    </select>
                                </div>

                                <div class="col-6">
                                    <label for="ci_persona" class="form-label">CI</label>
                                    <input type="text" class="form-control" id="ci_persona" name="ci_persona" autocomplete="off" placeholder="CI" value="" readonly>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-6">
                                    <label for="fecha_donacion" class="form-label">Fecha de Donación</label>
                                    <input type="text" class="form-control" id="fecha_donacion" name="fecha_donacion" autocomplete="off" placeholder="Ingrese Fecha" value="<%= fechaFormateada %>" readonly>
                                </div>

                                <div class="col-6">
                                    <label for="idlibro" class="form-label">Libro</label>
                                    <select class="select2 form-control" name="idlibro" id="idlibro" onchange="mostrarFormularioLibro(this.value)"></select>
                                    
                                </div>
                            </div>

                            <div id="formularioLibroNuevo" style="display:none;">
                                <div class="card mt-4 shadow-sm">
    <div class="card-body">
        <h2 class="card-title text-center mb-4" style="font-size: 1.5rem; color: #007bff;">Formulario de Nuevo Libro</h2>
        <input type="hidden" name="listar" id="listar" value="cargar">
        <input type="hidden" name="idlibro" id="idlibro">

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="titulo_libro" class="form-label" style="font-weight: bold;">Título</label>
                <input type="text" class="form-control" id="titulo_libro" name="titulo_libro" placeholder="Ingrese el título">
                <div class="invalid-feedback" id="tituloError">Por favor, ingrese el título.</div>
            </div>
           <div class="col-md-6">
    <label for="idcategoria" class="form-label d-block" style="font-weight: bold; margin-bottom: 5px;">Categoría</label>
    <select class="select2 form-control" id="idcategoria" name="idcategoria" style="width: 100%;">
        <!-- Opciones de categorías -->
    </select>
    <div class="invalid-feedback" id="categoriaError">Por favor, seleccione una categoría.</div>
</div>

        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="descripcion_libro" class="form-label" style="font-weight: bold;">Descripción</label>
                <input type="text" class="form-control" id="descripcion_libro" name="descripcion_libro" placeholder="Ingrese la descripción">
                <div class="invalid-feedback" id="descripcionError">Por favor, ingrese la descripción.</div>
            </div>
            <div class="col-md-6">
    <label for="idautor" class="form-label d-block" style="font-weight: bold; margin-bottom: 5px;">Autor</label>
    <select class="select2 form-control" id="idautor" name="idautor" style="width: 100%;">
        <!-- Opciones de autores -->
    </select>
    <div class="invalid-feedback" id="autorError">Por favor, seleccione un autor.</div>
</div>

        </div>

        <div class="row mb-4">
            <div class="col-md-6">
                <label for="isbn" class="form-label" style="font-weight: bold;">ISBN</label>
                <input type="text" class="form-control" id="isbn" name="isbn" placeholder="Ingrese el ISBN del libro">
                <div class="invalid-feedback" id="isbnError">Por favor, ingrese el ISBN.</div>
            </div>
         <!---   <div class="col-md-6">
                <label for="cantidad_libros" class="form-label" style="font-weight: bold;">Cantidad</label>
                <input type="number" class="form-control" id="cantidad_libros" name="cantidad_libros" placeholder="Ingrese la cantidad">
                <div class="invalid-feedback" id="cantidadError">Por favor, ingrese la cantidad.</div>
            </div> --->
        </div>

        <div class="text-center mt-3">
            <button type="button" class="btn btn-primary" id="botonnuevolibro" style="margin-right: 10px;">Cargar Nuevo Libro</button>
            <button type="button" class="btn btn-secondary" id="cerrarFormulario">Cerrar</button>
        </div>
        <div id="mensaje" class="mt-3 text-center"></div>
    </div>
</div>


                            </div>
                                <div class="row">
                            <div class="col-6 ">
                                <label for="cantidadonacion" class="form-label">Cantidad</label>
                                <input type="number" class="form-control" id="cantidadonacion" name="cantidadonacion" placeholder="Ingrese la cantidad donada" value="1">
                            </div>
                                    <div class="col-6"><!-- comment -->
                                        <button type="button" id="abrirFormulario" class="btn btn-primary mt-2">Agregar nuevo libro</button>
                                    </div>
                                </div>
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-primary" id="botonagregar">Agregar Donación</button>
                                
                                <div id="respuesta"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container text-center mt-5">
            <div class="row">
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h2 class="card-title">Registro de la Donación</h2>
                            <table class="table " id="resultados">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Libro</th>
                                        <th scope="col">Cantidad</th>
                                        <th scope="col">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Aquí se insertarán las filas de la tabla dinámicamente -->
                                </tbody>
                            </table>

                            <div class="text-center mt-3">
                                <button type="button" class="btn btn-danger" id="canceldonacion">Cancelar</button>
                                <button type="button" class="btn btn-success" id="finaldonacion">Registrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="deldonacion">Sí</button>
                        </div>
                    </div>
                </div>
            </div>
    </form>
</main>


<%@include file="footer.jsp"%>
<script>
    $(document).ready(function () {
        buscarpersona();
        buscarlibros();
            cargarCategorias();
    cargarAutores();
    rellenardatos();
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
    function buscarpersona() {
        $.ajax({
            data: {listar: 'buscarpersona'},
            url: 'jsp/consulta_persona.jsp',
            type: 'post',
            beforeSend: function () {
                // Puedes agregar un mensaje de "Procesando" si es necesario
            },
            success: function (response) {
                $("#idpersona").html(response);
            }
        });
    }

    function buscarlibros() {
        $.ajax({
            data: {listar: 'buscarlibros'},
            url: 'jsp/consulta_libros.jsp',
            type: 'post',
            beforeSend: function () {
                // Puedes agregar un mensaje de "Procesando" si es necesario
            },
            success: function (response) {
                $("#idlibro").html(response);
            }
        });
    }

    $("#botonagregar").click(function () {
        var datosform = $("#form").serialize();
        $.ajax({
            data: datosform,
            url: 'jsp/donaciones.jsp',
            type: 'post',
            beforeSend: function () {
                // Puedes agregar un mensaje de "Procesando" si es necesario
            },
            success: function (response) {
                $("#respuesta").html(response);
                cargardetalle();
            }
        });
    });

    function cargardetalle() {
        $.ajax({
            data: {listar: 'listar'},
            url: 'jsp/donaciones.jsp',
            type: 'post',
            beforeSend: function () {
                // Puedes agregar un mensaje de "Procesando" si es necesario
            },
            success: function (response) {
                $("#resultados tbody").html(response);
            }
        });
    }

    $("#deldonacion").click(function () {
        var pkd = $("#pkdel").val();
        $.ajax({
            data: {listar: 'elimregdonacion', pkd: pkd},
            url: 'jsp/donaciones.jsp',
            type: 'post',
            beforeSend: function () {
                // Puedes agregar un mensaje de "Procesando" si es necesario
            },
            success: function (response) {
                console.log(response);
                cargardetalle();
            }
        });
    });

    $("#canceldonacion").click(function () {
        $.ajax({
            data: {listar: 'canceldonacion'},
            url: 'jsp/donaciones.jsp',
            type: 'post',
            beforeSend: function () {
                // Puedes agregar un mensaje de "Procesando" si es necesario
            },
            success: function (response) {
                location.href = 'listadonaciones.jsp';
            }
        });
    });

  $("#finaldonacion").click(function () {
    
    $.ajax({
        data: {listar: 'finaldonacion'},
        url: 'jsp/donaciones.jsp',
        type: 'post',
        beforeSend: function () {
            // Puedes agregar un mensaje de "Procesando" si es necesario
        },
        success: function (response) {
            console.log(response);
            location.href = 'listadonaciones.jsp';
        }
    });
});

    function dividirpersona(a) {
        var selectedOption = document.querySelector('#idpersona option[value="' + a + '"]');
        var ciPersona = selectedOption.getAttribute('data-ci');
        
        $("#ci_persona").val(ciPersona);
        $("#idpersona").val(a);
    }
    
     function mostrarFormularioLibro(value) {
        if (value === 'nuevo') {
            document.getElementById('formularioLibroNuevo').style.display = 'block';
        } else {
            document.getElementById('formularioLibroNuevo').style.display = 'none';
        }
    }

    
    


    // Evento del botón de agregar libro
    $("#botonnuevolibro").on("click", function () {
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
                // Actualiza la tabla y el select con los datos más recientes
                rellenardatos();
                actualizarSelectLibros(); // Nueva función para actualizar el select
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
    }
});

function actualizarSelectLibros() {
    $.ajax({
        url: 'jsp/consulta_libros.jsp',
        type: 'post',
        success: function (response) {
            $("#idlibro").html(response);
            // Selecciona el último elemento del select (el nuevo libro)
            var select = document.getElementById('idlibro');
            select.selectedIndex = select.options.length - 1;
        },
        error: function (error) {
            console.log(error);
        }
    });
}



function cargarAutores() {
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

function cargarCategorias() {
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

// Función de validación de formulario
function validarFormulario() {
    var tituloLibro = $("#titulo_libro").val().trim();
    var descripcionLibro = $("#descripcion_libro").val().trim();
    var isbn = $("#isbn").val().trim();

    if (tituloLibro === "") {
        $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el título del libro.</div>");
        return false;
    } else if ($("#idcategoria").val() === "") {
        $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, seleccione una categoría.</div>");
        return false;
    } else if (descripcionLibro === "") {
        $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese la descripción del libro.</div>");
        return false;
    } else if ($("#idautor").val() === "") {
        $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, seleccione un autor.</div>");
        return false;
    } else if (isbn === "") {
        $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el ISBN del libro.</div>");
        return false;
    }
    return true;
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

// Función para limpiar el formulario después de cargar un libro
function limpiarFormulario() {
    $("#titulo_libro").val("");
    $("#idcategoria").val("");
    $("#descripcion_libro").val("");
    $("#idautor").val("");
    $("#isbn").val("");
}
 document.getElementById('cerrarFormulario').addEventListener('click', function() {
    document.getElementById('formularioLibroNuevo').style.display = 'none';
    
});

document.getElementById('abrirFormulario').addEventListener('click', function() {
    mostrarFormularioLibro('nuevo');
});




function actualizarSelectLibros() {
    $.ajax({
        url: 'jsp/consulta_libros.jsp', // URL para obtener los libros actualizados
        type: 'post',
        success: function (response) {
            // Actualiza el select con los nuevos datos de libros
            $("#idlibro").html(response);
            
            // Selecciona el último libro automáticamente
            var select = document.getElementById('idlibro');
            select.selectedIndex = select.options.length - 1; // Selecciona el último libro
        },
        error: function (error) {
            console.log(error);
        }
    });
}

</script>



