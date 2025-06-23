package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String urlDestino = request.getParameter("url"); 

        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();

        if ((usuario != null) && (clave != null)) {
            int codigo = con.comprobarUsuarioBD(usuario, clave);
            if (codigo > 0) {
                session.setAttribute("codigo", codigo);
                session.setAttribute("usuario", usuario); 
                

                // Si no se ha especificado URL, vamos a productos.jsp por defecto
                if (urlDestino == null || urlDestino.isEmpty()) {
                    urlDestino = "productos.jsp";
                }

                response.sendRedirect(urlDestino);
                return;
            } else {
                session.setAttribute("mensaje", "Usuario y/o clave incorrectos");
            }
        }

        // Si algo va mal, volvemos al login
        response.sendRedirect("loginUsuario.jsp");
    }
}
