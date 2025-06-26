package tienda;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ModificarClave", urlPatterns = {"/ModificarClave"})
public class ModificarClave extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = (String) request.getSession().getAttribute("usuario");

        String nuevaClave = request.getParameter("nuevaClave");
        String confirmarClave = request.getParameter("confirmarClave");

        if (!nuevaClave.equals(confirmarClave)) {
            request.setAttribute("mensaje", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("perfil.jsp").forward(request, response);
            return;
        }

        AccesoBD db = AccesoBD.getInstance();
        boolean cambiada = db.actualizarClaveUsuario(usuario, nuevaClave);

        if (cambiada) {
            request.setAttribute("mensaje", "Contraseña cambiada correctamente.");
        } else {
            request.setAttribute("mensaje", "Error al cambiar la contraseña.");
        }

        request.getRequestDispatcher("perfil.jsp").forward(request, response);
    }
}
