/* ============================================================
   ALERTAS GLOBALES DEL SISTEMA
   Disponible para TODOS los JS
============================================================ */

window.customAlert = function (mensaje, titulo = "Mensaje") {
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
};

window.customConfirm = function (mensaje, titulo = "Confirmación") {
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
};
