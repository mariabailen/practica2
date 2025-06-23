<%@page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>MAKE UP WAPA - Acceso de Usuario</title>
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
                <%
                    String nombreUsuario = (String) session.getAttribute("usuario");
                    if (nombreUsuario != null) {
                %>
                    <li class="nav-item"><a class="nav-link disabled text-white" href="#">Hola, <%= nombreUsuario %></a></li>
                <%
                    } else {
                %>
                    <li class="nav-item"><a class="nav-link active" href="loginUsuario.jsp">Usuario</a></li>
                <%
                    }
                %>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Cerrar Sesión</a></li> 
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1 class="text-center">Acceso de Usuario</h1>
    <p class="text-center">Ingresa tus credenciales o regístrate si no tienes cuenta.</p>

    <div class="row justify-content-center mt-4">
        <div class="col-md-6">
            <%
                String mensaje = (String) session.getAttribute("mensaje");
                if (mensaje != null) {
                    session.removeAttribute("mensaje");
            %>
            <div class="alert alert-danger" role="alert">
                <%= mensaje %>
            </div>
            <%
                }
                Integer codigo = (Integer) session.getAttribute("codigo");
                if (codigo == null || codigo <= 0) {
            %>
            <form method="post" action="Login" class="shadow p-4 rounded bg-light">
                <input type="hidden" name="url" value="<%= request.getParameter("url") != null ? request.getParameter("url") : "productos.jsp" %>">

                <div class="mb-3">
                    <label form="usuario" class="form-label">Usuario</label>
                    <input name="usuario" type="text" class="form-control" placeholder="Introduce tu nombre de usuario" required>
                </div>

                <div class="mb-3">
                    <label form="clave" class="form-label">Contraseña</label>
                    <input name="clave" type="password" class="form-control" placeholder="Introduce tu contraseña" required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Entrar</button>
                    <button type="reset" class="btn btn-secondary">Cancelar</button>
                </div>
            </form>
            
            <div class="d-grid gap-2 mt-3">
                <a href="registroUsuario.jsp" class="btn btn-success">Registrarse</a>
            </div>
            <% 
                } else {
                    String url = request.getParameter("url");
                    if (url == null || url.isEmpty()) {
                        url = "productos.jsp";
                    }
                    response.sendRedirect(url);
                }
            %>
        </div>
    </div>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <p>&copy; 2025 MAKE UP WAPA</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
