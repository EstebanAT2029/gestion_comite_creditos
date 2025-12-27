<?php require __DIR__ . "/../layout/header.php"; ?>

<div class="container mt-4">

    <h3 class="mb-3">👤 Gestión de Oficiales de Negocios</h3>

    <!-- ============================
         FILTRO: SOLO POR AGENCIA 
         (las agencias ya vienen filtradas por zona del usuario)
    ============================= -->
    <form method="GET" action="index.php" class="row g-3 mb-4">
        <input type="hidden" name="url" value="oficiales">

        <div class="col-md-4">
            <label>Agencia</label>
            <select name="agencia" id="agencia" class="form-select">
                <option value="">Seleccione agencia</option>

                <?php foreach ($agencias as $a): ?>
                    <option value="<?= $a['id'] ?>">
                        <?= $a['nombre_agencia'] ?>
                    </option>
                <?php endforeach; ?>

            </select>
        </div>

        <div class="col-md-4 d-flex align-items-end">
            <button class="btn btn-primary w-100">🔍 Buscar</button>
        </div>
    </form>

    <hr>

    <!-- ============================
         BOTÓN NUEVO OFICIAL
    ============================= -->
    <div class="card mb-4 p-3">
        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevoOficial">
             ➕ Registrar Nuevo Oficial
        </button>
    </div>

    <!-- ============================
         TABLA DE OFICIALES
    ============================= -->
    <h4>Lista de Oficiales</h4>

    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Apellidos</th>
                <th>Nombres</th>
                <th>Cargo</th>
                <th>Agencia</th>
                <th>Estado</th>
                <th>Acción</th>
            </tr>
        </thead>

        <tbody>
            <?php if (empty($oficiales)): ?>
                <tr>
                    <td colspan="7" class="text-center text-muted">No se encontraron oficiales.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($oficiales as $o): ?>
                    <tr>
                        <td><?= $o['id'] ?></td>
                        <td><?= $o['apellidos'] ?></td>
                        <td><?= $o['nombres'] ?></td>
                        <td><?= $o['cargo'] ?></td>
                        <td><?= $o['nombre_agencia'] ?></td>
                        <td>
                            <span class="badge bg-<?= $o['estado'] == 'Activo' ? 'success' : 'secondary' ?>">
                                <?= $o['estado'] ?>
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm <?= ($o['estado'] === 'Activo') ? 'btn-danger' : 'btn-success' ?>"
                                    onclick="cambiarEstado(<?= $o['id'] ?>, '<?= $o['estado'] ?>')">
                                <?= ($o['estado'] === 'Activo') ? 'Deshabilitar' : 'Habilitar' ?>
                            </button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>

</div>


<!-- =======================
     MODAL REGISTRO OFICIAL 
========================== -->
<div class="modal fade" id="modalNuevoOficial" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Registrar Nuevo Oficial</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <form id="formNuevoOficial">

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label>Apellidos</label>
                            <input type="text" class="form-control" id="apellidos" required>
                        </div>
                        <div class="col-md-6">
                            <label>Nombres</label>
                            <input type="text" class="form-control" id="nombres" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label>Cargo</label>
                            <select class="form-select" id="cargo">
                                <option value="Oficial">Oficial de Negocios</option>
                                <option value="Asesor">Oficial de Negocios II</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label>Agencia</label>
                            <!-- SE CARGA VIA AJAX SEGÚN ZONA DEL USUARIO -->
                            <select class="form-select" id="agenciaModal"></select>
                        </div>
                    </div>

                </form>

            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button class="btn btn-success" id="btnGuardarOficial">💾 Registrar</button>
            </div>

        </div>
    </div>
</div>
<script src="assets/js/global-alerts.js?v=<?php echo time(); ?>"></script>
<script src="assets/js/oficiales.js?v=<?= time(); ?>"></script>

<?php require __DIR__ . "/../layout/footer.php"; ?>