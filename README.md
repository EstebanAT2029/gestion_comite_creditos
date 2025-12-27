# 📋 SisComité – Sistema de Comité de Créditos

Sistema web para la **gestión integral de Comités de Créditos**, diseñado para entidades financieras y cooperativas, permitiendo el registro de comités, múltiples casos por comité, riesgo vinculado y la generación automática de **actas oficiales en PDF y Word**.

---

## 🚀 Características Principales

- Registro de **Comités de Crédito**
- Múltiples **casos por comité** con **un solo correlativo**
- Gestión de **Riesgo Vinculado por caso**
- Generación de **Actas en PDF y Word**
- Numeración automática por **Agencia y Año**
- Observaciones extensas por caso (debajo de cada caso)
- Reportes por **Agencia y Zona**
- Exportación de reportes a **Excel**
- Control de sesión y seguridad
- Protección contra ClickJacking (CSP / X-Frame-Options)

---

## 🧱 Arquitectura

- **Patrón:** MVC
- **Backend:** PHP 8.x
- **Base de Datos:** MySQL / MariaDB
- **Frontend:** HTML5, CSS3, Bootstrap 5, JavaScript
- **PDF:** Dompdf
- **Word:** PhpWord
- **Excel:** PhpSpreadsheet

---

## 📂 Estructura del Proyecto

```text
siscomite/
├── app/
│   ├── controllers/
│   ├── models/
│   ├── views/
│   ├── services/
│   └── core/
├── public/
│   ├── assets/
│   ├── js/
│   └── index.php
├── database/
├── vendor/
├── composer.json
├── README.md
├── LICENSE
└── CONTRIBUTING.md

---

## 📄 LICENSE (MIT)

MIT License

Copyright (c) 2025
Ing. Esteban Apaza Ticona

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
