<?php
header("Content-Type: application/json");

class ComiteStoreController
{
    private $service;

    public function __construct()
    {
        $this->service = new ComiteService();
    }

    public function guardar()
    {
        try {

            // Obtener los datos enviados por POST o JSON
            $data = $_POST;

            // Si viene JSON desde fetch, lo decodificamos
            if (empty($data)) {
                $json = file_get_contents("php://input");
                $data = json_decode($json, true);
            }

            if (empty($data)) {
                throw new Exception("No se recibió información del formulario.");
            }

            // Llamar al servicio
            $resultado = $this->service->guardarComite($data);

            echo json_encode([
                "success"     => true,
                "id_comite"   => $resultado["id_comite"] ?? null,
                "id_detalle"  => $resultado["id_detalle"] ?? null
            ]);

        } catch (Exception $e) {

            echo json_encode([
                "success" => false,
                "error"   => $e->getMessage()
            ]);
        }
    }
}