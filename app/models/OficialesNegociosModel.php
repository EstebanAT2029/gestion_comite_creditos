<?php

class OficialesNegociosModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    /* ============================================================
       INSERTAR OFICIAL
    ============================================================ */
    public function insertar($data)
    {
        $sql = "INSERT INTO oficiales_negocios 
                (apellidos, nombres, cargo, id_agencia, estado)
                VALUES (?, ?, ?, ?, 'Activo')";

        $stmt = $this->db->prepare($sql);

        if (!$stmt) {
            throw new Exception("Prepare failed: " . $this->db->error);
        }

        $stmt->bind_param(
            "sssi",
            $data["apellidos"],
            $data["nombres"],
            $data["cargo"],
            $data["id_agencia"]
        );

        if (!$stmt->execute()) {
            throw new Exception("Execute failed: " . $stmt->error);
        }

        return true;
    }


    /* ============================================================
       OBTENER OFICIAL POR ID
    ============================================================ */
    public function getById($id)
    {
        $stmt = $this->db->prepare("
            SELECT 
                o.*, 
                a.nombre_agencia, 
                z.nombre AS zona
            FROM oficiales_negocios o
            INNER JOIN agencia a ON a.id = o.id_agencia
            INNER JOIN zonas z ON z.id = a.id_zona
            WHERE o.id = ?
        ");

        $stmt->bind_param("i", $id);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc();
    }


    /* ============================================================
       LISTAR OFICIALES POR AGENCIA
    ============================================================ */
    public function getByAgencia($idAgencia)
    {
        $stmt = $this->db->prepare("
            SELECT o.*, a.nombre_agencia 
            FROM oficiales_negocios o
            INNER JOIN agencia a ON a.id = o.id_agencia
            WHERE o.id_agencia = ?
            ORDER BY o.apellidos ASC
        ");

        $sql = "
        SELECT 
            o.*,
            a.nombre_agencia
        FROM oficiales_negocios o
        INNER JOIN agencia a ON a.id = o.id_agencia
        WHERE o.id_agencia = ?
        ORDER BY o.apellidos ASC
    ";

        $stmt->bind_param("i", $idAgencia);
        $stmt->execute();

        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    /* ============================================================
       LISTADO FILTRADO POR ZONA Y AGENCIA
    ============================================================ */
    public function filtrarOficiales($zona = null, $agencia = null)
    {
        $sql = "
            SELECT 
                o.*, 
                a.nombre_agencia, 
                z.nombre AS zona
            FROM oficiales_negocios o
            INNER JOIN agencia a ON a.id = o.id_agencia
            INNER JOIN zonas z ON z.id = a.id_zona
            WHERE 1 = 1
        ";

        $params = [];
        $types  = "";

        // ✅ FILTRO POR ZONA (CORREGIDO)
        if (!empty($zona)) {
            $sql .= " AND a.id_zona = ? ";
            $params[] = $zona;
            $types .= "i";
        }

        // ✅ FILTRO POR AGENCIA (OK)
        if (!empty($agencia)) {
            $sql .= " AND o.id_agencia = ? ";
            $params[] = $agencia;
            $types .= "i";
        }

        $sql .= " ORDER BY o.apellidos ASC";

        $stmt = $this->db->prepare($sql);

        if (!empty($params)) {
            $stmt->bind_param($types, ...$params);
        }

        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    /* ============================================================
       CAMBIAR ESTADO (Activo / Inactivo)
    ============================================================ */
    public function cambiarEstado($id, $estado)
    {
        $stmt = $this->db->prepare("UPDATE oficiales_negocios SET estado = ? WHERE id = ?");
        $stmt->bind_param("si", $estado, $id);
        return $stmt->execute();
    }



    /* ============================================================
       VALIDAR DUPLICADO (opcional)
    ============================================================ */
    public function existeOficial($apellidos, $nombres, $agencia)
    {
        $sql = "
            SELECT id 
            FROM oficiales_negocios 
            WHERE apellidos = ? AND nombres = ? AND id_agencia = ?
            LIMIT 1
        ";

        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("ssi", $apellidos, $nombres, $agencia);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc() ? true : false;
    }
}