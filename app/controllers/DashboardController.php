<?php

class DashboardController
{
    public function index()
    {
        requireLogin(); // 🔐 SOLO usuarios autenticados

        require __DIR__ . '/../views/dashboard/dashboard.php';
    }
}