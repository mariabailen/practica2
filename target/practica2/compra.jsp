<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>

<%
    String usuario = (String) session.getAttribute("usuario");
    Integer codigoUsuario = (Integer) session.getAttribute("codigo");

    if (usuario == null || codigoUsuario == null) {
        response.sendRedirect("loginUsuario.jsp?url=compra.jsp");
        return;
    }

    AccesoBD db = AccesoBD.getInstance();
    Usuario datosUsuario = db.obtenerDatosUsuario(usuario);

    String nombre = datosUsuario != null ? datosUsuario.getNombre() : "";
    String domicilio = datosUsuario != null ? datosUsuario.getDomicilio() : "";
    String cp = datosUsuario != null ? datosUsuario.getCp() : "";
    String poblacion = datosUsuario != null ? datosUsuario.getPoblacion() : "";
    String provincia = datosUsuario != null ? datosUsuario.getProvincia() : "";
    String telefono = (datosUsuario != null && datosUsuario.getTelefono() != null) ? datosUsuario.getTelefono() : "";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Finalizar Compra</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Finalizar Compra</h2>

    <form action="ProcesarPedido" method="post" class="mx-auto" style="max-width: 700px;">
        <input type="hidden" name="carritoJSON" id="carritoJSON" />
        <input type="hidden" name="codigoUsuario" value="<%= codigoUsuario %>" />

        <h4>Datos de Envío</h4>
        <div class="mb-3">
            <label form="nombre" class="form-label">Nombre completo:</label>
            <input type="text" class="form-control" name="nombre" value="<%= nombre %>" required />
        </div>
        <div class="mb-3">
            <label form="domicilio" class="form-label">Domicilio:</label>
            <input type="text" class="form-control" name="domicilio" value="<%= domicilio %>" required />
        </div>
        <div class="mb-3">
            <label form="cp" class="form-label">Código Postal:</label>
            <input type="text" class="form-control" name="cp" value="<%= cp %>" required />
        </div>
        <div class="mb-3">
            <label form="poblacion" class="form-label">Población:</label>
            <input type="text" class="form-control" name="poblacion" value="<%= poblacion %>" required />
        </div>
        <div class="mb-3">
            <label form="provincia" class="form-label">Provincia:</label>
            <input type="text" class="form-control" name="provincia" value="<%= provincia %>" required />
        </div>
        <div class="mb-3">
            <label form="telefono" class="form-label">Teléfono:</label>
            <input type="text" class="form-control" name="telefono" value="<%= telefono %>" required />
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
                    <th>Cantidad</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody id="resumenBody">
                <!-- El resumen se cargará aquí con JavaScript -->
            </tbody>
        </table>
        <p class="text-end fw-bold">Total: <span id="totalCompra">0.00 €</span></p>

        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-success">Tramitar Pedido</button>
            <a href="carrito.jsp" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <p>&copy; 2025 MAKE UP WAPA</p>
</footer>

<script src="js/carrito.js"></script>
<script>
    function cargarResumenCompra() {
        let carrito = JSON.parse(localStorage.getItem("mi-carrito-almacenado")) || [];
        let resumenBody = document.getElementById("resumenBody");
        let total = 0;
        resumenBody.innerHTML = "";

        carrito.forEach(producto => {
            let subtotal = producto.precio * producto.cantidad;
            total += subtotal;
            resumenBody.innerHTML += `
                <tr>
                    <td>${producto.descripcion}</td>
                    <td>${producto.cantidad}</td>
                    <td>${subtotal.toFixed(2)} €</td>
                </tr>
            `;
        });

        document.getElementById("totalCompra").textContent = total.toFixed(2) + " €";
        // Guardar el JSON en el input oculto para enviarlo al servidor
        document.getElementById("carritoJSON").value = JSON.stringify(carrito);
    }

    window.onload = cargarResumenCompra;
</script>

</body>
</html>
