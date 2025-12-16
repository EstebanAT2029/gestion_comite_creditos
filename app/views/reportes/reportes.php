<?php require __DIR__ . "/../layout/header.php"; ?>

<div class="container mt-4">

    <h3>Reporte de Comité de Créditos</h3>

    <!-- FILTROS -->
    <form method="GET" action="index.php" class="row g-3 mb-4">
        <input type="hidden" name="url" value="reportes">

        <div class="col-md-4">
            <label class="form-label">Agencia</label>
            <select name="agencia" class="form-select">
                <option value="">Seleccione...</option>
                <?php foreach ($agencias as $a): ?>
                    <option value="<?= $a['id'] ?>"
                        <?= (!empty($_GET['agencia']) && $_GET['agencia'] == $a['id']) ? 'selected' : '' ?>>
                        <?= $a['nombre_agencia'] ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="col-md-3 d-flex align-items-end">
            <button class="btn btn-primary w-100">Buscar</button>
        </div>
        <div class="col-md-3 d-flex align-items-end">
            <a href="index.php?url=reportes/general-excel" class="btn btn-success w-100">
                📘 Reporte General
            </a>
        </div>

    </form>

    <!-- TABLA -->
    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Cadena</th>
                        <th>Agencia</th>
                        <th>DNI</th>
                        <th>Cliente</th>
                        <th>Monto</th>
                        <th>Fecha</th>
                        <th>Resolución</th>
                        <th>Observaciones</th>
                        <th>Oficial de Riesgos</th>
                        <th>Oficial Proponente</th>
                        <th>N° Acta</th>
                        <th>Acta</th>
                    </tr>
                </thead>

                <tbody>
                    <?php if (empty($resultados)): ?>
                        <tr>
                            <td colspan="12" class="text-center text-muted">Sin resultados</td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($resultados as $r): ?>
                            <tr>
                                <td><?= $r["cadena"] ?></td>
                                <td><?= $r["nombre_agencia"] ?></td>
                                <td><?= $r["dni"] ?></td>
                                <td><?= $r["cliente"] ?></td>
                                <td><?= number_format($r["monto"], 2) ?></td>
                                <td><?= $r["fecha"] ?></td>
                                <td><?= $r["resolucion"] ?></td>
                                <td><?= $r["observaciones"] ?></td>
                                <td><?= $r["usuario_registro"] ?></td>

                                <td><?= $r["oficial_proponente"] ?></td>

                                <td><?= $r["correlativo"] ?></td>

                                <td>
                                    <a target="_blank"
                                       href="index.php?url=comite/acta&id=<?= $r['id_comite'] ?>&id_detalle=<?= $r['id_detalle'] ?>"
                                       class="btn btn-sm btn-primary mb-1">PDF</a>

                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>

            </table>

        </div>
    </div>

</div>

<?php require __DIR__ . "/../layout/footer.php"; ?>