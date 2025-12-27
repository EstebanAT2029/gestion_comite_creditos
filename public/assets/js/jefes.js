document.addEventListener("DOMContentLoaded", () => {

    /* ======================================================
       CARGAR AGENCIAS DEL USUARIO LOGUEADO (id_zona)
       PARA EL MODAL DE REGISTRO
    ====================================================== */
    fetch("index.php?url=api/agencias")
        .then(r => r.json())
        .then(data => {
            let agenciaModal = document.getElementById("agenciaModal");

            agenciaModal.innerHTML = `<option value="">Seleccione</option>`;

            data.forEach(a => {
                agenciaModal.innerHTML += `
                    <option value="${a.id}">${a.nombre_agencia}</option>
                `;
            });
        });


    /* ======================================================
       GUARDAR NUEVO JEFE
    ====================================================== */
    document.getElementById("btnGuardarJefe").addEventListener("click", () => {

        const apellidos = document.getElementById("apellidos").value.trim();
        const nombres = document.getElementById("nombres").value.trim();
        const id_agencia = document.getElementById("agenciaModal").value;

        if (!apellidos || !nombres || !id_agencia) {
            alert("⚠ Debe completar todos los campos.");
            return;
        }

        const data = new FormData();
        data.append("apellidos", apellidos);
        data.append("nombres", nombres);
        data.append("id_agencia", id_agencia);

        fetch("index.php?url=jefes/save", {
            method: "POST",
            body: data
        })
        .then(() => location.reload());
    });

});


/* ======================================================
   ELIMINAR JEFE
====================================================== */
function eliminarJefe(id) {

    if (!confirm("¿Eliminar este Jefe?")) return;

    fetch("index.php?url=jefes/delete", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "id=" + id
    })
    .then(r => r.json())
    .then(resp => {
        if (resp.success) location.reload();
        else customAlert("❌ Error eliminando el registro");
    });
}