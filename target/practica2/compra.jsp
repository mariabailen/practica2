<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8"%>

<%
    String usuario = (String) session.getAttribute("usuario");
    Integer codigoUsuario = (Integer) session.getAttribute("codigo");

    if (usuario == null || codigoUsuario == null) {
        response.sendRedirect("loginUsuario.jsp?url=compra.jsp");
        return;
    }

    // Leer carrito de sesión, atributo "carrito"
    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");

    if (carrito == null) {
        carrito = new java.util.ArrayList<>(); // Evitar null para el for
    }

    AccesoBD db = AccesoBD.getInstance();
    Usuario datosUsuario = db.obtenerDatosUsuario(usuario);

    String nombre = datosUsuario != null ? datosUsuario.getNombre() : "";
    String domicilio = datosUsuario != null ? datosUsuario.getDomicilio() : "";
    String cp = datosUsuario != null ? datosUsuario.getCp() : "";
    String poblacion = datosUsuario != null ? datosUsuario.getPoblacion() : "";
    String provincia = datosUsuario != null ? datosUsuario.getProvincia() : "";
    String telefono = (datosUsuario != null && datosUsuario.getTelefono() != null) ? datosUsuario.getTelefono() : "";

    float totalPedido = 0;
    for (Producto p : carrito) {
        totalPedido += p.getPrecio() * p.getCantidad();
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Finalizar Compra</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Finalizar Compra</h2>

    <form action="ProcesarPedido" method="post" class="mx-auto" style="max-width: 700px;">
        <!-- Quitamos carritoJSON porque lo manejamos en sesión -->
        <input type="hidden" name="codigoUsuario" value="<%= codigoUsuario %>">
        <input type="hidden" name="importeTotal" value="<%= String.format("%.2f", totalPedido) %>">

        <h4>Datos de Envío</h4>
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre completo:</label>
            <input type="text" class="form-control" name="nombre" value="<%= nombre %>" required>
        </div>
        <div class="mb-3">
            <label for="domicilio" class="form-label">Domicilio:</label>
            <input type="text" class="form-control" name="domicilio" value="<%= domicilio %>" required>
        </div>
        <div class="mb-3">
            <label for="cp" class="form-label">Código Postal:</label>
            <input type="text" class="form-control" name="cp" value="<%= cp %>" required>
        </div>
        <div class="mb-3">
            <label for="poblacion" class="form-label">Población:</label>
            <input type="text" class="form-control" name="poblacion" value="<%= poblacion %>" required>
        </div>
        <div class="mb-3">
            <label for="provincia" class="form-label">Provincia:</label>
            <input type="text" class="form-control" name="provincia" value="<%= provincia %>" required>
        </div>
        <div class="mb-3">
            <label for="telefono" class="form-label">Teléfono:</label>
            <input type="text" class="form-control" name="telefono" value="<%= telefono %>" required>
        </div>

        <h4>Método de Pago</h4>
        <div class="mb-3">
            <select class="form-select" name="metodoPago" required>
                <option value="Tarjeta">Tarjeta de Crédito</option>
                <option value="Transferencia">Transferencia</option>
                <option value="Bizum">Bizum</option>
                <option value="Contra reembolso">Contra reembolso</option>
            </select>
        </div>

        <h4>Resumen del Pedido</h4>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Producto p : carrito) {
                    float subtotal = p.getPrecio() * p.getCantidad();
            %>
                <tr>
                    <td><%= p.getDescripcion() %></td>
                    <td><%= String.format("%.2f", p.getPrecio()) %> €</td>
                    <td><%= p.getCantidad() %></td>
                    <td><%= String.format("%.2f", subtotal) %> €</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <p class="text-end fw-bold">Total: <%= String.format("%.2f", totalPedido) %> €</p>

        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-success">Tramitar Pedido</button>
            <a href="carrito.jsp" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <p>&copy; 2025 MAKE UP WAPA</p>
</footer>

</body>
</html>
