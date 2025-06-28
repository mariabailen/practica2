<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8"%>
<%
    String usuario = (String) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("loginUsuario.jsp?url=pedidos.jsp");
        return;
    }
    AccesoBD db = AccesoBD.getInstance();
    int codigoUsuario = (Integer) session.getAttribute("codigo");
    List<Pedido> pedidos = db.obtenerPedidosUsuario(codigoUsuario);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Pedidos</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/bootstrap.min.css" integrity="sha384-9aIt2nRpC6IzVButxZRooFJgHxcFjBQmWWL5Q8PTCyk6iVP+2YH1l96W+LOI/PFG" crossorigin="anonymous">
    <script src="./js/bootstrap.bundle.min.js" integrity="sha384-9aIt2nRpC6IzVButxZRooFJgHxcFjBQmWWL5Q8PTCyk6iVP+2YH1l96W+LOI/PFG" crossorigin="anonymous"></script>
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
                    <li class="nav-item"><a class="nav-link" href="empresa.jsp">Empresa</a></li>
                    <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                    <li class="nav-item"><a class="nav-link" href="carrito.jsp">Carrito</a></li>
                    <li class="nav-item"><a class="nav-link" href="administracion.jsp">Administración</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Cerrar Sesión</a></li>
                    <% String nombreUsuario = (String) session.getAttribute("usuario");
                       if (nombreUsuario != null) { %>
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light ms-2 text-white" href="perfil">
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
    <header class="bg-primary text-white p-4 text-center">
        <menu-web></menu-web>
    </header>

    <main class="container mt-4">
        <h2 class="text-center mb-4">Mis Pedidos</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID Pedido</th>
                    <th>Fecha</th>
                    <th>Importe</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <% for (Pedido p : pedidos) { %>
                <tr>
                    <td><%= p.getCodigo() %></td>
                    <td><%= p.getFecha() %></td>
                    <td><%= String.format("%.2f", p.getImporte()) %>€</td>
                    <td><%= p.getEstadoDescripcion() %></td>
                    <td>
                        <% if ("Pendiente".equalsIgnoreCase(p.getEstadoDescripcion())) { %>
                            <form action="CancelarPedido" method="post">
                                <input type="hidden" name="codigoPedido" value="<%= p.getCodigo() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Cancelar</button>
                            </form>
                        <% } else { %>
                            No disponible
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <strong>Productos:</strong>
                        <table class="table table-sm mt-2">
                            <thead>
                                <tr>
                                    <th>Descripción</th>
                                    <th>Precio</th>
                                    <th>Cantidad</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                                List<Detalle> detalles = db.obtenerDetallesPedido(p.getCodigo());
                                for (Detalle d : detalles) { 
                            %>
                                <tr>
                                    <td><%= d.getDescripcion() %></td>
                                    <td><%= String.format("%.2f", d.getPrecio()) %>€</td>
                                    <td><%= d.getCantidad() %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
        
    </main>

    <footer class="bg-dark text-white text-center py-3 mt-4">
        <pie-pagina-web></pie-pagina-web>
    </footer>

    <script src="js/mis_etiquetas.js"></script>
</body>
</html>
