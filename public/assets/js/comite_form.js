/* ============================================================
   SISCOMITE — REGISTRO DE COMITÉ
============================================================ */

document.addEventListener("DOMContentLoaded", () => {
    actualizarHoraSistema();

    // Actualizar cada 30 segundos
    setInterval(actualizarHoraSistema, 30000);
    console.log("✔ comite_form.js cargado");

    // Elementos principales
    const selAgencia   = document.getElementById("agencia");
    const selOf1       = document.getElementById("oficial1");
    const selOf2       = document.getElementById("oficial2");
    const selJefe      = document.getElementById("jefe_ag");

    const btnEmpezar   = document.getElementById("btnEmpezar");
    const btnAñadir    = document.getElementById("btnAñadir");
    const btnFinalizar = document.getElementById("btnFinalizar");

    const contCasos     = document.getElementById("contenedor-casos");
    const plantillaCaso = document.getElementById("plantilla-caso");

    if (!selAgencia || !selOf1 || !selOf2 || !selJefe || !btnAñadir) {
        console.warn("comite_form.js: No está en formulario, módulo detenido.");
        return;
    }

    let oficialesGlobal = [];
    let jefesGlobal     = [];
    let numCaso = 0;

    /* ============================================================
       1. Cargar agencias según zona del usuario
    ============================================================= */
    fetch("index.php?url=api/agencias")
        .then(res => res.json())
        .then(data => {
            llenarCombo(selAgencia, data, "id", "nombre_agencia");
        })
        .catch(err => console.error("Error cargando agencias:", err));

    /* ============================================================
       2. Cambia agencia → cargar oficiales y jefes
    ============================================================= */
    selAgencia.addEventListener("change", () => {
        const id = selAgencia.value;

        limpiarCombo(selOf1);
        limpiarCombo(selOf2);
        limpiarCombo(selJefe);

        if (!id) return;

        cargarOficiales(id);
        cargarJefes(id);
    });

    function cargarOficiales(idAgencia) {

        fetch(`index.php?url=api/oficiales&agencia_id=${idAgencia}`)
            .then(res => res.json())
            .then(data => {
                oficialesGlobal = data || [];

                llenarCombo(selOf1, oficialesGlobal, "id", "nombre");
                llenarCombo(selOf2, oficialesGlobal, "id", "nombre");

                actualizarComboProponentes();
            })
            .catch(err => console.error("Error oficiales:", err));
    }

    function cargarJefes(idAgencia) {
        fetch(`index.php?url=api/jefes&agencia_id=${idAgencia}`)
            .then(res => res.json())
            .then(data => {
                jefesGlobal = data || [];
                llenarCombo(selJefe, jefesGlobal, "id", "nombre");
            })
            .catch(err => console.error("Error jefes:", err));
    }

    /* ============================================================
       UTILS
    ============================================================= */
    function llenarCombo(select, data, idField, textField) {
        limpiarCombo(select);
        (data || []).forEach(item => {
            select.innerHTML += `<option value="${item[idField]}">${item[textField]}</option>`;
        });
    }

    function limpiarCombo(select) {
        select.innerHTML = `<option value="">Seleccione</option>`;
    }

    /* ============================================================
       Validación oficial1 != oficial2
    ============================================================= */
    function validarParticipantes() {
        if (selOf1.value && selOf1.value === selOf2.value) {
            alert("⚠ No puede repetir el mismo oficial como participante 1 y 2.");
            selOf2.value = "";
        }
        actualizarComboProponentes();
    }

    selOf1.addEventListener("change", validarParticipantes);
    selOf2.addEventListener("change", validarParticipantes);

    /* ============================================================
       Filtrar oficiales proponentes en los casos
    ============================================================= */
    function actualizarComboProponentes() {
        const usados = new Set([selOf1.value, selOf2.value]);

        const filtrados = oficialesGlobal.filter(o => !usados.has(String(o.id)));

        document.querySelectorAll(".oficial_prop").forEach(select => {
            llenarCombo(select, filtrados, "id", "nombre");
        });
    }

    /* ============================================================
       3. Empezar comité
    ============================================================= */
    btnEmpezar.addEventListener("click", () => {

        if (!selAgencia.value || !selOf1.value || !selJefe.value) {
            alert("⚠ Complete todos los campos del encabezado.");
            return;
        }

        selAgencia.disabled = true;
        selOf1.disabled     = true;
        selOf2.disabled     = true;
        selJefe.disabled    = true;

        btnEmpezar.disabled   = true;
        btnAñadir.disabled    = false;
        btnFinalizar.disabled = false;

        actualizarComboProponentes();
    });

    /* ============================================================
       4. Añadir caso
    ============================================================= */
    btnAñadir.addEventListener("click", () => {

        numCaso++;

        const clone   = plantillaCaso.content.cloneNode(true);
        const divCaso = clone.querySelector(".caso-item");

        divCaso.querySelector(".titulo-caso").textContent = `Caso ${numCaso}`;

        const selProp = divCaso.querySelector(".oficial_prop");

        const usados = new Set([selOf1.value, selOf2.value]);
        const filtrados = oficialesGlobal.filter(o => !usados.has(String(o.id)));

        llenarCombo(selProp, filtrados, "id", "nombre");

        contCasos.appendChild(clone);
    });

    /* ============================================================
       5. Finalizar Comité — LLAMADO DESDE validacion.js
    ============================================================= */
    window.finalizarComite = function () {

        const payload = armarJSON();

        console.log("➡ Enviando JSON:", payload);

        fetch("index.php?url=comite/store", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
        .then(r => r.text())
        .then(t => {
            console.log("RAW RESPONSE:", t);

            let resp = JSON.parse(t);

            if (!resp.success) {
                alert("❌ Error al guardar comité: " + resp.error);
                return;
            }

            window.ID_COMITE  = resp.id_comite;
            window.ID_DETALLE = resp.id_detalle;

            const modal = new bootstrap.Modal(document.getElementById("modalTipoComite"));
            modal.show();
        })
        .catch(err => {
            console.error("Error conectando:", err);
            alert("❌ Error de conexión.");
        });
    };

    /* ============================================================
       Construye JSON
    ============================================================= */
    function armarJSON() {

        const casos = [];

        document.querySelectorAll(".caso-item").forEach(caso => {

            let vinculados = [];
            try { vinculados = JSON.parse(caso.querySelector(".rv_json").value); } catch {}

            casos.push({
                dni:          caso.querySelector(".dni").value,
                cadena:       caso.querySelector(".cadena").value,
                nombres:      caso.querySelector(".nombres").value,
                monto:        parseFloat(caso.querySelector(".monto").value || 0),
                tipo_cli:     caso.querySelector(".tipo_cli").value,
                tipo_credito: caso.querySelector(".tipo_credito").value,
                oficial_prop: caso.querySelector(".oficial_prop").value,
                decision:     caso.querySelector(".decision").value,
                comentarios:  caso.querySelector(".comentarios").value,
                vinculados:   vinculados
            });
        });

        return {
            fecha:        document.getElementById("fecha").value,
            hora:         document.getElementById("hora").value,
            agencia:      selAgencia.value,
            oficial1:     selOf1.value,
            oficial2:     selOf2.value,
            jefe_agencia: selJefe.value,
            casos:        casos
        };
    }
    function actualizarHoraSistema() {
        const inputHora = document.getElementById("hora");
        if (!inputHora) return;

        const ahora = new Date();
        const hh = String(ahora.getHours()).padStart(2, "0");
        const mm = String(ahora.getMinutes()).padStart(2, "0");

        inputHora.value = `${hh}:${mm}`;
    }

});



