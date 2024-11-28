
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Inicio de sesión - Bibsystem</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="img/icons8-biblioteca-50.png" rel="icon">
  <link href="img/icons8-biblioteca-50.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Archivos CSS de proveedores -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="vendor/simple-datatables/style.css" rel="stylesheet">
<style>
    .input-group {
        position: relative;
    }
    .input-group .form-control {
        padding-right: 80px; /* Ajusta el espacio para los botones */
    }
    .input-group .btn {
        position: absolute;
        top: 0;
        right: 0;
        height: 100%;
        border-radius: 0;
        padding: 0 10px;
        z-index: 1;
    }
    .input-group .btn-success {
        right: 50px; /* Ajusta la posición del botón de incremento */
    }
    .input-group .btn-danger {
        right: 0; /* Ajusta la posición del botón de decremento */
    }
</style>

  <!-- Archivo CSS principal de la plantilla -->
  <link href="css/style.css" rel="stylesheet">
<!-- si quieren descargar la plantilla pueden descargarlo aqui -->
  <!-- =======================================================
  * Nombre de la plantilla: NiceAdmin
  * URL de la plantilla: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Actualizado: 20 de abril de 2024 con Bootstrap v5.3.3
  * Autor: BootstrapMade.com
  * Licencia: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>
 <form action="#" method="post" id="form" >
  <main>
      <div id="respuesta"></div>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                  <a  class="logo d-flex align-items-center w-auto">
                  <img src="img/icons8-biblioteca-50.png" alt="">
                  <span ">Bibsystem</span>
                </a>
              </div><!-- Fin del logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Inicia sesión en tu cuenta</h5>
                    <p class="text-center small">Ingresa tu nombre de usuario y contraseña para iniciar sesión</p>
                  </div>

                  <form class="row g-3 needs-validation" novalidate>

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">Nombre de usuario</label>
                      <div class="input-group has-validation">
                        
                        <input type="text" name="nombre_usu" class="form-control" id="yourUsername" >
                        <div class="invalid-feedback">Por favor, ingresa tu nombre de usuario.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">Contraseña</label>
                      <input type="password" name="clave_usu" class="form-control" id="yourPassword" >
                      <div class="invalid-feedback">¡Por favor, ingresa tu contraseña!</div>
                    </div>
                      <br>
                    <div class="col-12">
                        <button class="btn btn-primary w-100" type="button" id="acceso"  >Iniciar sesión</button>
                    </div>
                      <!-- comment <div class="col-12">
                        <p class="small mb-0">¿No tienes una cuenta? <a href="register.jsp">Crea una cuenta</a></p>
                    </div> -->   
                  </form>

                </div>
              </div>

              

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- Fin del #main -->
<div class="credits">
                <!-- Todos los enlaces en el pie de página deben permanecer intactos. -->
                <!-- Puedes eliminar los enlaces solo si compraste la versión pro. -->
                <!-- Información de la licencia: https://bootstrapmade.com/license/ -->
                <!-- Compra la versión pro con el formulario de contacto PHP/AJAX funcional: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                <!--Diseñado por <a href="https://bootstrapmade.com/">BootstrapMade</a>-->
                
              </div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  
 </form>
  <!-- Archivos JS de proveedores -->
  <script src="vendor/apexcharts/apexcharts.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="vendor/chart.js/chart.umd.js"></script>
  <script src="vendor/echarts/echarts.min.js"></script>
  <script src="vendor/quill/quill.js"></script>
  <script src="vendor/simple-datatables/simple-datatables.js"></script>
  <script src="vendor/tinymce/tinymce.min.js"></script>
  <script src="vendor/php-email-form/validate.js"></script>
<script src="js/jquery-3.7.1.min.js"></script>
  <!-- Template Main JS File -->
  <script src="js/main.js"></script>
  <script src="js/bootstrap.bundle.min.js"></script>




<!-- Bootstrap Bundle JS (incluye Popper.js) -->
<script src="js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="js/nj/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS -->
<script src="js/nj/bootstrap.min.js"></script>

  <!-- Archivo JS principal de la plantilla -->
  <script src="js/main.js"></script>
  <script>
      $(function () {
        $("#acceso").click(function(){
           dataform = $("form").serialize();
        $.ajax({
            data: dataform,
            url: 'jsp/login.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                $("#respuesta").html(response);
                
            }
        });
        });

        });
     </script>
      <script>
history.replaceState(null, null, location.href);
window.onpopstate = function () {
    history.go(1);
};
</script>

</body>

</html>
