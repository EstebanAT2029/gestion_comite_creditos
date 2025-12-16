<?php

class ComiteModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function insertarComite($data)
    {
        // Nos aseguramos de que existan todas las claves
        $fecha        = $data["fecha"];
        $hora         = $data["hora"];
        $numeroCasos  = $data["numero_casos"];
        $idUsuario    = $data["id_usuario"];
        $idZona       = $data["id_zona"] ?? null;  // puede ser NULL

        // Si tu tabla COMITE tiene la columna id_zona (como en tu screenshot):
        $sql = "INSERT INTO comite (
                    fecha, hora, numero_casos, id_usuario, id_zona
                ) VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->db->prepare($sql);

        if (!$stmt) {
            throw new Exception("Error preparando insertarComite: " . $this->db->error);
        }

        // s = string, i = int
        $stmt->bind_param(
            "ssiii",
            $fecha,
            $hora,
            $numeroCasos,
            $idUsuario,
            $idZona
        );

        if (!$stmt->execute()) {
            throw new Exception("Error ejecutando insertarComite: " . $stmt->error);
        }

        return $stmt->insert_id;
    }

    public function getById($id)
    {
        $sql = "SELECT * FROM comite WHERE id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        return $stmt->get_result()->fetch_assoc();
    }
}