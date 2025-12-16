<?php
$title = "Panel Principal";

require __DIR__ . "/../layout/header.php";
?>

<h3 class="dashboard-title mb-4">Panel Principal</h3>

<div class="row g-4">

    <!-- Registrar Comité -->
    <div class="col-md-3">
        <div class="panel-card p-4 text-center">
            <div class="icon-box icon-blue mb-2">
                <i class="bi bi-journal-plus"></i>
            </div>
            <h4 class="mb-1">Registrar Comité</h4>
            <p class="text-muted">Crear un nuevo comité</p>
            <a href="index.php?url=comite/form" class="btn btn-panel-blue w-100">Ingresar</a>
        </div>
    </div>

    <!-- Gestión de Oficiales -->
    <div class="col-md-3">
        <div class="panel-card p-4 text-center">
            <div class="icon-box icon-dark mb-2">
                <i class="bi bi-people-fill"></i>
            </div>
            <h4 class="mb-1">Gestión de Oficiales</h4>
            <p class="text-muted">Administrar Oficiales</p>
            <a href="index.php?url=oficiales" class="btn btn-panel-dark w-100">Administrar</a>
        </div>
    </div>

    <!-- Gestión de Jefes A -->
    <div class="col-md-3">
        <div class="panel-card p-4 text-center">
            <div class="icon-box icon-yellow mb-2">
                <i class="bi bi-person-gear"></i>
            </div>
            <h4 class="mb-1">Gestión de Jefes A</h4>
            <p class="text-muted">Administrar Jefes</p>
            <a href="index.php?url=jefes" class="btn btn-panel-yellow w-100 text-dark">Gestionar</a>
        </div>
    </div>

    <!-- Reporte General -->
    <div class="col-md-3">
        <div class="panel-card p-4 text-center">
            <div class="icon-box icon-green mb-2">
                <i class="bi bi-file-earmark-bar-graph-fill"></i>
            </div>
            <h4 class="mb-1">Reporte General</h4>
            <p class="text-muted">Generar Excel general</p>
            <a href="index.php?url=reportes" class="btn btn-panel-green w-100">Reporte</a>
        </div>
    </div>

</div>


<?php require __DIR__ . "/../layout/footer.php"; ?>