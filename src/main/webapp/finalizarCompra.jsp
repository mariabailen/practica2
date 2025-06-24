<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8"%>
<%
    String usuario = (String) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("loginUsuario.jsp");
    } else {
        response.sendRedirect("compra.jsp");
    }
%>
