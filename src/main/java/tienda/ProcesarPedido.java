package tienda;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import jakarta.json.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ProcesarPedido extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("compra.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Comprobar sesión de usuario
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("codigo") == null) {
            response.sendRedirect("loginUsuario.jsp?url=compra.jsp");
            return;
        }
        int codigoUsuario = (int) session.getAttribute("codigo");
        // Leer el JSON del carrito desde form-data (campo oculto)
        String carritoJSON = request.getParameter("carritoJSON");
        List<Producto> carrito = new ArrayList<>();
        if (carritoJSON != null && !carritoJSON.isBlank()) {
            try (JsonReader jr = Json.createReader(new StringReader(carritoJSON))) {
                JsonArray arr = jr.readArray();
                for (JsonObject obj : arr.getValuesAs(JsonObject.class)) {
                    Producto p = new Producto();
                    p.setCodigo(Integer.parseInt(obj.getString("codigo")));
                    p.setDescripcion(obj.getString("descripcion"));
                    p.setPrecio(Float.parseFloat(obj.getString("precio")));
                    p.setCantidad(obj.getInt("cantidad"));
                    carrito.add(p);
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("mensaje", "Error procesando el carrito.");
                response.sendRedirect("compra.jsp");
                return;
            }
        }
        // Validar carrito no vacío
        if (carrito.isEmpty()) {
            session.setAttribute("mensaje", "Tu carrito está vacío.");
            response.sendRedirect("compra.jsp");
            return;
        }

        // Guardar pedido en BD con estado = 0 (pendiente)
        boolean exito = AccesoBD.getInstance().guardarPedido(codigoUsuario, new ArrayList<>(carrito), 3);
        if (exito) {
            session.removeAttribute("carritoJSON");
            response.sendRedirect("gracias.jsp");
        } else {
            session.setAttribute("mensaje", "Error al procesar tu pedido. Intenta de nuevo.");
            response.sendRedirect("compra.jsp");
        }
    }
}

