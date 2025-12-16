<?php
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class ReporteController
{
    private $model;

    public function __construct()
    {
        $this->model = new ReporteModel();
    }

    /**
     * Mostrar formulario de filtros + resultados
     * FILTRADO POR ZONA DEL USUARIO
     */
    public function index()
    {
        requireLogin();

        // 🔐 Zona del usuario logueado
        $idZona = $_SESSION["user"]["id_zona"];

        // Solo agencias de su zona
        $agencias   = $this->model->agencias($idZona);
        $resultados = [];

        if (!empty($_GET["agencia"])) {
            $resultados = $this->model->reportePorAgencia(
                $_GET["agencia"],
                $idZona
            );
        }

        require __DIR__ . "/../views/reportes/reportes.php";
    }

    /**
     * REPORTE GENERAL EXCEL (FILTRADO POR ZONA)
     */
    public function reporteGeneralExcel()
    {
        requireLogin();

        // 🔐 Zona del usuario
        $idZona = $_SESSION["user"]["id_zona"];

        $data = $this->model->reporteGeneral($idZona);

        if (empty($data)) {
            echo "No hay datos para exportar.";
            return;
        }

        // 1. Crear Excel
        $spreadsheet = new Spreadsheet();
        $sheet       = $spreadsheet->getActiveSheet();

        // 2. Encabezados
        $headers = array_keys($data[0]);
        $sheet->fromArray($headers, null, 'A1');

        // 3. Datos
        $row = 2;
        foreach ($data as $fila) {
            $values = [];
            foreach ($headers as $h) {
                $values[] = $fila[$h];
            }
            $sheet->fromArray($values, null, 'A' . $row);
            $row++;
        }

        // 4. Nombre del archivo
        $filename = "Reporte_General_Comite_" . date("Ymd_His") . ".xlsx";

        // 5. Headers HTTP
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header("Content-Disposition: attachment; filename=\"$filename\"");
        header('Cache-Control: max-age=0');
        header('Expires: 0');
        header('Pragma: public');

        // 6. Limpiar buffer
        if (ob_get_length()) {
            ob_end_clean();
        }

        // 7. Descargar
        $writer = new Xlsx($spreadsheet);
        $writer->save('php://output');
        exit;
    }
}