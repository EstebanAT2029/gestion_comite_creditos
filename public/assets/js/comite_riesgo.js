/* ============================================================
   RIESGO VINCULADO — Modal, Validaciones y Múltiples Filas
============================================================ */

document.addEventListener("DOMContentLoaded", () => {

    console.log("✔ comite_riesgo.js cargado");

    const modalElem = document.getElementById("modalRiesgoVinculado");
    if (!modalElem) return;

    let modalRiesgo = new bootstrap.Modal(modalElem);
    let casoActual = null;

    const contVinc = document.getElementById("contenedorVinculados");
    const tplVinc  = document.getElementById("tpl-vinculado");

    if (!contVinc || !tplVinc) return;

    /* ============================================================
       1. Abrir modal al elegir riesgo vinculado = SI
    ============================================================= */
    document.addEventListener("change", e => {
        if (!e.target.classList.contains("sel-riesgo-c8")) return;

        const caso = e.target.closest(".caso-item");
        const hiddenJson = caso.querySelector(".rv_json");

        if (e.target.value === "Si") {
            casoActual = caso;
            contVinc.innerHTML = "";

            let vinculados = [];
            if (hiddenJson.value) {
                try { vinculados = JSON.parse(hiddenJson.value); } catch {}
            }

            if (!vinculados.length) {
                agregarFila();
            } else {
                vinculados.forEach(v => agregarFila(v));
            }

            modalRiesgo.show();
        } else {
            hiddenJson.value = "[]";
        }
    });

    /* ============================================================
       2. Agregar nueva fila
    ============================================================= */
    document.getElementById("btnAgregarVinc").addEventListener("click", () => agregarFila());

    function agregarFila(data = {}) {
        const clone = tplVinc.content.cloneNode(true);
        const fila = clone.querySelector(".fila-vinculado");

        fila.querySelector(".num-vinc").textContent =
            "V" + (contVinc.querySelectorAll(".fila-vinculado").length + 1);


        fila.querySelector(".rv_dni").value       = data.dni || "";
        fila.querySelector(".rv_apellidos").value = data.apellidos || "";
        fila.querySelector(".rv_nombres").value   = data.nombres || "";
        fila.querySelector(".rv_grado").value     = data.grado_consanguinidad || "";

        fila.querySelector(".rv_dom_si").value  = data.domicilio_si || "No";
        fila.querySelector(".rv_dom_txt").value = data.domicilio_texto || "";

        fila.querySelector(".rv_act_si").value  = data.actividad_si || "No";
        fila.querySelector(".rv_act_txt").value = data.actividad_texto || "";

        fila.querySelector(".rv_pre_si").value  = data.predio_si || "No";
        fila.querySelector(".rv_pre_txt").value = data.predio_texto || "";

        contVinc.appendChild(fila);

        configurarCamposSiNo(fila);
    }

    /* ============================================================
       3. Configurar habilitación SI/NO por fila
    ============================================================= */
    function configurarCamposSiNo(fila) {

        const domSi = fila.querySelector(".rv_dom_si");
        const domTx = fila.querySelector(".rv_dom_txt");

        const actSi = fila.querySelector(".rv_act_si");
        const actTx = fila.querySelector(".rv_act_txt");

        const preSi = fila.querySelector(".rv_pre_si");
        const preTx = fila.querySelector(".rv_pre_txt");

        function toggle(select, campo, textoNO) {
            if (select.value === "Si") {
                campo.disabled = false;
                campo.value = "";
                campo.classList.add("is-invalid");
            } else {
                campo.disabled = true;
                campo.value = textoNO;
                campo.classList.remove("is-invalid");
            }
        }

        domSi.addEventListener("change", () => toggle(domSi, domTx, "NO TIENE DOMICILIO VINCULADO"));
        actSi.addEventListener("change", () => toggle(actSi, actTx, "NO TIENE ACTIVIDAD REGISTRADA"));
        preSi.addEventListener("change", () => toggle(preSi, preTx, "NO TIENE PREDIO VINCULADO"));

        toggle(domSi, domTx, "NO TIENE DOMICILIO VINCULADO");
        toggle(actSi, actTx, "NO TIENE ACTIVIDAD REGISTRADA");
        toggle(preSi, preTx, "NO TIENE PREDIO VINCULADO");
    }

    /* ============================================================
       4. Eliminar fila
    ============================================================= */
    document.addEventListener("click", e => {
        if (!e.target.classList.contains("btnEliminarVinc")) return;

        const fila = e.target.closest(".fila-vinculado");
        fila.remove();

        contVinc.querySelectorAll(".fila-vinculado").forEach(
            (f, i) => f.querySelector(".num-vinc").textContent = "V" + (i + 1)
        );
    });

    /* ============================================================
       5. VALIDACIONES EN TIEMPO REAL
    ============================================================= */
    document.addEventListener("input", function (e) {

        const el = e.target;

        // DNI
        if (el.classList.contains("rv_dni")) {
            el.value = el.value.replace(/\D/g, "").slice(0, 8);
            if (el.value.length === 8) el.classList.remove("is-invalid");
        }

        // Apellidos / nombres
        if (el.classList.contains("rv_apellidos") || el.classList.contains("rv_nombres")) {
            el.value = el.value.toUpperCase();
            if (el.value.trim() !== "") el.classList.remove("is-invalid");
        }

        // Textos condicionales
        if (el.classList.contains("rv_dom_txt") || 
            el.classList.contains("rv_act_txt") || 
            el.classList.contains("rv_pre_txt")) 
        {
            el.value = el.value.toUpperCase();
            if (el.value.trim() !== "") el.classList.remove("is-invalid");
        }
    });

    /* ============================================================
       6. VALIDACIÓN GLOBAL
    ============================================================= */
    function validarVinculados() {
        /* ==============================================
        VALIDAR DNIs DUPLICADOS
        =============================================== */
        let listaDni = [];
        let duplicado = null;

        contVinc.querySelectorAll(".fila-vinculado").forEach(f => {
            let dni = f.querySelector(".rv_dni").value.trim();
            if (dni.length === 8) {
                if (listaDni.includes(dni)) {
                    duplicado = dni;
                }
                listaDni.push(dni);
            }
        });

        if (duplicado) {
            customAlert("⚠ El DNI " + duplicado + " está duplicado en la lista de vinculados.");
            contVinc.querySelectorAll(".fila-vinculado").forEach(f => {
                if (f.querySelector(".rv_dni").value.trim() === duplicado) {
                    f.querySelector(".rv_dni").classList.add("is-invalid");
                }
            });
            return false;
        }

        let ok = true;
        let firstError = null;

        contVinc.querySelectorAll(".fila-vinculado").forEach(f => {

            const dni   = f.querySelector(".rv_dni");
            const ape   = f.querySelector(".rv_apellidos");
            const nom   = f.querySelector(".rv_nombres");
            const grado = f.querySelector(".rv_grado");

            const domSi = f.querySelector(".rv_dom_si");
            const domTx = f.querySelector(".rv_dom_txt");

            const actSi = f.querySelector(".rv_act_si");
            const actTx = f.querySelector(".rv_act_txt");

            const preSi = f.querySelector(".rv_pre_si");
            const preTx = f.querySelector(".rv_pre_txt");

            // DNI
            if (dni.value.length !== 8) {
                dni.classList.add("is-invalid");
                ok = false; if (!firstError) firstError = dni;
            }

            // Apellidos / nombres
            if (ape.value.trim() === "") {
                ape.classList.add("is-invalid");
                ok = false; if (!firstError) firstError = ape;
            }

            if (nom.value.trim() === "") {
                nom.classList.add("is-invalid");
                ok = false; if (!firstError) firstError = nom;
            }

            // Grado
            if (!grado.value) {
                grado.classList.add("is-invalid");
                ok = false; if (!firstError) firstError = grado;
            }

            // Campos SI
            if (domSi.value === "Si" && domTx.value.trim() === "") {
                domTx.classList.add("is-invalid");
                ok = false; if (!firstError) firstError = domTx;
            }

            if (actSi.value === "Si" && actTx.value.trim() === "") {
                actTx.classList.add("is-invalid");
                ok = false; if (!firstError) firstError = actTx;
            }

            if (preSi.value === "Si" && preTx.value.trim() === "") {
                preTx.classList.add("is-invalid");
                ok = false; if (!firstError) firstError = preTx;
            }

        });

        if (!ok) {
            customAlert("⚠ COMPLETE TODOS LOS CAMPOS DEL FORMULARIO DE RIESGO VINCULADO.");
            firstError?.focus();
        }

        return ok;
    }

    /* ============================================================
       7. GUARDAR VINCULADOS
    ============================================================= */
    document.getElementById("btnGuardarRV").addEventListener("click", () => {

        if (!validarVinculados()) return;

        const vinculados = [];

        contVinc.querySelectorAll(".fila-vinculado").forEach(f => {
            vinculados.push({
                dni: f.querySelector(".rv_dni").value.trim(),
                apellidos: f.querySelector(".rv_apellidos").value.trim(),
                nombres: f.querySelector(".rv_nombres").value.trim(),
                grado_consanguinidad: f.querySelector(".rv_grado").value,

                domicilio_si: f.querySelector(".rv_dom_si").value,
                domicilio_texto: f.querySelector(".rv_dom_txt").value.trim(),

                actividad_si: f.querySelector(".rv_act_si").value,
                actividad_texto: f.querySelector(".rv_act_txt").value.trim(),

                predio_si: f.querySelector(".rv_pre_si").value,
                predio_texto: f.querySelector(".rv_pre_txt").value.trim()
            });
        });

        casoActual.querySelector(".rv_json").value = JSON.stringify(vinculados);

        modalRiesgo.hide();
    });

});