<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8"%>
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
                    <% String nombreUsuario = (String) session.getAttribute("usuario");
                       if (nombreUsuario != null) { %>
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light ms-2 text-white" href="perfil">Hola, <%= nombreUsuario %></a>
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
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h1 class="mb-0">Productos</h1>
            <input type="text" id="searchInput" class="form-control w-50" placeholder="Buscar productos...">
        </div>
        <p class="text-center mb-4">Explora nuestros productos y agrégales a tu carrito.</p>

        <div>
            <%
            // Cargar productos y configurar paginación
            AccesoBD con = AccesoBD.getInstance();
            List<ProductoBD> productos = con.obtenerProductosBD();
            int pageSize = 8;
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try { currentPage = Integer.parseInt(pageParam); }
                catch (NumberFormatException e) { currentPage = 1; }
            }
            int totalProducts = (productos != null) ? productos.size() : 0;
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            int fromIndex = (currentPage - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalProducts);
            List<ProductoBD> pageProducts = (productos != null)
                ? productos.subList(fromIndex, toIndex)
                : java.util.Collections.emptyList();
            %>
        </div>

        <div class="row" id="productsContainer">
            <% if (!pageProducts.isEmpty()) {
                   for (ProductoBD producto : pageProducts) {
                       int codigo = producto.getCodigo();
                       String descripcion = producto.getDescripcion();
                       float precio = producto.getPrecio();
                       int existencias = producto.getExistencias();
                       String imagen = producto.getImagen();
            %>
            <div class="col-12 col-md-4 col-lg-3 mb-4 product-card">
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
            <%     }
               } else { %>
            <p class="text-center">No hay productos disponibles en esta página.</p>
            <% } %>
        </div>

        <!-- Paginación -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <% if (currentPage > 1) { %>
                <li class="page-item">
                    <a class="page-link" href="productos.jsp?page=<%= currentPage - 1 %>">Anterior</a>
                </li>
                <% } else { %>
                <li class="page-item disabled">
                    <span class="page-link">Anterior</span>
                </li>
                <% }
                   for (int i = 1; i <= totalPages; i++) {
                %>
                <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                    <a class="page-link" href="productos.jsp?page=<%= i %>"><%= i %></a>
                </li>
                <% } 
                   if (currentPage < totalPages) { %>
                <li class="page-item">
                    <a class="page-link" href="productos.jsp?page=<%= currentPage + 1 %>">Siguiente</a>
                </li>
                <% } else { %>
                <li class="page-item disabled">
                    <span class="page-link">Siguiente</span>
                </li>
                <% } %>
            </ul>
        </nav>

    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p>&copy; 2025 MAKE UP WAPA</p>
    </footer>

    <script src="js/carrito.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filtrar productos por búsqueda
        document.getElementById('searchInput').addEventListener('keyup', function() {
            var filter = this.value.toLowerCase();
            var cards = document.querySelectorAll('.product-card');
            cards.forEach(function(card) {
                var title = card.querySelector('.card-title').textContent.toLowerCase();
                if (title.indexOf(filter) > -1) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
