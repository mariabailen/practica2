package tienda;

import java.io.IOException;
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
                    System.out.println(">>> ProcesarPedido.doPost INVOKED <<<");

        HttpSession sesion = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();

        // 1. Si viene JSON (actualización de carrito desde JS)
        if ("application/json".equalsIgnoreCase(request.getContentType())) {
            try (JsonReader jr = Json.createReader(request.getInputStream())) {
                JsonArray arr = jr.readArray();
                ArrayList<Producto> carritoJSON = new ArrayList<>();

                for (JsonValue v : arr) {
                    JsonObject prod = (JsonObject) v;
                    Producto p = new Producto();
                    p.setCodigo(prod.getInt("codigo"));
                    p.setDescripcion(prod.getString("descripcion"));
                    p.setImagen(prod.getString("imagen"));
                    p.setPrecio(Float.parseFloat(prod.get("precio").toString()));
                    int cantidad = prod.getInt("cantidad");
                    int exist = con.obtenerExistencias(p.getCodigo());
                    if (cantidad > exist) cantidad = exist;
                    if (cantidad > 0) {
                        p.setCantidad(cantidad);
                        carritoJSON.add(p);
                    }
                }

                if (!carritoJSON.isEmpty()) {
                    sesion.setAttribute("carritoJSON", carritoJSON);
                }
                response.setStatus(HttpServletResponse.SC_OK);
                return;
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "JSON mal formado");
                return;
            }
        }

        // 2. Procesar pedido desde el formulario
        @SuppressWarnings("unchecked")
        List<Producto> carrito = (List<Producto>) sesion.getAttribute("carritoJSON");
        if (carrito == null || carrito.isEmpty()) {
            request.setAttribute("error", "El carrito está vacío.");
            forwardTo(response, request, "compra.jsp");
            return;
        }

        Integer codigoUsuario = (Integer) sesion.getAttribute("codigoUsuario");
        if (codigoUsuario == null || codigoUsuario == 0) {
            request.setAttribute("error", "Debes iniciar sesión para continuar.");
            forwardTo(response, request, "loginUsuario.jsp?url=compra.jsp");
            return;
        }

        // Llamamos a guardarPedido con estado = 1 (nuevo pedido)
        ArrayList<Producto> carritoCOP = new ArrayList<>(carrito);
        boolean exito = con.guardarPedido(codigoUsuario, carritoCOP, 1);
            System.out.println(">>> ProcesarPedido.doPost INVOKED <<<");

        if (exito) {
            sesion.removeAttribute("carritoJSON");
            response.sendRedirect("gracias.jsp");
        } else {
            request.setAttribute("error", "Error al procesar el pedido. Inténtalo de nuevo.");
            forwardTo(response, request, "compra.jsp");
        }
    }

    private void forwardTo(HttpServletResponse resp, HttpServletRequest req, String jsp)
            throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher(jsp);
        rd.forward(req, resp);
    }
}
