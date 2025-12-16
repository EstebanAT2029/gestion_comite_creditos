/* ============================================================
   REPORTES — Listado dinámico + Exportación Excel
============================================================ */

document.addEventListener("DOMContentLoaded", () => {

    console.log("✔ reportes.js cargado");

    const tabla = document.getElementById("tbodyReporte");

    document.getElementById("btnBuscar").addEventListener("click", buscar);

    function buscar() {

        const filtros = {
            tipo: document.getElementById("tipo").value,
            agencia: document.getElementById("agencia").value,
            usuario: document.getElementById("usuario").value,
            fecha_desde: document.getElementById("desde").value,
            fecha_hasta: document.getElementById("hasta").value
        };

        fetch("index.php?url=reportes/listar", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(filtros)
        })
        .then(r => r.json())
        .then(resp => {

            tabla.innerHTML = "";

            if (!resp.data.length) {
                tabla.innerHTML = `<tr><td colspan="8" class="text-center text-muted">
                    No hay resultados
                </td></tr>`;
                return;
            }

            resp.data.forEach((r, i) => {
                tabla.innerHTML += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${r.cadena}</td>
                        <td>${r.agencia}</td>
                        <td>${r.dni}</td>
                        <td>${r.cliente}</td>
                        <td>${r.monto}</td>
                        <td>${r.fecha}</td>
                        <td>${r.resolucion}</td>
                    </tr>`;
            });
        });
    }

    /* ------------------------------------------------------------
       EXPORTAR A EXCEL
    ------------------------------------------------------------ */
    document.getElementById("btnExcel").addEventListener("click", () => {

        const params = new URLSearchParams({
            tipo: document.getElementById("tipo").value,
            agencia: document.getElementById("agencia").value,
            usuario: document.getElementById("usuario").value,
            fecha_desde: document.getElementById("desde").value,
            fecha_hasta: document.getElementById("hasta").value
        });

        window.location = "index.php?url=reportes/excel&" + params.toString();
    });

});