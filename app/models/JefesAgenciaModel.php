<?php

class JefesAgenciaModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    /* =====================================================
       LISTAR JEFES POR AGENCIA
    ===================================================== */
    public function getByAgencia($idAgencia)
    {
        $sql = "
            SELECT j.*, a.nombre_agencia
            FROM jefes_agencia j
            INNER JOIN agencia a ON a.id = j.id_agencia
            WHERE j.id_agencia = ?
            ORDER BY j.apellidos ASC
        ";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $idAgencia);
        $stmt->execute();

        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
    public function getById($id)
    {
        $sql = "
            SELECT 
                j.*, 
                a.nombre_agencia
            FROM jefes_agencia j
            INNER JOIN agencia a ON a.id = j.id_agencia
            WHERE j.id = ?
        ";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $id);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc();
    }


    /* =====================================================
       INSERTAR JEFE
    ===================================================== */
    public function insertar($data)
    {
        $sql = "
            INSERT INTO jefes_agencia (apellidos, nombres, id_agencia)
            VALUES (?, ?, ?)
        ";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param(
            "ssi",
            $data["apellidos"],
            $data["nombres"],
            $data["id_agencia"]
        );

        return $stmt->execute();
    }

    /* =====================================================
       ELIMINAR JEFE
    ===================================================== */
    public function eliminar($id)
    {
        $stmt = $this->db->prepare(
            "DELETE FROM jefes_agencia WHERE id = ?"
        );

        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}