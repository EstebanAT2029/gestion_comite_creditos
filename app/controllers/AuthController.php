<?php

class AuthController
{
    private $model;

    public function __construct()
    {
        $this->model = new AuthModel();
    }

    /* ======================================
       Mostrar formulario LOGIN
    ====================================== */
    public function loginForm()
    {
        require __DIR__ . "/../views/auth/login.php";
    }

    /* ======================================
    Procesar inicio de sesión – SEGURO
    ====================================== */
    public function login()
    {
        // ==============================
        // Sanitizar y validar entrada
        // ==============================
        $usuario  = trim($_POST["usuario"] ?? "");
        $password = trim($_POST["password"] ?? "");

        if ($usuario === "" || $password === "") {
            $_SESSION["login_error"] = "Usuario o contraseña incorrectos.";
            header("Location: index.php?url=login");
            exit;
        }

        // Evitar ataques de fuerza bruta
        if (!isset($_SESSION["login_attempts"])) {
            $_SESSION["login_attempts"] = 0;
        }

        if ($_SESSION["login_attempts"] >= 5) {
            sleep(2); // Anti brute force delay
            $_SESSION["login_error"] = "Demasiados intentos. Intente nuevamente en unos minutos.";
            header("Location: index.php?url=login");
            exit;
        }

        // ==============================
        // Consulta segura al modelo
        // ==============================
        $user = $this->model->login($usuario, $password);

        if (!$user) {
            $_SESSION["login_attempts"]++;
            sleep(1); // Añade delay para ataques automatizados
            $_SESSION["login_error"] = "Usuario o contraseña incorrectos.";
            header("Location: index.php?url=login");
            exit;
        }

        // Resetear intentos fallidos
        $_SESSION["login_attempts"] = 0;

        // ==============================
        // Seguridad de sesión
        // ==============================
        session_regenerate_id(true); // Previene fijación de sesión

        $_SESSION["user"] = [
            "id"        => $user["id"],
            "usuario"   => $user["usuario"],
            "nombres"   => $user["nombres"],
            "apellidos" => $user["apellidos"],
            "rol"       => $user["rol"],
            "id_zona"   => $user["id_zona"]
        ];

        header("Location: index.php?url=dashboard");
        exit;
    }


    /* ======================================
       Cerrar sesión
    ====================================== */
    public function logout()
    {
        session_destroy();
        header("Location: index.php?url=login");
        exit;
    }
}