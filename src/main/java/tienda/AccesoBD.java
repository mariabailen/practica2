package tienda;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public final class AccesoBD {
	private static AccesoBD instanciaUnica = null;
	private Connection conexionBD = null;

	public static AccesoBD getInstance(){
		if (instanciaUnica == null){
			instanciaUnica = new AccesoBD();
		}
		return instanciaUnica;
	}

	private AccesoBD() {
		abrirConexionBD();
	}

	public void abrirConexionBD() {
		if (conexionBD == null)
		{
			String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
			String DB_URL = "jdbc:mariadb://localhost:3306/daw";

			String USER = "root";
			String PASS = "DawLab";
			try {
				Class.forName(JDBC_DRIVER);
				conexionBD = DriverManager.getConnection(DB_URL,USER,PASS);
			}
			catch(Exception e) {
				System.err.println("No se ha podido conectar a la base de datos");
				System.err.println(e.getMessage());
                e.printStackTrace();
			}
		}
	}

	public boolean comprobarAcceso() {
		abrirConexionBD();
		return (conexionBD != null);
	}

    public List<ProductoBD> obtenerProductosBD() {
	ArrayList<ProductoBD> productos = new ArrayList<>();

	try {
		String query = "SELECT codigo,descripcion,precio,existencias,imagen FROM productos";  
		PreparedStatement s = conexionBD.prepareStatement(query);
		//s.setInt(1,0);
		ResultSet resultado = s.executeQuery();
		while(resultado.next()){
			ProductoBD producto = new ProductoBD();
			producto.setCodigo(resultado.getInt("codigo"));
			producto.setDescripcion(resultado.getString("descripcion"));
			producto.setPrecio(resultado.getFloat("precio"));
			producto.setExistencias(resultado.getInt("existencias"));
			producto.setImagen(resultado.getString("imagen"));
			productos.add(producto);
		}
	} catch(Exception e) {
		System.err.println("Error ejecutando la consulta a la base de datos");
		System.err.println(e.getMessage());
	}
	return productos;
}
public int comprobarUsuarioBD(String usuario, String clave) {
    abrirConexionBD();
    int codigo = -1;

    try {
        String query = "SELECT codigo FROM usuarios WHERE usuario = ? AND clave = ?";
        PreparedStatement ps = conexionBD.prepareStatement(query);
        ps.setString(1, usuario);
        ps.setString(2, clave);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            codigo = rs.getInt("codigo");
        }

        rs.close();
        ps.close();
    } catch (SQLException e) {
        System.err.println("Error al comprobar el usuario en la base de datos");
        System.err.println(e.getMessage());
    }

    return codigo;
}

