<?php require __DIR__ . "/../layout/header.php"; ?>

<div class="container mt-4">

    <h3 class="mb-3">🏢 Gestión de Jefes de Agencia</h3>

    <!-- ============================
         FILTRO SOLO DE AGENCIA
    ============================= -->
    <form method="GET" action="index.php" class="row g-3 mb-4">
        <input type="hidden" name="url" value="jefes">

        <div class="col-md-6">
            <label>Agencia</label>
            <select name="agencia" id="agencia" class="form-select">
                <option value="">Seleccione agencia</option>

                <?php foreach ($agencias as $a): ?>
                    <option value="<?= $a['id'] ?>"
                        <?= ($_GET["agencia"] ?? "") == $a['id'] ? 'selected' : '' ?>>
                        <?= $a['nombre_agencia'] ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="col-md-3 d-flex align-items-end">
            <button class="btn btn-primary w-100">🔍 Buscar</button>
        </div>
    </form>

    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalNuevoJefe">
        ➕ Registrar Nuevo Jefe
    </button>

    <!-- ============================
         TABLA DE JEFES
    ============================= -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Apellidos</th>
                <th>Nombres</th>
                <th>Agencia</th>
                <th>Acción</th>
            </tr>
        </thead>

        <tbody>
            <?php if (empty($jefes)): ?>
                <tr>
                    <td colspan="5" class="text-center text-muted">No se encontraron jefes.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($jefes as $j): ?>
                    <tr>
                        <td><?= $j["id"] ?></td>
                        <td><?= $j["apellidos"] ?></td>
                        <td><?= $j["nombres"] ?></td>
                        <td><?= $j["nombre_agencia"] ?></td>
                        <td>
                            <button class="btn btn-danger btn-sm"
                                    onclick="eliminarJefe(<?= $j['id'] ?>)">
                                🗑 Eliminar
                            </button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>

</div>


<!-- ============================
     MODAL PARA REGISTRAR JEFE
============================== -->
<div class="modal fade" id="modalNuevoJefe" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Registrar Nuevo Jefe de Agencia</h5>
                <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <form id="formNuevoJefe">

                    <label>Apellidos</label>
                    <input type="text" class="form-control mb-2" id="apellidos">

                    <label>Nombres</label>
                    <input type="text" class="form-control mb-2" id="nombres">

                    <label>Agencia</label>
                    <select id="agenciaModal" class="form-select mb-2">
                        <option value="">Seleccione agencia</option>

                        <?php foreach ($agencias as $a): ?>
                            <option value="<?= $a['id'] ?>"><?= $a['nombre_agencia'] ?></option>
                        <?php endforeach; ?>

                    </select>

                </form>

            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button class="btn btn-success" id="btnGuardarJefe">Guardar</button>
            </div>

        </div>
    </div>
</div>
<script src="assets/js/global-alerts.js?v=<?php echo time(); ?>"></script>
<script src="assets/js/jefes.js?v=<?= time()?>"></script>

<?php require __DIR__ . "/../layout/footer.php"; ?>