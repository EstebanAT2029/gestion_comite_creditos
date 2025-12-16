<?php

class ModalidadComiteModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function guardarModalidad($data)
    {
        $sql = "INSERT INTO comite_modalidad (
                    id_comite,
                    id_detalle_comite,
                    tipo_comite,
                    modalidad_proponente,
                    modalidad_participante1,
                    modalidad_participante2,
                    modalidad_jefe,
                    modalidad_riesgo,
                    id_usuario_registro,
                    fecha_registro
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        $stmt = $this->db->prepare($sql);

        $stmt->bind_param(
            "iissssssi",
            $data["id_comite"],
            $data["id_detalle"],
            $data["tipo_comite"],
            $data["modalidad_proponente"],
            $data["modalidad_participante1"],
            $data["modalidad_participante2"],
            $data["modalidad_jefe"],
            $data["modalidad_riesgo"],
            $_SESSION["user"]["id"]
        );

        if (!$stmt->execute()) {
            throw new Exception("Error guardando modalidad del comité: " . $stmt->error);
        }

        return $stmt->insert_id;
    }
    public function getByComite($idComite)
    {
        $sql = "SELECT m.*, 
                u.nombres AS usuario_registro_nombre
                FROM comite_modalidad m
                LEFT JOIN usuarios u ON u.id = m.id_usuario_registro
                WHERE m.id_comite = ?";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $idComite);
        $stmt->execute();
        return $stmt->get_result()->fetch_assoc();
    }

}