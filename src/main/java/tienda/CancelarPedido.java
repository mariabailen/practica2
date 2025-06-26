//Este servlet comprueba que el usuario esta autenticado, y recoge el codigo del pedido desde el formulario,
//intenta cancelarlo llamando a la base de datos, y después vuelve pedidos.jsp con un mensaje  error.
package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CancelarPedido extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtenemos la sesión y comprobamos que el usuario esté logueado
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("loginUsuario.jsp?url=pedidos.jsp");
            return;
        }

        try {
            int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
            AccesoBD db = AccesoBD.getInstance();

            boolean cancelado = db.cancelarPedido(codigoPedido);

            if (cancelado) {
                request.setAttribute("mensaje", "El pedido ha sido cancelado correctamente.");
            } else {
                request.setAttribute("mensaje", "No se pudo cancelar el pedido. Asegúrate de que está en estado pendiente.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al cancelar el pedido.");
        }

        // Redirecciona de nuevo a la página de mis pedidos
        request.getRequestDispatcher("pedidos.jsp").forward(request, response);
    }
}