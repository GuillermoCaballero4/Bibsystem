<%@include file="header.jsp"%>
<main id="main" class="main">
    <div id="mensaje"></div>
    <form action="#" method="post" id="form" onsubmit="return false" class="row g-3">
    <input type="hidden" name="listar" id="listar" value="cargar">
    <input type="hidden" name="idcategoria" id="idcategoria">

    <div class="container ">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <!-- comment --> 
                        
                        <h1 class="card-title text-center" >Formulario de las categorías</h1>
                       

                        <div class="col-6 mx-auto " >
                         <label for="nombre_categoria" class="form-label">Nombre</label>   
                            <input type="text" class="form-control" id="nombre_categoria" name="nombre_categoria" placeholder="Ingrese el nombre">
                        </div>
                        <br>
                        <div class="text-center">
                            <button type="button" class="btn btn-primary" id="boton" name="boton">Cargar</button>
                            <a class="btn btn-secondary" target="_blank" href="reportcategoria.jsp">Imprimir</a>
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
                        <h1 class="card-title text-center">Tabla de las categorías</h1>
                        <div class="col-6">
                        <input type="text" id="filtroInput" class="form-control " onkeyup="filtrarTabla()" placeholder="Buscar por nombre...">
                        </div>
                        <table class="table" id="resultado">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Nombre</th>
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
                    <input type="hidden" name="idcategoria" id="idcategoria">
                    <p>¿Está seguro de querer eliminar los datos de la categoría?</p>
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
            url: 'jsp/categoria.jsp',
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
        var nombreCategoria = $("#nombre_categoria").val().trim();

        if (nombreCategoria === "") {
            $("#mensaje").html("<div class='alert alert-danger' role='alert'>Por favor, ingrese el nombre de la categoría.</div>");
        }  else {
            var datosform = $("#form").serialize();
            $.ajax({
                data: datosform,
                url: 'jsp/categoria.jsp',
                type: 'post',
                success: function (response) {
                    $("#mensaje").html(response);
                    rellenardatos();
                    setTimeout(function () {
                        $("#mensaje").html("");
                        $("#nombre_categoria").val("");
                        $("#listar").val("cargar");
                        $("#nombre_categoria").focus();
                    }, 2000);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    });
});





    function rellenaredit(id, nombre) {
        $("#idcategoria").val(id);
        $("#nombre_categoria").val(nombre);
        $("#listar").val("modificar");
    }

    $('#eliminarregistro').on("click", function () {
        var listar = $("#listar_Eliminar").val();
        var pk = $("#idcategoria").val();
        $.ajax({
            data: { listar: "eliminar", idpk: pk },
            url: 'jsp/categoria.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response);
                rellenardatos();
                setTimeout(function () {
                    $("#mensaje").html("");
                    $("#nombre_categoria").val("");
                    $("#listar").val("cargar");
                    $("#nombre_categoria").focus();
                }, 2000);
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
</script>
