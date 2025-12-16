<?php

class AgenciaController
{
    private $model;

    public function __construct()
    {
        $this->model = new ComiteModel();
    }

    public function listar()
    {
        header("Content-Type: application/json");
        echo json_encode($this->model->getAgencias());
    }
}