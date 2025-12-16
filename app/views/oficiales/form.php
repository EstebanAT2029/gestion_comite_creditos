<?php if (!defined('APP_SECURITY')) { die('Acceso no autorizado'); } ?>

<div class="modal fade" id="modalRegistro">
    <div class="modal-dialog">
        <form class="modal-content" action="index.php?url=oficiales-negocios/store" method="POST">

            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Registrar Oficial</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <div class="mb-2">
                    <label>Zona</label>
                    <select id="zonaSelect" class="form-select" required>
                        <option value="">Seleccione zona</option>
                        <?php while ($z = $zonas->fetch_assoc()) { ?>
                            <option value="<?= $z['zona'] ?>"><?= $z['zona'] ?></option>
                        <?php } ?>
                    </select>
                </div>

                <div class="mb-2">
                    <label>Agencia</label>
                    <select id="agenciaSelect" name="id_agencia" class="form-select" required></select>
                </div>

                <div class="mb-2">
                    <label>Apellidos</label>
                    <input type="text" name="apellidos" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Nombres</label>
                    <input type="text" name="nombres" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Cargo</label>
                    <input type="text" name="cargo" class="form-control" value="Oficial" required>
                </div>

            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button class="btn btn-primary">Guardar</button>
            </div>

        </form>
    </div>
</div>