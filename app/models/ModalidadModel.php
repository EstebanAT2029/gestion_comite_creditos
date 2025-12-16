<?php

class ModalidadModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function guardarModalidad($data)
    {
        $sql = "
            INSERT INTO modalidad_comite(
                id_comite,
                id_detalle,
                tipo_comite,
                modalidad_proponente,
                modalidad_participante1,
                modalidad_participante2,
                modalidad_jefe,
                modalidad_riesgo
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param(
            "iissssss",
            $data["id_comite"],
            $data["id_detalle"],
            $data["tipo_comite"],
            $data["modalidad_proponente"],
            $data["modalidad_participante1"],
            $data["modalidad_participante2"],
            $data["modalidad_jefe"],
            $data["modalidad_riesgo"]
        );

        return $stmt->execute();
    }

    public function getModalidad($idComite, $idDetalle)
    {
        $sql = "SELECT * FROM modalidad_comite WHERE id_comite=? AND id_detalle=? LIMIT 1";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("ii", $idComite, $idDetalle);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc();
    }
}