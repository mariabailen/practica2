package tienda;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import jakarta.json.*;
import java.io.InputStreamReader;

public class ProcesarPedido extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        HttpSession sesion = request.getSession(true);

        // ... falta código de declaración de variables

        if (sesion.getAttribute("carritoJSON") != null) {
            sesion.removeAttribute("carritoJSON");
        }

        ArrayList <Producto> carritoJSON = new ArrayList<Producto>();
        AccesoBD con = AccesoBD.getInstance();

        JsonReader jsonReader = Json.createReader(
                new InputStreamReader(
                        request.getInputStream(), "utf-8"));

        JsonArray jobj = jsonReader.readArray();

        for (int i = 0; i < jobj.size(); i++) {

            JsonObject prod = jobj.getJsonObject(i);
            Producto nuevo = new Producto();

            nuevo.setCodigo(prod.getInt("codigo"));
            nuevo.setDescripcion(prod.getString("descripcion"));
            nuevo.setImagen(prod.getString("imagen"));
            nuevo.setPrecio(Float.parseFloat(prod.get("precio").toString()));

            int cantidad = prod.getInt("cantidad");
            int existencias = con.obtenerExistencias(nuevo.getCodigo());

            if (cantidad > existencias) {
                cantidad = existencias;
            }
            if (cantidad > 0) {
                nuevo.setCantidad(cantidad);
                carritoJSON.add(nuevo);
            }
        }

        if (carritoJSON.size() > 0) {
            sesion.setAttribute("carritoJSON", carritoJSON);
        }

         // ... falta código

        RequestDispatcher rd = request.getRequestDispatcher("resguardo.jsp");
        rd.forward(request, response);
    }
}