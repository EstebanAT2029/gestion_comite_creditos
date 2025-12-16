<?php

class ComiteModalidadController
{
    private $model;

    public function __construct()
    {
        $this->model = new ModalidadComiteModel();
    }

    public function guardar()
    {
        header("Content-Type: application/json");

        // Recibir JSON
        $json = file_get_contents("php://input");
        $data = json_decode($json, true);

        if (!$data) {
            echo json_encode(["success" => false, "error" => "JSON inválido"]);
            return;
        }

        try {

            $resultado = $this->model->guardarModalidad($data);

            echo json_encode([
                "success" => true,
                "id_modalidad" => $resultado
            ]);

        } catch (Exception $e) {

            echo json_encode([
                "success" => false,
                "error" => $e->getMessage()
            ]);
        }
    }
}