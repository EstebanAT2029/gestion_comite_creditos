<?php
session_start();
if (isset($_GET["debug_session"])) {
    echo "<pre>";
    print_r($_SESSION);
    echo "</pre>";
    exit;
}

define('APP_SECURITY', true);   // 🔒 activa la protección

require_once __DIR__ . '/../vendor/autoload.php';

/* ======================================
   AUTOLOAD MVC
====================================== */
spl_autoload_register(function ($class) {
    $base = __DIR__ . "/../app/";

    $folders = [
        "controllers/$class.php",
        "models/$class.php",
        "services/$class.php", 
        "core/$class.php",
        "config/$class.php",
    ];
    
    foreach ($folders as $file) {
        $path = $base . $file;
        if (file_exists($path)) {
            require_once $path;
            return;
        }
    }
});

/* ======================================
   MIDDLEWARES DE SESIÓN
====================================== */
function requireLogin()
{
    if (empty($_SESSION["user"])) {
        header("Location: index.php?url=login");
        exit;
    }
}

function requireAdmin()
{
    requireLogin();

    if ($_SESSION["user"]["rol"] !== "admin") {
        http_response_code(403);
        echo "<h1>403 - Acceso Denegado</h1>";
        exit;
    }
}

/* ======================================
   ROUTER
====================================== */
$uri = $_GET["url"] ?? "";
$uri = trim($uri, "/");

/* ======================================
   AUTH
====================================== */
if ($uri === "login")        return (new AuthController())->loginForm();
if ($uri === "login/entrar") return (new AuthController())->login();
if ($uri === "logout")       return (new AuthController())->logout();

/* ======================================
   DASHBOARD
====================================== */
if ($uri === "" || $uri === "dashboard") {
    requireLogin();
    require __DIR__ . "/../app/views/dashboard/dashboard.php";
    exit;
}

/* ======================================
   COMITÉ — STORE
====================================== */
if ($uri === "comite/store") {
    requireLogin();

    // Recibir JSON
    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    if (!$data) {
        echo json_encode([
            "success" => false,
            "error" => "JSON inválido"
        ]);
        exit;
    }
    $controller = new ComiteStoreController();
    $controller->guardar(); // SIN parámetros
    exit;
}
/* ======================================
   COMITÉ — ACTA PDF / WORD
====================================== */
if ($uri === "comite/acta") {
    requireLogin();
    return (new ComiteActaController())->actaPDF();
}

if ($uri === "comite/actaWord") {
    requireLogin();
    return (new ComiteActaController())->actaWord();
}

/* ======================================
   COMITÉ — MODALIDAD
====================================== */
if ($uri === "modalidad/guardar") {
    requireLogin();
    return (new ComiteModalidadController())->guardar();
}

/* ======================================
   APIS (USANDO ComiteApiController)
====================================== */

if ($uri === "api/agencias") {
    requireLogin();
    return (new ComiteApiController())->agencias();
}

if ($uri === "api/oficiales") {
    requireLogin();
    return (new ComiteApiController())->oficiales();
}

if ($uri === "api/jefes") {
    requireLogin();
    return (new ComiteApiController())->jefes();
}

/* ======================================
   REPORTES
====================================== */
if ($uri === "reportes") {
    requireLogin();
    return (new ReporteController())->index();
}
if ($uri === "reportes/general-excel") {
    requireLogin();
    return (new ReporteController())->reporteGeneralExcel();
}

if ($uri === "reportes/listar") {
    requireLogin();
    return (new ReporteController())->listar();
}

if ($uri === "reportes/excel") {
    requireLogin();
    return (new ReporteController())->excel();
}

if ($uri === "reportes/general-excel") {
    requireLogin();
    return (new ReporteController())->reporteGeneralExcel();
}

/* ======================================
   OFICIALES DE NEGOCIOS
====================================== */
if ($uri === "oficiales") {
    requireLogin();
    return (new OficialesNegociosController())->index();
}

if ($uri === "oficiales/save") {
    requireLogin();
    return (new OficialesNegociosController())->save();
}

if ($uri === "oficiales/get") {
    requireLogin();
    return (new OficialesNegociosController())->get();
}

if ($uri === "oficiales/update") {
    requireLogin();
    return (new OficialesNegociosController())->update();
}

if ($uri === "oficiales/estado") {
    requireLogin();
    return (new OficialesNegociosController())->estado();
}

/* ============================
   JEFES DE AGENCIA
============================ */
if ($uri === "jefes") {
    requireLogin();
    return (new JefesAgenciaController())->index();
}

if ($uri === "jefes/save") {
    requireLogin();
    return (new JefesAgenciaController())->save();
}

if ($uri === "jefes/delete") { 
    requireLogin();
    return (new JefesAgenciaController())->delete();
}

/* ======================================
   COMITÉ — FORMULARIO
====================================== */
if ($uri === "comite/form") {
    requireLogin();
    return (new ComiteFormController())->showForm();
}

/* ======================================
   404
====================================== */
http_response_code(404);
echo "<h1>404 - Página No Encontrada</h1>";
echo "Ruta: <b>$uri</b>";