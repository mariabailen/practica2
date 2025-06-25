package tienda;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("loginUsuario.jsp");
            return;
        }

        String usuario = (String) session.getAttribute("usuario");
        Usuario u = AccesoBD.getInstance().obtenerDatosUsuario(usuario);
        request.setAttribute("usuarioDatos", u);

        RequestDispatcher rd = request.getRequestDispatcher("perfil.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("loginUsuario.jsp");
            return;
        }

        // Recogemos el código del usuario en sesión
        int codigo = (int) session.getAttribute("codigo");

        // Creamos el objeto Usuario con los nuevos datos
        Usuario u = new Usuario();
        u.setCodigo(codigo);
        u.setNombre(request.getParameter("nombre"));
        u.setDomicilio(request.getParameter("domicilio"));
        u.setCp(request.getParameter("cp"));
        u.setPoblacion(request.getParameter("poblacion"));
        u.setProvincia(request.getParameter("provincia"));
        u.setTelefono(request.getParameter("telefono"));

        // Intentamos actualizar en BD
        boolean ok = AccesoBD.getInstance().actualizarDatosUsuario(u);
        if (ok) {
            request.setAttribute("mensaje", "Datos actualizados correctamente.");
        } else {
            request.setAttribute("mensaje", "Error al actualizar los datos.");
        }

        // Volvemos a cargar el usuario (podrías recargar de BD o usar el mismo 'u')
        request.setAttribute("usuarioDatos", u);
        RequestDispatcher rd = request.getRequestDispatcher("perfil.jsp");
        rd.forward(request, response);
    }
}
