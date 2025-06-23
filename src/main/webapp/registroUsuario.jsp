<%@page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - MAKE UP WAPA</title>
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
                <li class="nav-item"><a class="nav-link" href="index.html">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="empresa.html">Empresa</a></li>
                <li class="nav-item"><a class="nav-link" href="contacto.html">Contacto</a></li>
                <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                <li class="nav-item"><a class="nav-link" href="carrito.jsp">Carrito</a></li>
                <li class="nav-item"><a class="nav-link" href="administracion.html">Administración</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Cerrar Sesión</a></li> 
                <%
                    String nombreUsuario = (String) session.getAttribute("usuario");
                    if (nombreUsuario != null) {
                %>
                    <li class="nav-item"><a class="nav-link disabled text-white" href="#">Hola, <%=nombreUsuario %></a></li>
                <%
                    } else {
                %>
                    <li class="nav-item"><a class="nav-link active" href="loginUsuario.jsp">Login</a></li>
                <%
                    }
                %>
            </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center">Registro de Usuario</h1>
        <p class="text-center">Por favor, complete los siguientes datos para registrarse.</p>

        <% 
            // Verificar si hay un mensaje en la sesión
            String mensaje = (String) session.getAttribute("mensaje");
            if (mensaje != null) { 
        %>
            <div class="alert alert-danger" role="alert">
                <%= mensaje %>
            </div>
            <% 
                // Eliminar el mensaje después de mostrarlo
                session.removeAttribute("mensaje"); 
            }
        %>

        <div class="row justify-content-center mt-4">
            <div class="col-md-6">
                <form action="Registro" method="post" class="shadow p-4 rounded bg-light">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="usuario" class="form-label">Usuario</label>
                        <input type="text" class="form-control" id="usuario" name="usuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="clave" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="clave" name="clave" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmarClave" class="form-label">Confirmar Contraseña</label>
                        <input type="password" class="form-control" id="confirmarClave" name="confirmarClave" required>
                    </div>

                    <!-- Campos adicionales -->
                    <div class="mb-3">
                        <label for="apellidos" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="apellidos" name="apellidos">
                    </div>
                    <div class="mb-3">
                        <label for="domicilio" class="form-label">Domicilio</label>
                        <input type="text" class="form-control" id="domicilio" name="domicilio">
                    </div>
                    <div class="mb-3">
                        <label for="poblacion" class="form-label">Población</label>
                        <input type="text" class="form-control" id="poblacion" name="poblacion">
                    </div>
                    <div class="mb-3">
                        <label for="provincia" class="form-label">Provincia</label>
                        <input type="text" class="form-control" id="provincia" name="provincia">
                    </div>
                    <div class="mb-3">
                        <label for="cp" class="form-label">Código Postal</label>
                        <input type="text" class="form-control" id="cp" name="cp">
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" name="telefono">
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Registrar</button>
                </form>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p>&copy; 2025 MAKE UP WAPA</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
