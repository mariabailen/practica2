package tienda;

public class ProductoBD{
	public int getCodigo() {
        return codigo;
    }
    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }
    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public float getPrecio() {
        return precio;
    }
    public void setPrecio(float precio) {
        this.precio = precio;
    }
    public int getExistencias() {
        return existencias;
    }
    public void setExistencias(int existencias) {
        this.existencias = existencias;
    }
    public String getImagen() {
        return imagen;
    }
    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    private int codigo;
	private String descripcion;
	private float precio;
	private int existencias;
	private String imagen;
    
	
}