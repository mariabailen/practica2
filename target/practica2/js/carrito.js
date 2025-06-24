class ProductoCarrito {
    constructor(codigo, descripcion, imagen, cantidad, precio, existencias) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.cantidad = cantidad;
        this.precio = precio;
        this.existencias = existencias;
    }
}

// Recuperar el carrito desde localStorage (si existe) y mapearlo a objetos ProductoCarrito
let carrito = (JSON.parse(localStorage.getItem("mi-carrito-almacenado")) || []).map(p => {
    return new ProductoCarrito(p.codigo, p.descripcion, p.imagen, p.cantidad, p.precio, p.existencias);
});

// Función para guardar el carrito actualizado en localStorage
function guardarCarrito() {
    localStorage.setItem("mi-carrito-almacenado", JSON.stringify(carrito));
}

// Función para añadir un producto al carrito
function anadirCarrito(codigo, descripcion, imagen, cantidad, precio, existencias) {
    let producto = carrito.find(p => p.codigo === codigo);

    if (producto) {
        if (producto.cantidad < producto.existencias) {
            producto.cantidad++;
        } else {
            alert("No hay más stock disponible de este producto.");
            return;
        }
    } else {
        carrito.push(new ProductoCarrito(codigo, descripcion, imagen, cantidad, precio, existencias));
    }

    guardarCarrito();
    alert("Producto añadido al carrito");
}

// Función para eliminar un producto del carrito
function eliminarProducto(index) {
    carrito.splice(index, 1);
    guardarCarrito();
    mostrarCarrito();
}
window.eliminarProducto = eliminarProducto;

// Función para vaciar el carrito
function vaciarCarrito() {
    carrito = [];
    guardarCarrito();
    mostrarCarrito();
}
window.vaciarCarrito = vaciarCarrito;

// Función para incrementar la cantidad de un producto
function incrementarCantidad(index) {
    if (carrito[index].cantidad < carrito[index].existencias) {
        carrito[index].cantidad++;
        guardarCarrito();
        mostrarCarrito();
    } else {
        alert("No hay más stock disponible de este producto.");
    }
}
window.incrementarCantidad = incrementarCantidad;

// Función para disminuir la cantidad de un producto
function disminuirCantidad(index) {
    carrito[index].cantidad--;
    if (carrito[index].cantidad <= 0) {
        carrito.splice(index, 1);
    }
    guardarCarrito();
    mostrarCarrito();
}
window.disminuirCantidad = disminuirCantidad;

// Función para mostrar el carrito en la página
function mostrarCarrito() {
    console.log("Mostrando carrito con", carrito.length, "productos");

    let tabla = document.getElementById("carritoBody");

    if (!tabla) {
        console.error("El elemento con id 'carritoBody' no se encontró.");
        return;
    }

    tabla.innerHTML = ""; // Limpiar tabla

    if (carrito.length === 0) {
        tabla.innerHTML = "<tr><td colspan='6' class='text-center'>El carrito está vacío.</td></tr>";
        return;
    }

    let totalFinal = 0;
    carrito.forEach((producto, index) => {
        let total = parseFloat(producto.precio) * producto.cantidad;
        totalFinal += total;

        tabla.innerHTML += `
            <tr>
                <td>${producto.descripcion}</td>
                <td>${parseFloat(producto.precio).toFixed(2)} €</td>
                <td><img src="img/${producto.imagen}" alt="${producto.descripcion}" style="width: 80px;"></td>
                <td>
                    <button class="btn btn-sm btn-outline-secondary me-1" onclick="disminuirCantidad(${index})">&minus</button>
                    ${producto.cantidad}
                    <button class="btn btn-sm btn-outline-secondary ms-1" onclick="incrementarCantidad(${index})">&plus;</button>
                </td>
                <td>${total.toFixed(2)} €</td>
                <td>
                    <button class="btn btn-sm btn-danger" onclick="eliminarProducto(${index})">Eliminar</button>
                </td>
            </tr>
        `;
    });

    tabla.innerHTML += `
        <tr>
            <td colspan="4"><strong>Total:</strong></td>
            <td colspan="2"><strong>${totalFinal.toFixed(2)} €</strong></td>
        </tr>
    `;
}

// Función para enviar el carrito al servidor
function EnviarCarrito(urlServlet) {
    if (carrito.length === 0) {
        alert("Tu carrito está vacío.");
        return;
    }

    let carritoJSON = JSON.stringify(carrito);

    let form = document.createElement("form");
    form.method = "POST";
    form.action = urlServlet;

    let campoOculto = document.createElement("input");
    campoOculto.type = "hidden";
    campoOculto.name = "carritoJSON";
    campoOculto.value = carritoJSON;

    form.appendChild(campoOculto);
    document.body.appendChild(form);
    form.submit();
}
window.EnviarCarrito = EnviarCarrito;

// Mostrar carrito al cargar página
document.addEventListener('DOMContentLoaded', mostrarCarrito);
