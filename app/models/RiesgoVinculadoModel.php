<?php

class RiesgoVinculadoModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function insertarVinculado($idDetalle, $v)
    {
        $sql = "INSERT INTO riesgo_vinculado (
                    id_detalle_comite, dni, apellidos, nombres,
                    grado_consanguinidad, domicilio_si, domicilio_texto,
                    actividad_si, actividad_texto,
                    predio_si, predio_texto
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->db->prepare($sql);

        if (!$stmt) {
            throw new Exception("Error preparando insertarVinculado: " . $this->db->error);
        }

        $stmt->bind_param(
            "issssssssss",
            $idDetalle,
            $v["dni"],
            $v["apellidos"],
            $v["nombres"],
            $v["grado_consanguinidad"],
            $v["domicilio_si"],
            $v["domicilio_texto"],
            $v["actividad_si"],
            $v["actividad_texto"],
            $v["predio_si"],
            $v["predio_texto"]
        );

        if (!$stmt->execute()) {
            throw new Exception("Error insertando vinculado: " . $stmt->error);
        }
    }
    public function getByDetalle($idDetalle)
    {
        $sql = "SELECT * FROM riesgo_vinculado WHERE id_detalle_comite = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $idDetalle);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

}