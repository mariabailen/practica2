package tienda;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/pedidos")
public class PedidosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("codigo") == null) {
            response.sendRedirect("loginUsuario.jsp");
            return;
        }
        int codigoUsuario = (int) session.getAttribute("codigo");
        // Aquí usas tu AccesoBD, NO PedidoDAO
        List<Pedido> pedidos = AccesoBD.getInstance().obtenerPedidosUsuario(codigoUsuario);
        request.setAttribute("listaPedidos", pedidos);
        request.getRequestDispatcher("pedidos.jsp").forward(request, response);
    }
}
