               <%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>MAKE UP WAPA - Carrito</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="index.html">MAKE UP WAPA</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="empresa.jsp">Empresa</a></li>
                        <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                        <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="carrito.jsp">Carrito</a></li>
                        <li class="nav-item"><a class="nav-link" href="administracion.jsp">Administración</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout.jsp">Cerrar Sesión</a></li>
                        <% String nombreUsuario=(String) session.getAttribute("usuario"); if (nombreUsuario !=null) { %>
                            <li class="nav-item"><a class="nav-link disabled text-white" href="#">Hola, <%=nombreUsuario
                                        %></a></li>
                            <% } else { %>
                                <li class="nav-item"><a class="nav-link active" href="loginUsuario.jsp">Login</a></li>
                                <% } %>
                    </ul> 
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h1 class="text-center">Carrito de Compras</h1>
            <p class="text-center">Aquí puedes revisar y modificar los productos en tu carrito.</p>

            <!-- Tabla del carrito -->
            <table class="table mt-4">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Imagen</th>
                        <th>Cantidad</th>
                        <th>Total</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="carritoBody"></tbody>
            </table>

            <div class="text-center mt-4">
                <button class="btn btn-danger" onclick="vaciarCarrito()">Vaciar Carrito</button>
            </div>

            <div class="text-center mt-4">
                <button class="btn btn-primary" onclick="window.location.href='productos.jsp'">Seguir Comprando</button>
                <button class="btn btn-success" onclick="window.location.href='finalizarCompra.jsp'">Formalizar
                    Pedido</button>
            </div>

        </div>

        <footer class="bg-dark text-white text-center py-3 mt-5">
            <p>&copy; 2025 MAKE UP WAPA</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/carrito.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
            crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.6.0/js/bootstrap.min.js"
            crossorigin="anonymous"></script>

    </body>

    </html>