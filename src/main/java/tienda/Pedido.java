package tienda;
import java.util.Date;

public class Pedido {
    private int codigo;
    private Date fecha;
    private double importe;
    private int estado;

    public int getCodigo() { return codigo; }
    public void setCodigo(int codigo) { this.codigo = codigo; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public double getImporte() { return importe; }
    public void setImporte(double importe) { this.importe = importe; }

    public int getEstado() { return estado; }
    public void setEstado(int estado) { this.estado = estado; }
    public String getEstadoDescripcion() {
        switch (estado) {
            case 1: return "Enviado";
            case 2: return "Entregado";
            case 3: return "Pendiente";
            case 4: return "Cancelado";
            default: return "Desconocido";
        }
    }
}