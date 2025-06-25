<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.AccesoBD, tienda.Usuario" pageEncoding="UTF-8"%>

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
    <meta charset="UTF-8">
    <title>Finalizar Compra</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Finalizar Compra</h2>

    <form action="ProcesarPedido" method="post" class="mx-auto" style="max-width: 700px;">
        <!-- Campo oculto para enviar el carrito JSON -->
        <input type="hidden" name="carritoJSON" id="carritoJSON">
        <input type="hidden" name="codigoUsuario" value="<%= codigoUsuario %>">
        <input type="hidden" name="importeTotal" id="importeTotal" value="0">

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
            <tbody id="resumenCarrito">
                <!-- Aquí se generarán las filas con JS -->
            </tbody>
        </table>
        <p class="text-end fw-bold">Total: <span id="totalPedido">0.00</span> €</p>

        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-success">Tramitar Pedido</button>
            <a href="carrito.jsp" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <p>&copy; 2025 MAKE UP WAPA</p>
</footer>

<script>
    // Obtener el carrito del localStorage
    const carritoJSON = localStorage.getItem("carrito");
    const carritoInput = document.getElementById("carritoJSON");
    const importeInput = document.getElementById("importeTotal");
    const tbody = document.getElementById("resumenCarrito");
    const totalSpan = document.getElementById("totalPedido");

    if (carritoJSON) {
        const carrito = JSON.parse(carritoJSON);
        carritoInput.value = carritoJSON;

        let total = 0;

        carrito.forEach(producto => {
            const subtotal = producto.precio * producto.cantidad;
            total += subtotal;

            const fila = document.createElement("tr");
            fila.innerHTML = `
                <td>${producto.descripcion}</td>
                <td>${producto.precio.toFixed(2)} €</td>
                <td>${producto.cantidad}</td>
                <td>${subtotal.toFixed(2)} €</td>
            `;
            tbody.appendChild(fila);
        });

        totalSpan.textContent = total.toFixed(2);
        importeInput.value = total.toFixed(2);

    } else {
        const fila = document.createElement("tr");
        fila.innerHTML = `<td colspan="4" class="text-center">No hay productos en el carrito.</td>`;
        tbody.appendChild(fila);
        importeInput.value = "0";
    }
</script>

</body>
</html>
