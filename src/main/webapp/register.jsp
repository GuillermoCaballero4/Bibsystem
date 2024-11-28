<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Registro - Bibsystem</title>
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

  <!-- Archivo CSS principal de la plantilla -->
  <link href="css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Nombre de la plantilla: NiceAdmin
  * URL de la plantilla: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Actualizado: 20 de abril de 2024 con Bootstrap v5.3.3
  * Autor: BootstrapMade.com
  * Licencia: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>
    <form action="index.jsp" method="post" id="form" >
  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justificar-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                  <a href="index.jsp" class="logo d-flex align-items-center w-auto">
                  <img src="img/icons8-biblioteca-50.png" alt="">
                  <span class="d-none d-lg-block">Bibsystem</span>
                </a>
              </div><!-- Fin del logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Crear una cuenta</h5>
                    <p class="text-center small">Ingresa tus datos personales para crear una cuenta</p>
                  </div>

                  <form class="row g-3 needs-validation" novalidate>
                    <div class="col-12">
                      <label for="yourName" class="form-label">Tu nombre</label>
                      <input type="text" name="name" class="form-control" id="yourName" >
                      <div class="invalid-feedback">¡Por favor, ingresa tu nombre!</div>
                    </div>

                    <div class="col-12">
                      <label for="yourEmail" class="form-label">Tu correo electrónico</label>
                      <input type="email" name="email" class="form-control" id="yourEmail" >
                      <div class="invalid-feedback">¡Por favor, ingresa una dirección de correo electrónico válida!</div>
                    </div>

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">Nombre de usuario</label>
                      <div class="input-group has-validation">
                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                        <input type="text" name="username" class="form-control" id="yourUsername" >
                        <div class="invalid-feedback">Por favor, elige un nombre de usuario.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">Contraseña</label>
                      <input type="password" name="password" class="form-control" id="yourPassword" >
                      <div class="invalid-feedback">¡Por favor, ingresa tu contraseña!</div>
                    </div>

                   <!-- <div class="col-12">
                      <div class="form-check">
                        <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" >
                        <label class="form-check-label" for="acceptTerms">Estoy de acuerdo y acepto los <a href="#">términos y condiciones</a></label>
                        <div class="invalid-feedback">Debes aceptar antes de enviar.</div>
                      </div>-->
                    </div>
                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Crear cuenta</button>
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">¿Ya tienes una cuenta? <a href="index.jsp">Iniciar sesión</a></p>
                    </div>
                  </form>

                </div>
              </div>

              <div class="credits">
                <!-- Todos los enlaces en el pie de página deben permanecer intactos. -->
                <!-- Puedes eliminar los enlaces solo si compraste la versión pro. -->
                <!-- Información de la licencia: https://bootstrapmade.com/license/ -->
                <!-- Compra la versión pro con el formulario de contacto PHP/AJAX funcional: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                Diseñado por <a href="https://bootstrapmade.com/">BootstrapMade</a>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- Fin del #main -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Archivos JS de proveedores -->
  <script src="vendor/apexcharts/apexcharts.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="vendor/chart.js/chart.umd.js"></script>
  <script src="vendor/echarts/echarts.min.js"></script>
  <script src="vendor/quill/quill.js"></script>
  <script src="vendor/simple-datatables/simple-datatables.js"></script>
  <script src="vendor/tinymce/tinymce.min.js"></script>
  <script src="vendor/php-email-form/validate.js"></script>

  <!-- Archivo JS principal de la plantilla -->
  <script src="js/main.js"></script>
  <form>
</body>

</html>
