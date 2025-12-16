<?php

class ComiteService
{
    private $model;
    private $detalleModel;
    private $vinculadoModel;

    public function __construct()
    {
        $this->model          = new ComiteModel();
        $this->detalleModel   = new DetalleComiteModel();
        $this->vinculadoModel = new RiesgoVinculadoModel();
    }

    public function guardarComite($data)
    {
        $fecha   = $data["fecha"];
        $hora    = $data["hora"];
        $agencia = $data["agencia"];
        $of1     = $data["oficial1"];
        $of2     = $data["oficial2"];
        $jefe    = $data["jefe_agencia"];
        $casos   = $data["casos"];

        $usuarioId = $_SESSION["user"]["id"];
        $idZona    = $_SESSION["user"]["id_zona"] ?? null;  // zona del usuario logueado

        $numeroCasos = count($casos);

        /* =========================================================
           1. INSERTAR COMITÉ
        ========================================================== */
        $datosComite = [
            "fecha"        => $fecha,
            "hora"         => $hora,
            "numero_casos" => $numeroCasos,
            "id_usuario"   => $usuarioId,
            "id_zona"      => $idZona          // 🔥 lo mandamos SIEMPRE
        ];

        $idComite = $this->model->insertarComite($datosComite);

        if (!$idComite) {
            throw new Exception("Error al registrar comité.");
        }

        $primerDetalle = null;

        /* =========================================================
           2. INSERTAR DETALLES (CASOS)
        ========================================================== */
        foreach ($casos as $c) {

            $anioActual = date("Y");

            // Generar correlativo por agencia/año
            $correlativo = $this->detalleModel->getCorrelativoAgenciaAnio($agencia, $anioActual);
            $correlativo = str_pad($correlativo, 3, "0", STR_PAD_LEFT);

            $idDecision = $this->mapDecision($c["decision"]);

            $idDetalle = $this->detalleModel->insertarDetalle([
                "id_comite"             => $idComite,
                "id_agencia"            => $agencia,
                "correlativo"           => $correlativo,
                "dni"                   => $c["dni"],
                "cadena"                => $c["cadena"],
                "nombres"               => $c["nombres"],
                "monto"                 => $c["monto"],
                "tipo_cli"              => $c["tipo_cli"],
                "tipo_credito"          => $c["tipo_credito"],
                "id_oficial_proponente" => $c["oficial_prop"],
                "id_of1"                => $of1,
                "id_of2"                => $of2,
                "id_jefe_agencia"       => $jefe,
                "id_decision"           => $idDecision,
                "observaciones"         => $c["comentarios"]
            ]);

            if (!$idDetalle) {
                throw new Exception("Error registrando detalle del comité.");
            }

            if ($primerDetalle === null) {
                $primerDetalle = $idDetalle;
            }

            /* =========================================================
               3. Registrar vinculados
            ========================================================== */
            if (!empty($c["vinculados"])) {
                foreach ($c["vinculados"] as $v) {
                    $this->vinculadoModel->insertarVinculado($idDetalle, $v);
                }
            }
        }

        return [
            "id_comite"  => $idComite,
            "id_detalle" => $primerDetalle
        ];
    }

    /* =============================================================
       MAPEAR DECISIÓN
    ============================================================= */
    private function mapDecision($txt)
    {
        $map = [
            "Aprobado"   => 1,
            "Observado"  => 2,
            "Denegado"   => 3
        ];
        return $map[$txt] ?? 1;
    }
}