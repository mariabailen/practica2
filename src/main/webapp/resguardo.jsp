<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, tienda.Producto" %>
<%@ page import="tienda.Usuario" %>
<%
    HttpSession sesion = request.getSession(false);
    ArrayList<Producto> carrito = (ArrayList<Producto>) sesion.getAttribute("carritoJSON");
    Usuario usuario = (Usuario) sesion.getAttribute("usuario"); // Asegúrate de tener esto en sesión
%>
<html>
<head>
    <title>Confirmar Pedido</title>
</head>
<body>
    <h2>Resumen del Pedido</h2>

    <h3>Datos del Cliente</h3>
    <form action="Tramitacion" method="post">
        Nombre: <input type="text" name="nombre" value="<%= usuario.getNombre() %>" /><br>
        Dirección: <input type="text" name="direccion" value="<%= usuario.getDireccion() %>" /><br>
        Código Postal: <input type="text" name="cp" value="<%= usuario.getCp() %>" /><br>
        Método de Pago:
        <select name="pago">
            <option value="tarjeta">Tarjeta de crédito</option>
            <option value="contrareembolso">Contra reembolso</option>
        </select><br><br>

        <h3>Productos</h3>
        <table border="1">
            <tr>
                <th>Descripción</th>
                <th>Imagen</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Total</th>
            </tr>
            <% 
                float total = 0;
                for (Producto p : carrito) {
                    float subtotal = p.getPrecio() * p.getCantidad();
                    total += subtotal;
            %>
            <tr>
                <td><%= p.getDescripcion() %></td>
                <td><img src="<%= p.getImagen() %>" width="50" /></td>
                <td><%= p.getPrecio() %> €</td>
                <td><%= p.getCantidad() %></td>
                <td><%= subtotal %> €</td>
            </tr>
            <% } %>
        </table>
        <p><strong>Total: <%= total %> €</strong></p>

        <input type="submit" value="Tramitar pedido" />
        <button type="button" onclick="window.location.href='carrito.jsp'">Cancelar</button>
    </form>

    <script>
        // Puedes llamar aquí a tu función de vaciado del carrito si se confirma el pedido desde el Servlet Tramitacion
    </script>
</body>
</html>
