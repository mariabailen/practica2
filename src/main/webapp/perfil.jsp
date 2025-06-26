<%@page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) request.getAttribute("usuarioDatos");
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar aquí -->
    <div class="container mt-5">
        <h2>Mi Perfil</h2>
        <% if (mensaje != null) { %>
            <div class="alert alert-info"><%= mensaje %></div>
        <% } %>
        <form action="perfil" method="post" class="shadow p-4 rounded bg-light">
            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text"
                       name="nombre"
                       class="form-control"
                       value="<%= user != null ? user.getNombre() : "" %>"
                       readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">Domicilio</label>
                <input type="text" name="domicilio" class="form-control"
                       value="<%= user != null ? user.getDomicilio() : "" %>">
            </div>
            <div class="mb-3">
                <label class="form-label">Código Postal</label>
                <input type="text" name="cp" class="form-control"
                       value="<%= user != null ? user.getCp() : "" %>">
            </div>
            <div class="mb-3">
                <label class="form-label">Población</label>
                <input type="text" name="poblacion" class="form-control"
                       value="<%= user != null ? user.getPoblacion() : "" %>">
            </div>
            <div class="mb-3">
                <label class="form-label">Provincia</label>
                <input type="text" name="provincia" class="form-control"
                       value="<%= user != null ? user.getProvincia() : "" %>">
            </div>
            <div class="mb-3">
                <label class="form-label">Teléfono</label>
                <input type="text" name="telefono" class="form-control"
                       value="<%= user != null ? user.getTelefono() : "" %>">
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Guardar cambios</button>
                <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancelar</button>
                <a href="pedidos" class="btn btn-info">Ver pedidos</a>
            </div>
        </form>
    </div>
</body>
</html>
