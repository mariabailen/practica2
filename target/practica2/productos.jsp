<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MAKE UP WAPA - Productos</title>
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

    <div class="container mt-5">
        <h1 class="text-center">Productos</h1>
        <p class="text-center">Explora nuestros productos y agrégales a tu carrito.</p>

        <div class="row">
            <%
            AccesoBD con = AccesoBD.getInstance();  // Asegúrate de que AccesoBD esté correctamente implementada
            List<ProductoBD> productos = (List<ProductoBD>) con.obtenerProductosBD();
            
            if (productos != null && !productos.isEmpty()) {
                for (ProductoBD producto : productos) {
                    int codigo = producto.getCodigo();
                    String descripcion = producto.getDescripcion();
                    float precio = producto.getPrecio();
                    int existencias = producto.getExistencias();
                    String imagen = producto.getImagen();
            %>
            <div class="col-12 col-md-4 col-lg-3 mb-4">
                <div class="card h-100">
                    <img src="img/<%= imagen %>" class="card-img-top" alt="<%= descripcion %>">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= descripcion %></h5>
                        <p class="card-text">Precio: <strong><%= precio %> €</strong></p>
                        <p class="card-text">Stock: <%= existencias %></p>

                        <% if (existencias > 0) { %>
                            <button class="btn btn-primary" onclick="anadirCarrito('<%= codigo %>', '<%= descripcion %>', '<%= imagen %>', '<%= precio %>', '<%= existencias %>')">Añadir al carrito</button>
                        <% } else { %>
                            <button class="btn btn-secondary" disabled>Sin stock</button>
                        <% } %>

                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <p class="text-center">No hay productos disponibles.</p>
            <%
            }
            %>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p>&copy; 2025 MAKE UP WAPA</p>
    </footer>

    <script src="js/carrito.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
