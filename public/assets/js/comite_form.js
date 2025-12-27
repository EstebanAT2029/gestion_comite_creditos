/* ============================================================
   SISCOMITE — REGISTRO DE COMITÉ
============================================================ */

document.addEventListener("DOMContentLoaded", () => {
    // Elementos principales
        // ✅ Al cargar el formulario → hora del sistema
    actualizarHoraSistema(true);

    const selAgencia   = document.getElementById("agencia");
    const selOf1       = document.getElementById("oficial1");
    const selOf2       = document.getElementById("oficial2");
    const selJefe      = document.getElementById("jefe_ag");

    const btnEmpezar = document.getElementById("btnEmpezar");
        if (btnEmpezar) {
            btnEmpezar.addEventListener("click", () => {
                // 🔒 No forzar, solo asegurar que exista
                actualizarHoraSistema(false);
            });
        }
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
            customAlert("⚠ No puede repetir el mismo oficial como participante 1 y 2.");
            selOf2.value = "";
        }
        actualizarComboProponentes();
    }

    selOf1.addEventListener("change", validarParticipantes);
    selOf2.addEventListener("change", validarParticipantes);

    function actualizarComboProponentes() {

        const casos = document.querySelectorAll(".caso-item");

        // Caso único → filtrar
        if (casos.length === 1) {

            const usados = new Set([selOf1.value, selOf2.value]);

            const filtrados = oficialesGlobal.filter(o => !usados.has(String(o.id)));

            const select = casos[0].querySelector(".oficial_prop");

            // ⚠️ SOLO si aún no tiene valor
            if (!select.value) {
                llenarCombo(select, filtrados, "id", "nombre");
            }

            return;
        }

        // Dos o más casos → liberar SIN resetear
        casos.forEach(caso => {

            const select = caso.querySelector(".oficial_prop");

            // 🔒 Si ya eligieron algo → NO TOCAR
            if (select.value) return;

            // 🔓 Solo llenar si está vacío
            llenarCombo(select, oficialesGlobal, "id", "nombre");
        });
    }

    /* ============================================================
       3. Empezar comité
    ============================================================= */
    btnEmpezar.addEventListener("click", () => {

        if (!selAgencia.value || !selOf1.value || !selJefe.value) {
            customAlert("⚠ Complete todos los campos del encabezado.", "Validación");
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
    ============================================================ */
    btnAñadir.addEventListener("click", () => {

        numCaso++;

        const clone   = plantillaCaso.content.cloneNode(true);
        const divCaso = clone.querySelector(".caso-item");

        divCaso.querySelector(".titulo-caso").textContent = `Caso ${numCaso}`;

        contCasos.appendChild(clone);

        // 🔥 MUY IMPORTANTE:
        // recalcula los oficiales proponentes según
        // la cantidad total de casos existentes
        actualizarComboProponentes();
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
    function actualizarHoraSistema(force = false) {
        const inputHora = document.getElementById("hora");
        if (!inputHora) return;

        // ❗ Solo setear si está vacío o si se fuerza
        if (inputHora.value && !force) return;

        const ahora = new Date();
        const hh = String(ahora.getHours()).padStart(2, "0");
        const mm = String(ahora.getMinutes()).padStart(2, "0");

        inputHora.value = `${hh}:${mm}`;
    }
    //css para los alerts
    function customAlert(mensaje, titulo = "Mensaje") {
        return new Promise(resolve => {
            const overlay = document.createElement("div");
            overlay.className = "alert-overlay";

            overlay.innerHTML = `
                <div class="alert-box">
                    <div class="alert-title">${titulo}</div>
                    <div class="alert-message">${mensaje}</div>
                    <div class="alert-actions">
                        <button class="alert-btn alert-ok">Aceptar</button>
                    </div>
                </div>
            `;

            overlay.querySelector(".alert-ok").onclick = () => {
                overlay.remove();
                resolve(true);
            };

            document.body.appendChild(overlay);
        });
    }

    function customConfirm(mensaje, titulo = "Confirmación") {
        return new Promise(resolve => {
            const overlay = document.createElement("div");
            overlay.className = "alert-overlay";

            overlay.innerHTML = `
                <div class="alert-box">
                    <div class="alert-title">${titulo}</div>
                    <div class="alert-message">${mensaje}</div>
                    <div class="alert-actions">
                        <button class="alert-btn alert-cancel">Cancelar</button>
                        <button class="alert-btn alert-ok">Aceptar</button>
                    </div>
                </div>
            `;

            overlay.querySelector(".alert-ok").onclick = () => {
                overlay.remove();
                resolve(true);
            };

            overlay.querySelector(".alert-cancel").onclick = () => {
                overlay.remove();
                resolve(false);
            };

            document.body.appendChild(overlay);
        });
    }

});



