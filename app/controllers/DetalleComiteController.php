<?php

class ComiteDetalleModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function guardarDetalle($idComite, $data, $c)
    {
        $sql = "INSERT INTO detalle_comite (
                    id_comite,
                    id_agencia,
                    dni,
                    cadena,
                    nombres,
                    monto,
                    tipo_cli,
                    tipo_credito,
                    id_oficial_proponente,
                    id_oficial_participante1,
                    id_oficial_participante2,
                    id_jefe_agencia,
                    id_decision,
                    observaciones,
                    correlativo
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->db->prepare($sql);

        $correlativo = $this->obtenerCorrelativo($data["agencia"]);

        $stmt->bind_param(
            "iisssdsiiiissi",
            $idComite,
            $data["agencia"],
            $c["dni"],
            $c["cadena"],
            $c["nombres"],
            $c["monto"],
            $c["tipo_cli"],
            $c["tipo_credito"],
            $c["oficial_prop"],
            $data["oficial1"],
            $data["oficial2"],
            $data["jefe_agencia"],
            $this->decisionToId($c["decision"]),
            $c["comentarios"],
            $correlativo
        );

        $stmt->execute();
        return $stmt->insert_id;
    }

    private function obtenerCorrelativo($idAgencia)
    {
        $sql = "SELECT MAX(correlativo) AS maxcor
                FROM detalle_comite
                WHERE id_agencia = ?";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $idAgencia);
        $stmt->execute();

        $row = $stmt->get_result()->fetch_assoc();
        $next = intval($row["maxcor"]) + 1;

        return str_pad($next, 3, "0", STR_PAD_LEFT);
    }

    private function decisionToId($descripcion)
    {
        $sql = "SELECT id FROM decision WHERE descripcion = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("s", $descripcion);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc()["id"];
    }
}