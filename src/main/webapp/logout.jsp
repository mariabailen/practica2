<%@page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout - MAKE UP WAPA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <script>
        // Redirigir después de 3 segundos a la página principal
        setTimeout(function() {
            window.location.href = "loginUsuario.jsp";  //
        }, 3000);  
    </script>
</head>
<body>

    <%

    if (session != null) {
        session.removeAttribute("codigo");
        session.removeAttribute("usuario");
    }
%>
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
        <h1 class="text-center">Sesión Cerrada</h1>
        <p class="text-center">Has cerrado sesión exitosamente. Serás redirigido a la página de inicio en breve.</p>
        <div class="d-flex justify-content-center mt-4">
            <div class="alert alert-success" role="alert">
                <strong>¡Adiós!</strong> Tu sesión ha sido cerrada. Gracias por usar MAKE UP WAPA.
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p>&copy; 2025 MAKE UP WAPA</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
