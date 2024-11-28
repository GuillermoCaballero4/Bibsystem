
<%
    HttpSession sesion = request.getSession();

    if (sesion.getAttribute("logueado") == null || sesion.getAttribute("logueado").equals("0")) {
%>
<script>location.href = "index.jsp";alert('Ud. debe de identificarse..!!');</script>	
<% } %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Sistema bibliotecario Bibsystem</title>
        <meta content="" name="description">
        <meta content="" name="keywords">
        <link href="css/select2.min.css" rel="stylesheet" />

        <!-- Favicons -->
        <link href="img/icons8-biblioteca-50.png" rel="icon">
        <link href="img/icons8-biblioteca-50.png" rel="apple-touch-icon">

        <!-- Google Fonts -->


        <!-- Vendor CSS Files -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="vendor/quill/quill.snow.css" rel="stylesheet">
        <link href="vendor/quill/quill.bubble.css" rel="stylesheet">
        <link href="vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="vendor/simple-datatables/style.css" rel="stylesheet">

        <!-- Template Main CSS File -->
        <link href="css/style.css" rel="stylesheet">

        <!-- =======================================================
        * Template Name: NiceAdmin
        * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
        * Updated: Apr 20 2024 with Bootstrap v5.3.3
        * Author: BootstrapMade.com
        * License: https://bootstrapmade.com/license/
        ======================================================== -->
        <style>
            .icono-negro {
                color: black; /* Cambia el color a negro */
            }
            /* Apariencia general */
            .card-title {
                font-weight: bold;
            }

            .table-primary {
                background-color: #e9f5ff;
            }

            .btn {
                padding: 10px 20px;
                font-size: 1rem;
            }

            .modal-title {
                color: #007bff;
            }

            .main {
                padding: 20px;
            }

            .shadow-sm {
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            }

        </style>

    </head>

    <body>

        <!-- ======= Header ======= -->
        <header id="header" class="header fixed-top d-flex align-items-center">

            <div class="d-flex align-items-center justify-content-between">
                <a href="dashboard.jsp" class="logo d-flex align-items-center">
                    <img src="img/icons8-biblioteca-50.png" alt="">
                    <span class="d-none d-lg-block">Bibsystem</span>
                </a>
                <i class="bi bi-list toggle-sidebar-btn"></i>
            </div><!-- End Logo -->

            <div class="search-bar">
                <form class="search-form d-flex align-items-center" method="POST" action="#">
                    <input type="text" name="query" placeholder="Search" title="Enter search keyword">
                    <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                </form>
            </div><!-- End Search Bar -->

            <nav class="header-nav ms-auto">
                <ul class="d-flex align-items-center">

                    <li class="nav-item d-block d-lg-none">
                        <a class="nav-link nav-icon search-bar-toggle " href="#">
                            <i class="bi bi-search"></i>
                        </a>
                    </li><!-- End Search Icon-->

                    <li class="nav-item dropdown">

                        <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-bell"></i>
                            <span class="badge bg-primary badge-number">4</span>
                        </a><!-- End Notification Icon -->

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                            <li class="dropdown-header">
                                You have 4 new notifications
                                <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-exclamation-circle text-warning"></i>
                                <div>
                                    <h4>Lorem Ipsum</h4>
                                    <p>Quae dolorem earum veritatis oditseno</p>
                                    <p>30 min. ago</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-x-circle text-danger"></i>
                                <div>
                                    <h4>Atque rerum nesciunt</h4>
                                    <p>Quae dolorem earum veritatis oditseno</p>
                                    <p>1 hr. ago</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-check-circle text-success"></i>
                                <div>
                                    <h4>Sit rerum fuga</h4>
                                    <p>Quae dolorem earum veritatis oditseno</p>
                                    <p>2 hrs. ago</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-info-circle text-primary"></i>
                                <div>
                                    <h4>Dicta reprehenderit</h4>
                                    <p>Quae dolorem earum veritatis oditseno</p>
                                    <p>4 hrs. ago</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li class="dropdown-footer">
                                <a href="#">Show all notifications</a>
                            </li>

                        </ul><!-- End Notification Dropdown Items -->

                    </li><!-- End Notification Nav -->

                    <li class="nav-item dropdown">

                        <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-chat-left-text"></i>
                            <span class="badge bg-success badge-number">3</span>
                        </a><!-- End Messages Icon -->

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages">
                            <li class="dropdown-header">
                                You have 3 new messages
                                <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="message-item">
                                <a href="#">
                                    <img src="img/messages-1.jpg" alt="" class="rounded-circle">
                                    <div>
                                        <h4>Maria Hudson</h4>
                                        <p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
                                        <p>4 hrs. ago</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="message-item">
                                <a href="#">
                                    <img src="img/messages-2.jpg" alt="" class="rounded-circle">
                                    <div>
                                        <h4>Anna Nelson</h4>
                                        <p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
                                        <p>6 hrs. ago</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="message-item">
                                <a href="#">
                                    <img src="img/messages-3.jpg" alt="" class="rounded-circle">
                                    <div>
                                        <h4>David Muldon</h4>
                                        <p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
                                        <p>8 hrs. ago</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="dropdown-footer">
                                <a href="#">Show all messages</a>
                            </li>

                        </ul><!-- End Messages Dropdown Items -->

                    </li><!-- End Messages Nav -->

                    <li class="nav-item dropdown pe-3">
                        <a class="nav-link nav-profile d-flex align-items-center pe-0 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="img/profile-img.jpg" alt="Profile" class="rounded-circle">
                            <span class="d-none d-md-block ps-2"><% out.print(sesion.getAttribute("user")); %></span>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                            <li class="dropdown-header">
                                <h6><% out.print(sesion.getAttribute("user"));%></h6>
                                <span>Administrador</span>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                                    <i class="bi bi-person"></i>
                                    <span>Mi perfil</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                                    <i class="bi bi-gear"></i>
                                    <span>Configurar cuenta</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="pages-faq.html">
                                    <i class="bi bi-question-circle"></i>
                                    <span>Necesita ayuda?</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="jsp/logout.jsp">
                                    <i class="bi bi-box-arrow-right"></i>
                                    <span>Salir</span>
                                </a>
                            </li>
                        </ul><!-- End Profile Dropdown Items -->
                    </li><!-- End Profile Nav -->


                </ul>
            </nav><!-- End Icons Navigation -->

        </header><!-- End Header -->

        <!-- ======= Sidebar ======= -->
        <aside id="sidebar" class="sidebar">
            <ul class="sidebar-nav" id="sidebar-nav">

                <!-- Ítem de Inicio -->
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp">
                        <i class="bi bi-grid"></i>
                        <span>Inicio</span>
                    </a>
                </li><!-- End Dashboard Nav -->

                <!-- Primer ítem de menú -->
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-toggle="collapse" href="#components-nav">
                        <i class="bi bi-journal-text"></i><span>Mantenimiento</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="components-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="categorias.jsp"><i class="bi bi-circle"></i><span>Categorias</span></a></li>
                        <li><a href="autores.jsp"><i class="bi bi-circle"></i><span>Autores</span></a></li>
                        <li><a href="libros.jsp"><i class="bi bi-circle"></i><span>Libros</span></a></li>
                        <li><a href="personas.jsp"><i class="bi bi-circle"></i><span>Personas</span></a></li>
                        <li><a href="personales.jsp"><i class="bi bi-circle"></i><span>Personales</span></a></li>
                        <li><a href="usuarios.jsp"><i class="bi bi-circle"></i><span>Usuarios</span></a></li>
                        <li><a href="metododepago.jsp"><i class="bi bi-circle"></i><span>Metodo de pago</span></a></li>
                    </ul>
                </li>

                <!-- Segundo ítem de menú -->
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-toggle="collapse" href="#forms-nav2">
                        <i class="bx bxs-brightness"></i><span>Gestión de prestamos</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="forms-nav2" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="listarreserva.jsp"><i class="bi bi-circle"></i><span>Reservas</span></a></li>
                        <li><a href="listadoprestamo.jsp"><i class="bi bi-circle"></i><span>Prestamos</span></a></li>
                        <li><a href="listadodevoluciones.jsp"><i class="bi bi-circle"></i><span>Devoluciones</span></a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-toggle="collapse" href="#forms5">
                        <i class="bx bxs-brightness"></i><span>Gestión Administrativa</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="forms5" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="cobros.jsp"><i class="bi bi-circle"></i><span>Cobro de multas</span></a></li>

                    </ul>
                </li>
                <!-- Tercer ítem de menú -->

                <!-- Cuarto ítem de menú -->
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-toggle="collapse" href="#forms4">
                        <i class="bx bxs-brightness"></i><span>Inventario</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="forms4" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="ajuste.jsp"><i class="bi bi-circle"></i><span>Ajuste De inventario</span></a></li>
                        <li><a href="Disponibilidad.jsp"><i class="bi bi-circle"></i><span>Disponibilidad</span></a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-toggle="collapse" href="#donaciones">
                        <i class="bx bxs-brightness"></i><span>Donaciones</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="donaciones" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="listadonaciones.jsp"><i class="bi bi-circle"></i><span>Donaciones</span></a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link collapsed" data-bs-toggle="collapse" href="#forms777">
                        <i class="bx bxs-brightness"></i><span>Informes</span><i class="bi bi-chevron-down ms-auto"></i>
                    </a>
                    <ul id="forms777" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                        <li><a href="Informes.jsp"><i class="bi bi-circle"></i><span>Reservas</span></a></li>
                        <li><a href="Informedetalle.jsp"><i class="bi bi-circle"></i><span>Detalle de las reservas</span></a></li>
                        <li><a href="Informeprestamo.jsp"><i class="bi bi-circle"></i><span>Prestamos</span></a></li>
                        <li><a href="Informedetalleprestamo.jsp"><i class="bi bi-circle"></i><span>Detalle de los Prestamos</span></a></li>
                        <li><a href="Informedevoluciones.jsp"><i class="bi bi-circle"></i><span>Devoluciones</span></a></li>
                        <li><a href="Informedetalledevoluciones.jsp"><i class="bi bi-circle"></i><span>Detalle de las Devoluciones</span></a></li>
                        <li><a href="Informedonaciones.jsp"><i class="bi bi-circle"></i><span>Donaciones</span></a></li>
                        <li><a href="Informedetalledonaciones.jsp"><i class="bi bi-circle"></i><span>Detalle de las Donaciones</span></a></li>
                        <li><a href="Informecobros.jsp"><i class="bi bi-circle"></i><span>Cobros</span></a></li>
                        
                    </ul>
                </li>

            </ul>
        </aside><!-- End Sidebar -->

