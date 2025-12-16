document.addEventListener("DOMContentLoaded", () => {

    console.log("✔ comite_modalidad.js cargado");

    const modalElem = document.getElementById("modalTipoComite");
    if (!modalElem) return;

    const btnPresencial = document.getElementById("btnPresencial");
    const btnVirtual = document.getElementById("btnVirtual");
    const btnSemi = document.getElementById("btnSemi");

    const radios = document.querySelectorAll(
        "input[name='modalidad_proponente'], " +
        "input[name='modalidad_participante1'], " +
        "input[name='modalidad_participante2'], " +
        "input[name='modalidad_jefe'], " +
        "input[name='modalidad_riesgo']"
    );

    /* ============================================================
       HABILITACIÓN AUTOMÁTICA DE BOTONES
    ============================================================ */
    function evaluarBotones() {
        let valores = [];

        radios.forEach(r => {
            if (r.checked) valores.push(r.value);
        });

        if (valores.length !== 5) {
            btnPresencial.disabled = true;
            btnVirtual.disabled = true;
            btnSemi.disabled = true;
            return;
        }

        const allPresencial = valores.every(v => v === "Presencial");
        const allVirtual    = valores.every(v => v === "Virtual");

        if (allPresencial) {
            btnPresencial.disabled = false;
            btnVirtual.disabled = true;
            btnSemi.disabled = true;
        }
        else if (allVirtual) {
            btnVirtual.disabled = false;
            btnPresencial.disabled = true;
            btnSemi.disabled = true;
        }
        else {
            btnSemi.disabled = false;
            btnPresencial.disabled = true;
            btnVirtual.disabled = true;
        }
    }

    radios.forEach(r => r.addEventListener("change", evaluarBotones));


    /* ============================================================
       GUARDAR MODALIDAD DE COMITÉ
    ============================================================ */
    function guardarModalidad(tipo) {
        console.log("Modalidad definida:", tipo);

        const payload = {
            id_comite: window.ID_COMITE,
            id_detalle: window.ID_DETALLE,
            tipo_comite: tipo,
            modalidad_proponente: document.querySelector("input[name='modalidad_proponente']:checked").value,
            modalidad_participante1: document.querySelector("input[name='modalidad_participante1']:checked").value,
            modalidad_participante2: document.querySelector("input[name='modalidad_participante2']:checked").value,
            modalidad_jefe: document.querySelector("input[name='modalidad_jefe']:checked").value,
            modalidad_riesgo: document.querySelector("input[name='modalidad_riesgo']:checked").value
        };

        fetch("index.php?url=modalidad/guardar", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
        .then(resp => resp.json())
        .then(data => {

            if (!data.success) {
                alert("❌ Error guardando modalidad de comité");
                console.error(data.error);
                return;
            }

            console.log("✔ Modalidad guardada correctamente");

            // Cerrar modal de modalidad
            const modal = bootstrap.Modal.getInstance(
                document.getElementById("modalTipoComite")
            );
            modal.hide();

            // Mostrar modal de descarga
            mostrarModalDescarga();

        })
        .catch(err => console.error("Error:", err));
    }


    btnPresencial.addEventListener("click", () => guardarModalidad("Presencial"));
    btnVirtual.addEventListener("click", () => guardarModalidad("Virtual"));
    btnSemi.addEventListener("click", () => guardarModalidad("SemiPresencial"));


    /* ============================================================
       M O D A L   D E   D E S C A R G A
    ============================================================ */
    function mostrarModalDescarga() {

        const modalDescarga = new bootstrap.Modal(
            document.getElementById("modalDescargaActa")
        );

        modalDescarga.show();

        const btnWord  = document.getElementById("btnWord");
        const btnPdf   = document.getElementById("btnPdf");
        const btnClose = document.getElementById("btnCerrarModal");

        btnWord.onclick = () => {
            const url = `index.php?url=comite/actaWord&id=${window.ID_COMITE}&id_detalle=${window.ID_DETALLE}`;
            window.open(url, "_blank");
        };

        btnPdf.onclick = () => {
            const url = `index.php?url=comite/acta&id=${window.ID_COMITE}&id_detalle=${window.ID_DETALLE}`;
            window.open(url, "_blank");
        };

        btnClose.onclick = () => {
            window.location.href = "index.php?url=dashboard";
        };
    }

});