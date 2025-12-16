<?php

class CatalogoModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    /* ============================================================
       LISTAR AGENCIAS
    ============================================================ */
    public function agencias()
    {
        $sql = "SELECT id, nombre_agencia 
                FROM agencia 
                WHERE estado = 1
                ORDER BY nombre_agencia ASC";

        $res = $this->db->query($sql);
        return $res ? $res->fetch_all(MYSQLI_ASSOC) : [];
    }

    /* ============================================================
       LISTAR OFICIALES POR AGENCIA
    ============================================================ */
    public function oficiales($idAgencia)
    {
        $sql = "SELECT 
                    id,
                    CONCAT(apellidos,' ',nombres) AS nombre
                FROM oficiales_negocios
                WHERE id_agencia = ?
                AND estado = 1
                ORDER BY apellidos ASC";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $idAgencia);
        $stmt->execute();

        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    /* ============================================================
       LISTAR JEFES POR AGENCIA
    ============================================================ */
    public function jefes($idAgencia)
    {
        $sql = "SELECT 
                    id,
                    CONCAT(apellidos,' ',nombres) AS nombre
                FROM jefes_agencia
                WHERE id_agencia = ?
                ORDER BY apellidos ASC";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $idAgencia);
        $stmt->execute();

        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
}