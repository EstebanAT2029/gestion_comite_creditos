/* ======================================================
   CARGAR AGENCIAS SEGÚN ZONA DEL USUARIO (API segura)
====================================================== */
document.addEventListener("DOMContentLoaded", () => {

    // Estos combos ya NO dependen de zona seleccionada
    const agenciaSelect = document.getElementById("agencia");
    const agenciaModal = document.getElementById("agenciaModal");

    /* ======================================================
       CARGAR AGENCIAS EN FORMULARIO Y MODAL
       (SE FILTRAN AUTOMÁTICAMENTE SEGÚN ZONA DEL USUARIO)
    ====================================================== */
    fetch("index.php?url=api/agencias")
        .then(r => r.json())
        .then(data => {

            // 🟦 Para el filtro de la lista
            if (agenciaSelect) {
                agenciaSelect.innerHTML = `<option value="">Seleccione agencia</option>`;
                data.forEach(a => {
                    agenciaSelect.innerHTML += `
                        <option value="${a.id}">${a.nombre_agencia}</option>
                    `;
                });
            }

            // 🟩 Para el modal registrar oficial
            if (agenciaModal) {
                agenciaModal.innerHTML = `<option value="">Seleccione agencia</option>`;
                data.forEach(a => {
                    agenciaModal.innerHTML += `
                        <option value="${a.id}">${a.nombre_agencia}</option>
                    `;
                });
            }
        });

    /* ======================================================
       GUARDAR NUEVO OFICIAL
    ====================================================== */
    const btnGuardar = document.getElementById("btnGuardarOficial");

    if (btnGuardar) {
        btnGuardar.addEventListener("click", () => {

            const data = {
                apellidos: document.getElementById("apellidos").value.trim(),
                nombres: document.getElementById("nombres").value.trim(),
                cargo: document.getElementById("cargo").value,
                id_agencia: document.getElementById("agenciaModal").value,
                estado: "Activo"
            };

            if (!data.apellidos || !data.nombres || !data.id_agencia) {
                alert("⚠ Completa todos los campos obligatorios.");
                return;
            }

            fetch("index.php?url=oficiales/save", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            })
                .then(r => r.json())
                .then(resp => {
                    if (!resp.success) {
                        alert("❌ Error al registrar.");
                        return;
                    }

                    // Cerrar modal
                    bootstrap.Modal.getInstance(
                        document.getElementById("modalNuevoOficial")
                    ).hide();

                    location.reload();
                });
        });
    }
});

/* ======================================================
   CAMBIAR ESTADO (ACTIVO / INACTIVO)
====================================================== */
function cambiarEstado(id, estadoActual) {

    const nuevoEstado = estadoActual === "Activo" ? "Inactivo" : "Activo";

    if (!confirm(`¿Desea cambiar el estado a: ${nuevoEstado}?`)) return;

    fetch("index.php?url=oficiales/estado", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `id=${id}&estado=${nuevoEstado}`
    })
        .then(r => r.json())
        .then(resp => {
            if (resp.success) location.reload();
            else alert("Error al actualizar estado");
        });
}
