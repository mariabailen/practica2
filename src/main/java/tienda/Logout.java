package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Logout extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la sesión actual
        HttpSession session = request.getSession(false); // No crea una nueva sesión si no existe

        if (session != null) {
            // Invalidar la sesión (cerrar sesión)
            session.invalidate();
        }

        // Redirigir al usuario a la página principal o donde quieras
        response.sendRedirect("loginUsuario.jsp"); 
    }
}
