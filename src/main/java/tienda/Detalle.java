package tienda;

public class Detalle {
    private String descripcion;
    private double precio;
    private int cantidad;

    public Detalle(String descripcion, double precio, int cantidad) {
        this.descripcion = descripcion;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public int getCantidad() {
        return cantidad;
    }
}
