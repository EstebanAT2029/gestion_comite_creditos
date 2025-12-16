<?php

class CatalogoController
{
    private $model;

    public function __construct()
    {
        $this->model = new CatalogoModel();
    }

    public function agencias()
    {
        header('Content-Type: application/json');
        echo json_encode($this->model->agencias());
    }

    public function oficiales()
    {
        header('Content-Type: application/json');
        echo json_encode(
            $this->model->oficiales($_GET['agencia_id'])
        );
    }

    public function jefes()
    {
        header('Content-Type: application/json');
        echo json_encode(
            $this->model->jefes($_GET['agencia_id'])
        );
    }
}