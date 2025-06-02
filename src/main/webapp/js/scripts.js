document.addEventListener("DOMContentLoaded", function() {
    const header = `
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="../index.html">MAKE UP WAPA</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="../index.html">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="../empresa.html">Empresa</a></li>
                        <li class="nav-item"><a class="nav-link" href="../contacto.html">Contacto</a></li>
                        <li class="nav-item"><a class="nav-link" href="../productos.html">Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="../carrito.html">Carrito</a></li>
                        <li class="nav-item"><a class="nav-link" href="../admin/productos.html">Administración</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    `;
    document.getElementById("header").innerHTML = header;
});
