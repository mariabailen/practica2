<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MAKE UP WAPA - Empresa</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">MAKE UP WAPA</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link active" href="empresa.jsp">Empresa</a></li>
                        <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                        <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="carrito.jsp">Carrito</a></li>
                        <li class="nav-item"><a class="nav-link" href="administracion.jsp">Administración</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout.jsp">Cerrar Sesión</a></li>
                        <% String nombreUsuario=(String) session.getAttribute("usuario"); if (nombreUsuario !=null) { %>
                            <li class="nav-item">
                                <a class="nav-link btn btn-outline-light ms-2 text-white"
                                    href="perfil">
                                    Hola, <%= nombreUsuario %>
                                </a>
                            </li>
                            <% } else { %>
                                <li class="nav-item">
                                    <a class="nav-link active" href="loginUsuario.jsp">Login</a>
                                </li>
                                <% } %>

                    </ul>
                </div>
            </div>
        </nav>

        <main class="container mt-5 text-center">
            <h1>MAKE UP WAPA</h1>
            <p>Un proyecto que comenzó con la visión de transformar la belleza en una experiencia accesible y
                empoderadora.</p>

            <div class="logo-container">
                <img src="img/logotipo.jpg" alt="MAKE UP WAPA Logo" class="logo">
            </div>
        </main>

        <footer class="bg-dark text-white text-center py-3 mt-5">
            <p>&copy; 2025 MAKE UP WAPA</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>