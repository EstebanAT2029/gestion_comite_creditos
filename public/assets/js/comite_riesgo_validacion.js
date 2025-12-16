/* ============================================================
   VALIDACIONES PARA FORMULARIO DE RIESGO VINCULADO (C-8)
============================================================ */
/* ============================
   1. VALIDACIONES EN TIEMPO REAL
============================= */
document.addEventListener("input", function (e) {
    const el = e.target;

    // --- DNI: solo números, max 8 ---
    if (el.classList.contains("rv_dni")) {
        el.value = el.value.replace(/\D/g, "").slice(0, 8);
        if (el.value.length === 8) el.classList.remove("is-invalid");
    }

    // --- Apellidos / Nombres: mayúsculas ---
    if (el.classList.contains("rv_apellidos") || el.classList.contains("rv_nombres")) {
        el.value = el.value.toUpperCase();
        if (el.value.trim() !== "") el.classList.remove("is-invalid");
    }

    // --- Campos de texto de domicilio / actividad / predio ---
    if (el.classList.contains("rv_dom_txt") || 
        el.classList.contains("rv_act_txt") || 
        el.classList.contains("rv_pre_txt"))
    {
        el.value = el.value.toUpperCase();
        if (el.value.trim() !== "") el.classList.remove("is-invalid");
    }
});
/* ============================
   2. CONTROLAR SELECT SI / NO
      (HABILITAR / BLOQUEAR CAMPOS)
============================= */

function configurarSiNo(fila) {

    const domSi = fila.querySelector(".rv_dom_si");
    const domTxt = fila.querySelector(".rv_dom_txt");

    const actSi = fila.querySelector(".rv_act_si");
    const actTxt = fila.querySelector(".rv_act_txt");

    const preSi = fila.querySelector(".rv_pre_si");
    const preTxt = fila.querySelector(".rv_pre_txt");

    function toggleCampo(select, campo, textoNo) {
        if (select.value === "Si") {
            campo.disabled = false;
            campo.value = "";
            campo.classList.add("is-invalid"); // obligar ingreso
        } else {
            campo.disabled = true;
            campo.value = textoNo;
            campo.classList.remove("is-invalid");
        }
    }
    // Eventos
    domSi.addEventListener("change", () => toggleCampo(domSi, domTxt, "NO TIENE DOMICILIO VINCULADO"));
    actSi.addEventListener("change", () => toggleCampo(actSi, actTxt, "NO TIENE ACTIVIDAD REGISTRADA"));
    preSi.addEventListener("change", () => toggleCampo(preSi, preTxt, "NO TIENE PREDIO VINCULADO"));

    // Inicializar estado
    toggleCampo(domSi, domTxt, "NO TIENE DOMICILIO VINCULADO");
    toggleCampo(actSi, actTxt, "NO TIENE ACTIVIDAD REGISTRADA");
    toggleCampo(preSi, preTxt, "NO TIENE PREDIO VINCULADO");
}
/* ============================================================
   3. VALIDACIÓN GLOBAL ANTES DE GUARDAR
============================================================ */
function validarVinculados() {

    let ok = true;
    let primerError = null;

    document.querySelectorAll(".fila-vinculado").forEach(fila => {

        const dni   = fila.querySelector(".rv_dni");
        const ape   = fila.querySelector(".rv_apellidos");
        const nom   = fila.querySelector(".rv_nombres");
        const grado = fila.querySelector(".rv_grado");

        const domSi = fila.querySelector(".rv_dom_si");
        const domTx = fila.querySelector(".rv_dom_txt");

        const actSi = fila.querySelector(".rv_act_si");
        const actTx = fila.querySelector(".rv_act_txt");

        const preSi = fila.querySelector(".rv_pre_si");
        const preTx = fila.querySelector(".rv_pre_txt");

        // --- DNI ---
        if (dni.value.length !== 8) {
            dni.classList.add("is-invalid");
            ok = false; if (!primerError) primerError = dni;
        }

        // --- Apellidos y Nombres ---
        if (ape.value.trim() === "") { ape.classList.add("is-invalid"); ok = false; if (!primerError) primerError = ape; }
        if (nom.value.trim() === "") { nom.classList.add("is-invalid"); ok = false; if (!primerError) primerError = nom; }

        // --- Grado obligatorio ---
        if (grado.value.trim() === "") {
            grado.classList.add("is-invalid");
            ok = false; if (!primerError) primerError = grado;
        }

        // --- Si elige SI → validar la descripción ---
        if (domSi.value === "Si" && domTx.value.trim() === "") {
            domTx.classList.add("is-invalid");
            ok = false; if (!primerError) primerError = domTx;
        }

        if (actSi.value === "Si" && actTx.value.trim() === "") {
            actTx.classList.add("is-invalid");
            ok = false; if (!primerError) primerError = actTx;
        }

        if (preSi.value === "Si" && preTx.value.trim() === "") {
            preTx.classList.add("is-invalid");
            ok = false; if (!primerError) primerError = preTx;
        }

    });

    if (!ok) {
        alert("⚠ COMPLETE TODOS LOS CAMPOS OBLIGATORIOS DEL FORMULARIO DE RIESGO VINCULADO.");
        primerError?.focus();
    }
    return ok;
}
/* ============================================================
   4. BOTÓN GUARDAR RIESGO VINCULADO
============================================================ */

document.getElementById("btnGuardarRV").addEventListener("click", function () {

    if (!validarVinculados()) return;

    // SI todo está bien → ejecutar función existente
    guardarDatosVinculados(); // Ya definida en comite_riesgo.js
});