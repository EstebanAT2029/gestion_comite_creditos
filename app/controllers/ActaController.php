<?php

class ActaController
{
    private $model;

    public function __construct()
    {
        $this->model = new ComiteModel();
    }

    public function pdf()
    {
        $idComite = intval($_GET["id"] ?? 0);
        if ($idComite <= 0) die("ID inválido");

        $datos = $this->model->getDatosActa($idComite);
        if (!$datos) die("No existen datos");

        require_once __DIR__ . "/../../vendor/autoload.php";

        (new ActaPdfService())->generar($datos, $idComite);
    }

    public function word()
    {
        $idComite = intval($_GET["id"] ?? 0);
        if ($idComite <= 0) die("ID inválido");

        $datos = $this->model->getDatosActa($idComite);
        if (!$datos) die("No existen datos");

        require_once __DIR__ . "/../../vendor/autoload.php";

        (new ActaWordService())->generar($datos, $idComite);
    }
}