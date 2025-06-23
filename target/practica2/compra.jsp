<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Compra - MAKE UP WAPA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .table th, .table td {
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center">Datos del Usuario</h2>
    <div class="alert alert-info">
        <p><strong>Nombre:</strong> <%= usuario.getNombre() %></p>
        <p><strong>Domicilio:</strong> <%= usuario.getDomicilio() %></p>
        <p><strong>Código Postal:</strong> <%= usuario.getCp() %></p>
        <p><strong>Población:</strong> <%= usuario.getPoblacion() %></p>
        <p><strong>Provincia:</strong> <%= usuario.getProvincia() %></p>
        <p><strong>Teléfono:</strong> <%= usuario.getTelefono() %></p>
    </div>

    <h2 class="text-center">Ticket de Compra</h2>
    <table class="table table-bordered">
        <thead class="thead-dark">
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <%
                double total = 0;
                for (Producto p : carrito) {
                    double subtotal = p.getPrecio() * p.getCantidad();
                    total += subtotal;
            %>
            <tr>
                <td><%= p.getCodigo() %></td>
                <td><%= p.getCantidad() %></td>
                <td><%= String.format("%.2f", p.getPrecio()) %> €</td>
                <td><%= String.format("%.2f", subtotal) %> €</td>
            </tr>
            <% } %>
            <tr>
                <th colspan="3">Total</th>
                <th><%= String.format("%.2f", total) %> €</th>
            </tr>
        </tbody>
    </table>

    <h2 class="text-center">Método de Pago</h2>
    <form action="FinalizarPago" method="post" class="text-center">
        <div class="mb-3">
            <label for="metodoPago" class="form-label">Seleccione Método de Pago:</label>
            <select id="metodoPago" name="metodoPago" class="form-select" required>
                <option value="">Seleccione</option>
                <option value="tarjeta">Tarjeta</option>
                <option value="paypal">PayPal</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Confirmar