public boolean registrarUsuario(String usuario, String password, String mail, String telefono) {
    try {
        String sql = "INSERT INTO usuarios (usuario, clave, email, telefono) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conexionBD.prepareStatement(sql);
        stmt.setString(1, usuario);
        stmt.setString(2, password);
        stmt.setString(3, mail);
        stmt.setString(4, telefono);
        int filasInsertadas = stmt.executeUpdate();
        return filasInsertadas > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

public int obtenerExistencias(int codigoProducto) {
    int existencias = 0;
    try {
        String sql = "SELECT existencias FROM productos WHERE codigo = ?";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setInt(1, codigoProducto);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            existencias = rs.getInt("existencias");
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return existencias;
}
public boolean insertarUsuario(String nombre, String apellidos, String domicilio, String cp, String poblacion, String provincia, String telefono, String usuario, String clave) {
    boolean exito = false;
    try {
        String sql = "INSERT INTO usuarios (nombre, apellidos, domicilio, cp, poblacion, provincia, telefono, usuario, clave, activo, admin) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1, 0)";  

        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setString(1, nombre);
        ps.setString(2, apellidos);
        ps.setString(3, domicilio);
        ps.setString(4, cp);
        ps.setString(5, poblacion);
        ps.setString(6, provincia);
        ps.setString(7, telefono);
        ps.setString(8, usuario);
        ps.setString(9, clave);

        int filas = ps.executeUpdate();
        if (filas > 0) {
            exito = true;
        }
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return exito;
}
public Usuario obtenerDatosUsuario(String usuario) {
    Usuario u = null;
    try {
        String sql = "SELECT * FROM usuarios WHERE usuario = ?";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setString(1, usuario);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            u = new Usuario();
            u.setCodigo(rs.getInt("codigo")); 
            u.setNombre(rs.getString("nombre"));
            u.setDomicilio(rs.getString("domicilio"));
            u.setCp(rs.getString("cp"));
            u.setPoblacion(rs.getString("poblacion"));
            u.setProvincia(rs.getString("provincia"));
			u.setTelefono(rs.getString("telefono"));
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return u;
}

public boolean guardarPedido(int codigoUsuario, ArrayList<Producto> carrito, int estado) {
    boolean exito = false;
    System.out.println("Entro guardar pedido");

    try {
        abrirConexionBD();
        conexionBD.setAutoCommit(false); // Inicio de transacción

        // Calcular importe total
        double importeTotal = 0;
        for (Producto p : carrito) {
            importeTotal += p.getPrecio() * p.getCantidad();
        }

        // Insertar pedido
        String sqlPedido = "INSERT INTO pedidos (persona, importe, estado) VALUES (?, ?, ?)";
        PreparedStatement psPedido = conexionBD.prepareStatement(sqlPedido, PreparedStatement.RETURN_GENERATED_KEYS);
        psPedido.setInt(1, codigoUsuario);
        psPedido.setDouble(2, importeTotal);
        psPedido.setInt(3, estado);
        int filas = psPedido.executeUpdate();

        if (filas == 0) {
            conexionBD.rollback();
            return false;
        }

        // Obtener código del pedido generado
        ResultSet rsKeys = psPedido.getGeneratedKeys();
        int codigoPedido = -1;
        if (rsKeys.next()) {
            codigoPedido = rsKeys.getInt(1);
        } else {
            conexionBD.rollback();
            return false;
        }
        rsKeys.close();
        psPedido.close();

        // Insertar detalles
        String sqlDetalle = "INSERT INTO detalle (codigo_pedido, codigo_producto, unidades, precio_unitario) VALUES (?, ?, ?, ?)";
        PreparedStatement psDetalle = conexionBD.prepareStatement(sqlDetalle);
        for (Producto p : carrito) {
            psDetalle.setInt(1, codigoPedido);
            psDetalle.setInt(2, p.getCodigo());
            psDetalle.setInt(3, p.getCantidad());
            psDetalle.setDouble(4, p.getPrecio());
            psDetalle.addBatch();
        }
        psDetalle.executeBatch();
        psDetalle.close();

        conexionBD.commit(); // Confirmar transacción
        exito = true;
    } catch (Exception e) {
        try {
            conexionBD.rollback();
            System.out.println(e.getMessage());
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println(e.getMessage());
        }
        e.printStackTrace();
        System.out.println(e.getMessage());
        exito = false;
    } finally {
        try {
            conexionBD.setAutoCommit(true);
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }
    }
    System.out.println("Exito: " + exito);
    return exito;
}
public boolean actualizarDatosUsuario(Usuario u) {
    try {
        String sql = "UPDATE usuarios "
                   + "SET nombre = ?, domicilio = ?, cp = ?, poblacion = ?, provincia = ?, telefono = ? "
                   + "WHERE codigo = ?";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setString(1, u.getNombre());
        ps.setString(2, u.getDomicilio());
        ps.setString(3, u.getCp());
        ps.setString(4, u.getPoblacion());
        ps.setString(5, u.getProvincia());
        ps.setString(6, u.getTelefono());
        ps.setInt(7, u.getCodigo());
        int filas = ps.executeUpdate();
        ps.close();
        return filas > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
/**
 * Devuelve la lista de pedidos realizados por un usuario.
 */
public List<Pedido> obtenerPedidosUsuario(int codigoUsuario) {
    List<Pedido> lista = new ArrayList<>();
    try {
        String sql = "SELECT codigo, fecha, importe, estado FROM pedidos WHERE persona = ? ORDER BY fecha DESC";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setInt(1, codigoUsuario);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Pedido p = new Pedido();
            p.setCodigo(rs.getInt("codigo"));
            p.setFecha(rs.getTimestamp("fecha"));
            p.setImporte(rs.getDouble("importe"));
            p.setEstado(rs.getInt("estado"));
            lista.add(p);
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}
public boolean cancelarPedido(int codigoPedido) {
    abrirConexionBD();
    boolean exito = false;
    String sql = "UPDATE pedidos SET estado = 4 WHERE codigo = ? AND estado = 3";  // 4 = Cancelado, 1 = Pendiente

    try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
        ps.setInt(1, codigoPedido);
        int filas = ps.executeUpdate();
        exito = filas > 0;
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return exito;
}
public void insertarDetallePedido(int codigoPedido, int codigoProducto, int cantidad, float precioUnitario) {
    String sql = "INSERT INTO detalle (codigo_pedido, codigo_producto, unidades, precio_unitario) VALUES (?, ?, ?, ?)";

    try {
        PreparedStatement pstmt = conexionBD.prepareStatement(sql);
        pstmt.setInt(1, codigoPedido);
        pstmt.setInt(2, codigoProducto);
        pstmt.setInt(3, cantidad);
        pstmt.setFloat(4, precioUnitario);
    
        pstmt.executeUpdate();
        pstmt.close();
    
    } catch (SQLException e) {
        System.err.println("Detalle insertado para pedido " + codigoPedido + ", producto " + codigoProducto);
        e.printStackTrace();
    }
}
public List<Detalle> obtenerDetallesPedido(int codigoPedido) {
    List<Detalle> lista = new ArrayList<>();
    String sql = "SELECT p.descripcion, d.precio_unitario, d.unidades FROM detalle d JOIN productos p ON d.codigo_producto = p.codigo WHERE d.codigo_pedido = " + codigoPedido;

    try (Statement st = conexionBD.createStatement();
         ResultSet rs = st.executeQuery(sql)) {

        while (rs.next()) {
            Detalle d = new Detalle(
                rs.getString("descripcion"),
                rs.getDouble("precio_unitario"),
                rs.getInt("unidades")
            );
            lista.add(d);
        }
    } catch (SQLException e) {
        System.err.println(sql);
        e.printStackTrace();
    }
    return lista;
}
public boolean actualizarClaveUsuario(String usuario, String nuevaClave) {
    try {
        String sql = "UPDATE usuarios SET clave = ? WHERE usuario = ?";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setString(1, nuevaClave);
        ps.setString(2, usuario);
        int filas = ps.executeUpdate();
        ps.close();
        return filas > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}




}
