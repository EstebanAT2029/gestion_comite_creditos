<?php

class AuthModel
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function login($usuario, $password)
    {
        // =========================================
        // Sanitizar y normalizar
        // =========================================
        $usuario = trim(strtolower($usuario)); // evita ataques por mayúsculas
        $password = trim($password);

        if ($usuario === "" || $password === "") {
            return false;
        }

        // =========================================
        // Consulta segura — SOLO usuario
        // No revelamos si usuario existe
        // =========================================
        $sql = "SELECT id, usuario, nombres, apellidos, password, rol, estado, id_zona
                FROM usuarios 
                WHERE usuario = ? AND estado = 1
                LIMIT 1";

        $stmt = $this->db->prepare($sql);
        if (!$stmt) return false;

        $stmt->bind_param("s", $usuario);
        $stmt->execute();
        $result = $stmt->get_result();

        // Si no existe usuario → timing attack protection
        if ($result->num_rows === 0) {
            // Comparación falsa para evitar detectar tiempos diferentes
            password_verify($password, password_hash("dummy_password", PASSWORD_BCRYPT));
            return false;
        }

        $user = $result->fetch_assoc();

        // =========================================
        // Verificar estado del usuario
        // =========================================
        if ($user["estado"] != 1) {
            return false; // usuario inactivo no puede ingresar
        }

        // =========================================
        // Verificación segura de contraseña (bcrypt)
        // =========================================
        if (!password_verify($password, $user["password"])) {
            return false;
        }

        // Cerrar recursos
        $stmt->close();

        return $user;
    }
}