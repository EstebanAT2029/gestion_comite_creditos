<?php

class AgenciaModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    /* =====================================================
       LISTAR AGENCIAS
    ===================================================== */
    public function listar()
    {
        $sql = "
            SELECT a.id, a.nombre_agencia, z.nombre AS zona
            FROM agencias a
            INNER JOIN zonas z ON a.id_zona = z.id
            ORDER BY a.nombre_agencia ASC
        ";

        return $this->db->query($sql)->fetch_all(MYSQLI_ASSOC);
    }

    /* =====================================================
       OBTENER AGENCIA POR ID
    ===================================================== */
    public function getById($id)
    {
        $sql = "
            SELECT a.*, z.nombre AS zona
            FROM agencia a
            INNER JOIN zonas z ON a.id_zona = z.id
            WHERE a.id = ?
        ";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $id);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc();
    }

    /* =====================================================
       LISTAR ZONAS (PARA COMBO)
    ===================================================== */
    public function getZonas()
    {
        $sql = "
            SELECT id, nombre
            FROM zonas
            ORDER BY nombre
        ";

        return $this->db->query($sql)->fetch_all(MYSQLI_ASSOC);
    }

    /* =====================================================
       AGENCIAS POR ZONA
    ===================================================== */
    public function getByZona($idZona)
    {
        $sql = "
            SELECT id, nombre_agencia
            FROM agencia
            WHERE id_zona = ?
            ORDER BY nombre_agencia
        ";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $idZona);
        $stmt->execute();

        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
}