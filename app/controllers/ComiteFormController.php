<?php

class ComiteFormController
{
    /**
     * Mostrar el formulario principal del Comité
     */
    public function showForm()
    {
        // Verificar login
        if (empty($_SESSION['user'])) {
            header("Location: index.php?url=login");
            exit;
        }

        // Cargar la vista
        require __DIR__ . "/../views/comite/form.php";
    }
}