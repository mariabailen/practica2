package tienda;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class Registro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recoger los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String domicilio = request.getParameter("domicilio");
        String cp = request.getParameter("cp");
        String poblacion = request.getParameter("poblacion");
        String provincia = request.getParameter("provincia");
        String telefono = request.getParameter("telefono");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String confirmarClave = request.getParameter("confirmarClave");

        

        // Validaciones para rellenar el formulario
        String mensaje = null;

        if (nombre == null || nombre.isEmpty() ||
        domicilio == null || domicilio.isEmpty() ||
        cp == null || cp.isEmpty() ||
        poblacion == null || poblacion.isEmpty() ||
        provincia == null || provincia.isEmpty() ||
        usuario == null || usuario.isEmpty() ||
        clave == null || clave.isEmpty() ||
        confirmarClave == null || confirmarClave.isEmpty())
     {

            mensaje = "⚠️ Todos los campos son obligatorios.";
        } else if (!clave.equals(confirmarClave)) {
            mensaje = "⚠️ Las contraseñas no coinciden.";
        }

        if (mensaje != null) {
            // Guardamos el mensaje en la sesión y volvemos al formulario
            HttpSession session = request.getSession();
            session.setAttribute("mensajeRegistro", mensaje);
            request.getRequestDispatcher("registroUsuario.jsp").forward(request, response);
            return;
        }

        // Insertamos en la base de datos
        
        AccesoBD db = AccesoBD.getInstance();
        boolean exito = db.insertarUsuario(nombre, apellidos, domicilio, cp, poblacion, provincia, telefono, usuario, clave);

        if (exito) {
            // Registro correcto: enviamos al login
            response.sendRedirect("loginUsuario.jsp");
        } else {
            // Algo ha fallado: mostramos mensaje de error
            HttpSession session = request.getSession();
            session.setAttribute("mensajeRegistro", "❌ Error: no se ha podido registrar el usuario.");
            request.getRequestDispatcher("registroUsuario.jsp").forward(request, response);
        }
    }
}