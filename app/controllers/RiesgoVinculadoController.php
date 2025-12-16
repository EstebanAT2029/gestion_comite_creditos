<?php

class RiesgoVinculadoController
{
    private $model;

    public function __construct()
    {
        $this->model = new RiesgoVinculadoModel();
    }

    public function listar()
    {
        header("Content-Type: application/json");

        $detalle = intval($_GET["detalle"]);
        echo json_encode($this->model->listarPorDetalle($detalle));
    }
}