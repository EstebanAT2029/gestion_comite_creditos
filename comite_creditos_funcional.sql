-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-12-2025 a las 17:37:22
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `comite_creditos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agencia`
--

CREATE TABLE `agencia` (
  `id` int(11) NOT NULL,
  `nombre_agencia` varchar(100) NOT NULL,
  `clasificacion_agencia` varchar(50) DEFAULT NULL,
  `id_zona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `agencia`
--

INSERT INTO `agencia` (`id`, `nombre_agencia`, `clasificacion_agencia`, `id_zona`) VALUES
(1, 'Ilave', 'A', 2),
(2, 'Sicuani', 'B', 2),
(3, 'Puerto Maldonado', 'A', 2),
(4, 'Cusco', 'C', 2),
(5, 'Quillabamba', 'C', 2),
(6, 'Puno', 'A', 2),
(7, 'Ayaviri', 'B', 2),
(8, 'Arequipa', 'C', 1),
(9, 'Irrigación Majes', 'A', 1),
(10, 'Camaná', 'C', 1),
(11, 'Tacna', 'A', 1),
(12, 'Moquegua', 'B', 1),
(13, 'Andahuaylas', 'C', 2),
(14, 'Abancay', 'A', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `cadena` varchar(20) DEFAULT NULL,
  `dni` varchar(15) NOT NULL,
  `nombres_apellidos` varchar(150) NOT NULL,
  `clasificacion_cliente` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comite`
--

CREATE TABLE `comite` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_zona` int(11) DEFAULT NULL,
  `numero_casos` int(11) NOT NULL,
  `fecha_registro` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comite`
--

INSERT INTO `comite` (`id`, `fecha`, `hora`, `id_usuario`, `id_zona`, `numero_casos`, `fecha_registro`) VALUES
(1, '2025-12-09', '15:28:00', 1, NULL, 1, '2025-12-09 14:28:57'),
(2, '2025-12-09', '15:29:00', 1, NULL, 1, '2025-12-09 14:31:11'),
(3, '2025-12-09', '15:41:00', 1, NULL, 1, '2025-12-09 14:42:11'),
(4, '2025-12-09', '15:43:00', 1, NULL, 1, '2025-12-09 14:43:39'),
(5, '2025-12-09', '15:48:00', 1, NULL, 1, '2025-12-09 14:50:05'),
(6, '2025-12-09', '16:02:00', 1, NULL, 1, '2025-12-09 15:03:07'),
(7, '2025-12-09', '16:08:00', 1, NULL, 1, '2025-12-09 15:08:45'),
(8, '2025-12-09', '16:09:00', 1, NULL, 1, '2025-12-09 15:10:01'),
(9, '2025-12-09', '16:16:00', 1, NULL, 1, '2025-12-09 15:16:38'),
(10, '2025-12-09', '16:23:00', 1, NULL, 1, '2025-12-09 15:24:11'),
(11, '2025-12-09', '19:52:00', 1, NULL, 1, '2025-12-09 18:54:45'),
(12, '2025-12-10', '17:43:00', 5, 2, 1, '2025-12-10 16:43:37'),
(13, '2025-12-10', '17:43:00', 5, 2, 1, '2025-12-10 16:53:39'),
(14, '2025-12-10', '18:35:00', 5, 2, 2, '2025-12-10 17:35:57'),
(15, '2025-12-10', '18:38:00', 5, 2, 1, '2025-12-10 17:39:01'),
(16, '2025-12-10', '20:07:00', 5, 2, 1, '2025-12-10 19:07:49'),
(17, '2025-12-11', '03:34:00', 5, 2, 2, '2025-12-11 02:35:25'),
(18, '2025-12-11', '03:44:00', 5, 2, 2, '2025-12-11 02:45:07'),
(19, '2025-12-11', '04:26:00', 5, 2, 1, '2025-12-11 03:27:43'),
(20, '2025-12-11', '04:36:00', 5, 2, 1, '2025-12-11 03:36:21'),
(21, '2025-12-11', '04:37:00', 5, 2, 1, '2025-12-11 03:37:53'),
(22, '2025-12-11', '04:42:00', 5, 2, 1, '2025-12-11 03:43:11'),
(23, '2025-12-11', '04:49:00', 5, 2, 1, '2025-12-11 03:50:01'),
(24, '2025-12-11', '04:49:00', 5, 2, 1, '2025-12-11 03:50:19'),
(25, '2025-12-11', '04:51:00', 5, 2, 1, '2025-12-11 03:51:28'),
(26, '2025-12-11', '04:51:00', 5, 2, 1, '2025-12-11 03:52:27'),
(27, '2025-12-11', '04:59:00', 5, 2, 1, '2025-12-11 04:00:47'),
(28, '2025-12-11', '05:07:00', 5, 2, 1, '2025-12-11 04:08:29'),
(29, '2025-12-11', '05:10:00', 5, 2, 1, '2025-12-11 04:10:21'),
(30, '2025-12-11', '05:14:00', 5, 2, 1, '2025-12-11 04:14:28'),
(31, '2025-12-11', '05:14:00', 5, 2, 1, '2025-12-11 04:14:59'),
(32, '2025-12-11', '14:42:00', 5, 2, 1, '2025-12-11 13:43:20'),
(33, '2025-12-11', '15:03:00', 5, 2, 1, '2025-12-11 14:04:13'),
(34, '2025-12-11', '15:26:00', 5, 2, 1, '2025-12-11 14:27:45'),
(35, '2025-12-11', '15:55:00', 5, 2, 1, '2025-12-11 14:55:48'),
(36, '2025-12-11', '17:30:00', 5, 2, 2, '2025-12-11 16:33:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comite_modalidad`
--

CREATE TABLE `comite_modalidad` (
  `id` int(11) NOT NULL,
  `id_comite` int(11) NOT NULL,
  `id_detalle_comite` int(11) NOT NULL,
  `tipo_comite` enum('Presencial','Virtual','Semipresencial') DEFAULT NULL,
  `modalidad_proponente` enum('Presencial','Virtual') DEFAULT NULL,
  `modalidad_participante1` enum('Presencial','Virtual') DEFAULT NULL,
  `modalidad_participante2` enum('Presencial','Virtual') DEFAULT NULL,
  `modalidad_jefe` enum('Presencial','Virtual') DEFAULT NULL,
  `modalidad_riesgo` enum('Presencial','Virtual') DEFAULT NULL,
  `id_usuario_registro` int(11) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comite_modalidad`
--

INSERT INTO `comite_modalidad` (`id`, `id_comite`, `id_detalle_comite`, `tipo_comite`, `modalidad_proponente`, `modalidad_participante1`, `modalidad_participante2`, `modalidad_jefe`, `modalidad_riesgo`, `id_usuario_registro`, `fecha_registro`) VALUES
(1, 1, 1, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 1, '2025-12-09 09:29:02'),
(2, 2, 2, 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 1, '2025-12-09 09:31:16'),
(3, 3, 3, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 1, '2025-12-09 09:42:16'),
(4, 4, 4, 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 1, '2025-12-09 09:43:44'),
(5, 5, 5, 'Semipresencial', 'Virtual', 'Presencial', 'Virtual', 'Presencial', 'Virtual', 1, '2025-12-09 09:50:11'),
(6, 6, 6, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 1, '2025-12-09 10:03:11'),
(7, 7, 7, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 1, '2025-12-09 10:08:49'),
(8, 8, 8, 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 1, '2025-12-09 10:10:05'),
(9, 9, 9, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 1, '2025-12-09 10:16:43'),
(10, 10, 10, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 1, '2025-12-09 10:24:18'),
(11, 11, 11, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 1, '2025-12-09 13:54:49'),
(12, 13, 12, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 11:53:43'),
(13, 14, 13, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 12:36:01'),
(14, 15, 15, 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 5, '2025-12-10 12:39:05'),
(15, 16, 16, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 14:07:53'),
(16, 17, 17, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 21:35:30'),
(17, 18, 19, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 21:45:10'),
(18, 19, 21, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 22:27:48'),
(19, 20, 22, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 22:36:27'),
(20, 21, 23, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 22:37:57'),
(21, 22, 24, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 22:43:17'),
(22, 24, 26, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 22:50:25'),
(23, 26, 28, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 22:52:40'),
(24, 27, 29, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 23:00:53'),
(25, 28, 30, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 23:08:39'),
(26, 29, 31, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 23:13:52'),
(27, 30, 32, 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 5, '2025-12-10 23:14:34'),
(28, 31, 33, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-10 23:15:11'),
(29, 32, 34, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-11 08:43:28'),
(30, 33, 35, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-11 09:04:17'),
(31, 34, 36, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-11 09:27:50'),
(32, 35, 37, 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 'Presencial', 5, '2025-12-11 09:55:52'),
(33, 36, 38, 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 'Virtual', 5, '2025-12-11 11:33:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `decision`
--

CREATE TABLE `decision` (
  `id` int(11) NOT NULL,
  `descripcion` enum('Aprobado','Observado','Denegado') NOT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `decision`
--

INSERT INTO `decision` (`id`, `descripcion`, `observaciones`) VALUES
(1, 'Aprobado', NULL),
(2, 'Observado', NULL),
(3, 'Denegado', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_comite`
--

CREATE TABLE `detalle_comite` (
  `id` int(11) NOT NULL,
  `id_comite` int(11) NOT NULL,
  `correlativo` int(11) NOT NULL,
  `id_agencia` int(11) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `cadena` varchar(20) NOT NULL,
  `nombres` varchar(150) NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `tipo_cli` varchar(40) NOT NULL,
  `tipo_credito` varchar(100) DEFAULT NULL,
  `id_oficial_proponente` int(11) NOT NULL,
  `id_oficial_participante1` int(11) NOT NULL,
  `id_oficial_participante2` int(11) NOT NULL,
  `id_jefe_agencia` int(11) NOT NULL,
  `id_decision` int(11) NOT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_comite`
--

INSERT INTO `detalle_comite` (`id`, `id_comite`, `correlativo`, `id_agencia`, `dni`, `cadena`, `nombres`, `monto`, `tipo_cli`, `tipo_credito`, `id_oficial_proponente`, `id_oficial_participante1`, `id_oficial_participante2`, `id_jefe_agencia`, `id_decision`, `observaciones`, `fecha_registro`, `fecha_actualizacion`) VALUES
(1, 1, 1, 14, '46679237', '425378', 'APAZA TICONA ESTEBAN', 4500.00, 'B', 'AGRICOLA', 1, 4, 1, 1, 1, 'SIN COMENTARIOS', '2025-12-09 14:28:57', '2025-12-09 14:28:57'),
(2, 2, 1, 13, '01258764', '4272872', 'APAZA COLQUE FELIX VENNACION', 4500.00, 'B', 'ENGORDE GANADO', 52, 51, 50, 2, 1, 'SIN COMENTARIOS DE LA MORGUES ANCIONALES DEL PERU EN SU MOMENTO', '2025-12-09 14:31:11', '2025-12-09 14:31:11'),
(3, 3, 2, 13, '46679237', '42565', 'ESTEBAN APAZA COLQUE', 12.00, 'B', 'AGRICOLA', 54, 51, 54, 2, 1, 'DEBE JUSTIFICAR SUS PROPIEDADES MANCOMUNADAS DE LOS GERENTES DEPORTIVO', '2025-12-09 14:42:11', '2025-12-09 14:42:11'),
(4, 4, 3, 13, '452345763', '233223', 'SDFGH SDFGHSD SDSDSDSD', 34568.00, 'B', 'WSDSDSDSD', 51, 54, 49, 2, 1, 'SDCSD SDCSD SDCSD SDCSD SDCSD SDCSD SDCSD SDCSD SDCSD SDCSD SDCSD', '2025-12-09 14:43:39', '2025-12-09 14:43:39'),
(5, 5, 2, 14, '45677544', '423533', 'MENESES CHUQUIRIMAY BERNADO SILVA', 12.00, 'B', 'AGRICOLA', 3, 1, 3, 1, 1, 'COMENTARISOI VAN DEBAJO DE LOS TALLERE DE COMERCIALIZACION', '2025-12-09 14:50:05', '2025-12-09 14:50:05'),
(6, 6, 4, 13, '466679238', '42536783', 'APAZA TICONA SEBASTIAN ALFEREZ', 12.00, 'B', 'AGRICOLA', 51, 54, 50, 2, 1, 'COMENTRIOS SIN COMENTARIOS NO HABRUA RAZONDE SEGURI EN ESTA VIDA COTIDINA', '2025-12-09 15:03:07', '2025-12-09 15:03:07'),
(7, 7, 5, 13, '454', '545', '4545', 454.00, '545', '4545', 51, 50, 54, 2, 1, '45', '2025-12-09 15:08:45', '2025-12-09 15:08:45'),
(8, 8, 3, 14, '45454', '545', '454545', 545.00, '454', '54', 1, 1, 3, 1, 1, '4545', '2025-12-09 15:10:01', '2025-12-09 15:10:01'),
(9, 9, 6, 13, '46678723', '345323', 'APAZA TICONA ESTEBAN AOAZA', 234786.00, 'B', 'AGRICOLA', 50, 50, 52, 2, 1, 'ESTEBAN APAZA CON ELS R DE LO SNATOS D MARIA TERESA', '2025-12-09 15:16:38', '2025-12-09 15:16:38'),
(10, 10, 4, 14, '343434', '34', '3434444444', 3434343.00, '4343', '4343', 4, 4, 1, 1, 1, '4434444444444 3434444444434 434343 43 3343434 3', '2025-12-09 15:24:11', '2025-12-09 15:24:11'),
(11, 11, 5, 14, '455678923', '43523', 'ESTEBAN PAZA TICONA SEBASTIAN', 12000.00, 'B', 'CREDITO AGRICOLA', 1, 4, 3, 1, 1, 'Construyo la fila con concatenación, evitando mezclar variables y HTML en una sola cadena gigante. htmlspecialchars para que caracteres raros no rompan el HTML', '2025-12-09 18:54:45', '2025-12-09 18:54:45'),
(12, 13, 6, 14, '34343434', '3434', '34346767', 6767.00, '676767', '676767', 1, 4, 3, 1, 1, '6767', '2025-12-10 16:53:39', '2025-12-10 16:53:39'),
(13, 14, 7, 14, '3434', '34', '343', 34.00, '34', '34', 1, 1, 6, 1, 1, '4', '2025-12-10 17:35:57', '2025-12-10 17:35:57'),
(14, 14, 8, 14, '34', '343', '43', 34.00, '4', '34', 1, 1, 6, 1, 1, '43', '2025-12-10 17:35:57', '2025-12-10 17:35:57'),
(15, 15, 9, 14, '3434', '34', '34', 34.00, '34343', '434', 1, 4, 3, 1, 1, '34', '2025-12-10 17:39:01', '2025-12-10 17:39:01'),
(16, 16, 10, 14, '44444444444', '44444', '444444444444  444444 4444444', 4444.00, '44', '44', 1, 4, 6, 1, 1, '444 4 44 4 444 4 4444444 4 44 44 44 44', '2025-12-10 19:07:49', '2025-12-10 19:07:49'),
(17, 17, 11, 14, '34', '34', '34', 34.00, '34', '34', 1, 4, 3, 1, 1, '34', '2025-12-11 02:35:25', '2025-12-11 02:35:25'),
(18, 17, 12, 14, '34', '34', '', 34.00, '34', '34', 5, 4, 3, 1, 1, '34', '2025-12-11 02:35:25', '2025-12-11 02:35:25'),
(19, 18, 13, 14, '3434', '34341212', '1212', 1212.00, '212', '12121', 6, 4, 1, 1, 1, '1212', '2025-12-11 02:45:07', '2025-12-11 02:45:07'),
(20, 18, 14, 14, '121212', '1212', '1212', 1212.00, '12', '12', 6, 4, 1, 1, 1, '1212', '2025-12-11 02:45:07', '2025-12-11 02:45:07'),
(21, 19, 7, 13, '323', '2323', 'ESTEBAN APAZA', 2300.00, 'B', 'AGRICOLA', 52, 50, 54, 2, 1, '', '2025-12-11 03:27:43', '2025-12-11 03:27:43'),
(22, 20, 8, 13, '1', '1', '1', 1.00, '1', '1', 49, 54, 50, 2, 1, '1', '2025-12-11 03:36:22', '2025-12-11 03:36:22'),
(23, 21, 15, 14, '1234567', '4556765', 'APAZA TICONA', 3000.00, 'B', 'B', 3, 1, 6, 1, 1, '', '2025-12-11 03:37:53', '2025-12-11 03:37:53'),
(24, 22, 16, 14, '4667023', '4321', 'APAZA TICONA ESTEBAN', 0.00, 'B', '', 6, 4, 3, 1, 1, '', '2025-12-11 03:43:12', '2025-12-11 03:43:12'),
(26, 24, 9, 13, '2323233', '23', '23', 23.00, '23', '23', 50, 51, 49, 2, 1, '', '2025-12-11 03:50:19', '2025-12-11 03:50:19'),
(28, 26, 10, 13, '46343444', '3444444444444', '4443444444444444', 3434.00, '34', '34', 50, 51, 49, 2, 1, '3434', '2025-12-11 03:52:27', '2025-12-11 03:52:27'),
(29, 27, 17, 14, '2323', '2323', 'ESTEBAN', 3200.00, '43222', 'VE', 1, 4, 3, 1, 1, '', '2025-12-11 04:00:47', '2025-12-11 04:00:47'),
(30, 28, 11, 13, '46679348', '4223', 'ESTEBAN APAZA', 3000.00, 'B', 'AGRICOLA', 49, 54, 51, 2, 1, '', '2025-12-11 04:08:29', '2025-12-11 04:08:29'),
(31, 29, 18, 14, '', '', '', 0.00, '', '', 6, 4, 1, 1, 1, '', '2025-12-11 04:10:21', '2025-12-11 04:10:21'),
(32, 30, 12, 13, '46679834', '3434', 'DFSD', 423.00, '23', '23', 49, 51, 50, 2, 1, '', '2025-12-11 04:14:28', '2025-12-11 04:14:28'),
(33, 31, 19, 14, '23', '23', '23', 0.00, '23', '23', 4, 1, 3, 1, 1, '23', '2025-12-11 04:14:59', '2025-12-11 04:14:59'),
(34, 32, 20, 14, '46679239', '43298', 'ESTEBAN APAZA', 3200.00, 'B', 'AGRICOLA', 4, 1, 3, 1, 1, '', '2025-12-11 13:43:20', '2025-12-11 13:43:20'),
(35, 33, 21, 14, '44667983', '42736', 'ESTEBAN APAZA TICONA', 4300.00, 'B', 'AGRICOLA', 4, 1, 3, 1, 1, 'CON COMENTARIOS', '2025-12-11 14:04:13', '2025-12-11 14:04:13'),
(36, 34, 22, 14, '46672932', '4322', 'ESTEBAN APAZA', 23000.00, '4239', 'VRES', 6, 4, 1, 1, 1, 'SIN COMENATRIOS', '2025-12-11 14:27:45', '2025-12-11 14:27:45'),
(37, 35, 23, 14, '33456765', '2334', '2DFSDERDDFDF', 239898.00, 'B', 'RTRT', 3, 4, 1, 1, 1, 'ESTEBA', '2025-12-11 14:55:48', '2025-12-11 14:55:48'),
(38, 36, 24, 14, '46679237', '42387', 'ESTEBAN APAZA TICONA', 34000.00, 'B', 'AGRICOLA', 3, 4, 1, 1, 1, 'SIN COMENTARIOS', '2025-12-11 16:33:20', '2025-12-11 16:33:20'),
(39, 36, 25, 14, '01258765', '4323', 'JUAN TORRES LUNA DE MIEL', 3400.00, 'B', 'AGRICOLA', 6, 4, 1, 1, 1, 'COMENTARIOS', '2025-12-11 16:33:20', '2025-12-11 16:33:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jefes_agencia`
--

CREATE TABLE `jefes_agencia` (
  `id` int(11) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `id_agencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `jefes_agencia`
--

INSERT INTO `jefes_agencia` (`id`, `apellidos`, `nombres`, `id_agencia`) VALUES
(1, 'Sanchez Pariona', 'Juan', 14),
(2, 'Velasque Calderon', 'Daniel', 13),
(3, 'Gutierrez Acho', 'Wilber', 1),
(4, 'Mamani Ticona', 'Guiovani Concepcion', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oficiales_negocios`
--

CREATE TABLE `oficiales_negocios` (
  `id` int(11) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `id_agencia` int(11) NOT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `oficiales_negocios`
--

INSERT INTO `oficiales_negocios` (`id`, `apellidos`, `nombres`, `cargo`, `id_agencia`, `estado`) VALUES
(1, 'Sanchez Camacho', 'Carlos', 'Oficial', 14, 'Activo'),
(2, 'Ticona', 'Jeramil', 'Oficial', 14, 'Inactivo'),
(3, 'Sanchez Salcedo', 'Luis', 'Oficial', 14, 'Activo'),
(4, 'Chipa Pineda', 'Mary', 'Oficial', 14, 'Activo'),
(5, 'Valenzuela Juro', 'Roy', 'Oficial', 14, 'Activo'),
(6, 'Tomaylla Salazar', 'Yerson', 'Oficial', 14, 'Activo'),
(7, 'Barreda', 'Alex', 'Oficial', 8, 'Activo'),
(8, 'Obando Benavente', 'Alfredo', 'Oficial', 8, 'Activo'),
(9, 'Caceres Ccama', 'Danny', 'Oficial', 8, 'Activo'),
(10, 'Chavez', 'Donny', 'Oficial', 8, 'Activo'),
(11, 'Maquito Cotrina', 'Ivan', 'Oficial', 8, 'Activo'),
(12, 'Torres Pacheco', 'Jose', 'Oficial', 8, 'Activo'),
(13, 'Neira Riveros', 'Miguel', 'Oficial', 8, 'Activo'),
(14, 'Jordan Acosta', 'Rubaly', 'Oficial', 8, 'Activo'),
(15, 'Garcia', 'Sherily', 'Oficial', 8, 'Activo'),
(16, 'Mendoza Gutierrez', 'Buddy', 'Oficial', 4, 'Activo'),
(17, 'Pari Jalisto', 'Cesar', 'Oficial', 4, 'Activo'),
(18, 'Cornejo Mendiguru', 'Erika', 'Oficial', 4, 'Activo'),
(19, 'Puma Huaman', 'Erwin', 'Oficial', 4, 'Activo'),
(20, 'Farfan Huillca', 'Jersson', 'Oficial', 4, 'Activo'),
(21, 'Jaimes Cruz', 'Jessica', 'Oficial', 4, 'Activo'),
(22, 'Bellota', 'Jesus', 'Oficial', 4, 'Activo'),
(23, 'Roque Suni', 'Jhosmer', 'Oficial', 4, 'Activo'),
(24, 'Huaman Caceres', 'Jorge', 'Oficial', 4, 'Activo'),
(25, 'Jara Carbajal', 'Jose', 'Oficial', 4, 'Activo'),
(26, 'Huillca', 'Judith', 'Oficial', 4, 'Activo'),
(27, 'Cruz Jordan', 'Ronald', 'Oficial', 4, 'Activo'),
(28, 'Mamani Alencastre', 'Walter', 'Oficial', 4, 'Activo'),
(29, 'Mamani', 'Zeida', 'Oficial', 4, 'Activo'),
(30, 'Chambilla Chuquimamani', 'Blanca', 'Oficial', 1, 'Activo'),
(31, 'Mayta Quisca', 'Edwin', 'Oficial', 1, 'Activo'),
(32, 'Vasquez Maye', 'Fernando', 'Oficial', 1, 'Activo'),
(33, 'Mamani', 'Henry', 'Oficial', 1, 'Activo'),
(34, 'Maquera Incacutipa', 'Ruth', 'Oficial', 1, 'Activo'),
(35, 'Ayunta Maquera', 'Sonia', 'Oficial', 1, 'Activo'),
(36, 'Contreras Cutipa', 'Yhony', 'Oficial', 1, 'Activo'),
(37, 'Peralta Barreda', 'Cristhian', 'Oficial', 9, 'Activo'),
(38, 'Bellido Calderon', 'Joe', 'Oficial', 9, 'Activo'),
(39, 'Marquez Espinoza', 'Jose', 'Oficial', 9, 'Activo'),
(40, 'Moran Condo', 'Manuel', 'Oficial', 9, 'Activo'),
(41, 'Gonzales Checco', 'Maryori', 'Oficial', 9, 'Activo'),
(42, 'Ayqui Velarde', 'Ronal', 'Oficial', 9, 'Activo'),
(43, 'Medina Umeres', 'Saul', 'Oficial', 9, 'Activo'),
(44, 'Claros Mamani', 'Bettsy', 'Oficial', 12, 'Activo'),
(45, 'Meza Jarufe', 'Dante', 'Oficial', 12, 'Activo'),
(46, 'Oliveira Del Castillo', 'Luis', 'Oficial', 12, 'Activo'),
(47, 'Perez Alvarez', 'Victor', 'Oficial', 12, 'Activo'),
(48, 'Ccaso Quispe', 'Eloy', 'Oficial', 12, 'Activo'),
(49, 'Vargas Cartolin', 'Adel', 'Oficial', 13, 'Activo'),
(50, 'Juarez Hurtado', 'Carlos', 'Oficial', 13, 'Activo'),
(51, 'Ccochayhua Fierro', 'Edith', 'Oficial', 13, 'Activo'),
(52, 'Vilchez Carrion', 'Jose', 'Oficial', 13, 'Activo'),
(53, 'Villanueva Manuico', 'Juan', 'Oficial', 13, 'Activo'),
(54, 'Acuna Ortiz', 'William', 'Oficial', 13, 'Activo'),
(55, 'Apaza Quispe', 'Aldo', 'Oficial', 7, 'Activo'),
(56, 'Taype Guzman', 'Gavi', 'Oficial', 7, 'Activo'),
(57, 'Ccahua Callo', 'Jose', 'Oficial', 7, 'Activo'),
(58, 'Huanacuni', 'Juan', 'Oficial', 7, 'Activo'),
(59, 'Charaña Balda', 'Julio', 'Oficial', 7, 'Activo'),
(60, 'Porto Quispe', 'Karen', 'Oficial', 7, 'Activo'),
(61, 'Goyzueta Hancco', 'Leonel', 'Oficial', 7, 'Activo'),
(62, 'Vilca Machaca', 'Lucio', 'Oficial', 7, 'Activo'),
(63, 'Ticona Castillo', 'Luz', 'Oficial', 7, 'Activo'),
(64, 'Layme Ortiz', 'Maribel', 'Oficial', 7, 'Activo'),
(65, 'Calcina Cutipa', 'Nayda', 'Oficial', 7, 'Activo'),
(66, 'Valero Condori', 'Richard', 'Oficial', 7, 'Activo'),
(67, 'Quellcca Onofre', 'Roberto', 'Oficial', 7, 'Activo'),
(68, 'Diaz Ccahuaya', 'Rosa', 'Oficial', 7, 'Activo'),
(69, 'Condori Quilla', 'Synthia', 'Oficial', 7, 'Activo'),
(70, 'Choque Hito', 'Elder', 'Oficial', 3, 'Activo'),
(71, 'Pereira Sanchez', 'Gary', 'Oficial', 3, 'Activo'),
(72, 'Bautista Pauccar', 'Milagros', 'Oficial', 3, 'Activo'),
(73, 'Mendoza Ccahuantico', 'Veronica', 'Oficial', 3, 'Activo'),
(74, 'Quea', 'Alejo', 'Oficial', 6, 'Activo'),
(75, 'Cari Cari', 'Eber', 'Oficial', 6, 'Activo'),
(76, 'Chique Mamani', 'Edwin', 'Oficial', 6, 'Activo'),
(77, 'Ajalla Laura', 'Edwin', 'Oficial', 6, 'Activo'),
(78, 'Quispe Condori', 'Erika', 'Oficial', 6, 'Activo'),
(79, 'Ayna Flores', 'Gil', 'Oficial', 6, 'Activo'),
(80, 'Chambi Condori', 'Hector', 'Oficial', 6, 'Activo'),
(81, 'Flores Encinas', 'Irvin', 'Oficial', 6, 'Activo'),
(82, 'Rojas Apaza', 'Jhonatan', 'Oficial', 6, 'Activo'),
(83, 'Pari Pacheco', 'Jorge', 'Oficial', 6, 'Activo'),
(84, 'Maquera', 'Jose', 'Oficial', 6, 'Activo'),
(85, 'Livisi Calcina', 'Lislam', 'Oficial', 6, 'Activo'),
(86, 'Layme Mita', 'Litmer', 'Oficial', 6, 'Activo'),
(87, 'Jilaja Apaza', 'Nancy', 'Oficial', 6, 'Activo'),
(88, 'Colque Botetano', 'Orion', 'Oficial', 6, 'Activo'),
(89, 'Guerra As.Com.', 'Sergio', 'Oficial', 6, 'Activo'),
(90, 'Mamani Adco', 'Yaneth', 'Oficial', 6, 'Activo'),
(91, 'Chacon Maquera', 'Yemira', 'Oficial', 6, 'Activo'),
(92, 'Calla Huanca', 'Dessiree', 'Oficial', 5, 'Activo'),
(93, 'Garate Tinta', 'Gilmar', 'Oficial', 5, 'Activo'),
(94, 'Taipe Vivanco', 'Henry', 'Oficial', 5, 'Activo'),
(95, 'Paquillo Roque', 'Raul', 'Oficial', 5, 'Activo'),
(96, 'Apaza Huaman', 'Ruth', 'Oficial', 5, 'Activo'),
(97, 'Huaman', 'Thobin', 'Oficial', 5, 'Activo'),
(98, 'Checya Silva', 'Waldir', 'Oficial', 5, 'Activo'),
(99, 'Candia Alanocca', 'Yeral', 'Oficial', 5, 'Activo'),
(100, 'Huayta Aquino', 'Beltran', 'Oficial', 2, 'Activo'),
(101, 'Flores Huaracha', 'Danny', 'Oficial', 2, 'Activo'),
(102, 'Mamani Quiñonez', 'Elmer', 'Oficial', 2, 'Activo'),
(103, 'Parhuayo Puma', 'Julio', 'Oficial', 2, 'Activo'),
(104, 'Tesillo Mita', 'Ana', 'Oficial', 11, 'Activo'),
(105, 'Huanacuni Mamani', 'Cinthya', 'Oficial', 11, 'Activo'),
(106, 'Aguilar Ramos', 'Danitza', 'Oficial', 11, 'Activo'),
(107, 'Choquehuanca', 'Edgar', 'Oficial', 11, 'Activo'),
(108, 'Caso Asis.Comer.Tarata', 'Efrain', 'Oficial', 11, 'Activo'),
(109, 'Zevallos Zegarra', 'Giovanni', 'Oficial', 11, 'Activo'),
(110, 'De La', 'Henry', 'Oficial', 11, 'Activo'),
(111, 'Hurtado Mamani', 'Heydi', 'Oficial', 11, 'Activo'),
(112, 'Ccallo Bustamante', 'Jaime', 'Oficial', 11, 'Activo'),
(113, 'Cardenas Quenta', 'Lennon', 'Oficial', 11, 'Activo'),
(114, 'Alejo Alanoca', 'Luz', 'Oficial', 11, 'Activo'),
(115, 'Conde Paniagua', 'Milagros', 'Oficial', 11, 'Activo'),
(116, 'Espinoza Paco', 'Pablo', 'Oficial', 11, 'Activo'),
(117, 'Pari Apaza', 'Valois', 'Oficial', 11, 'Activo'),
(118, 'Chipana Quispe', 'Diana', 'Oficial', 10, 'Activo'),
(119, 'Cruz Vargas', 'Jazmin', 'Oficial', 10, 'Activo'),
(120, 'Lopez Diaz', 'Oliver', 'Oficial', 10, 'Activo'),
(121, 'Coaguila Choque', 'Rogelio', 'Oficial', 10, 'Activo'),
(122, 'Ramirez Carrasco', 'Victor', 'Oficial', 10, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `riesgo_vinculado`
--

CREATE TABLE `riesgo_vinculado` (
  `id` int(11) NOT NULL,
  `id_detalle_comite` int(11) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `apellidos` varchar(150) NOT NULL,
  `nombres` varchar(150) NOT NULL,
  `grado_consanguinidad` varchar(100) NOT NULL,
  `domicilio_si` enum('Sí','No') DEFAULT NULL,
  `domicilio_texto` varchar(200) DEFAULT NULL,
  `actividad_si` enum('Sí','No') DEFAULT NULL,
  `actividad_texto` varchar(200) DEFAULT NULL,
  `predio_si` enum('Sí','No') DEFAULT NULL,
  `predio_texto` varchar(200) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `riesgo_vinculado`
--

INSERT INTO `riesgo_vinculado` (`id`, `id_detalle_comite`, `dni`, `apellidos`, `nombres`, `grado_consanguinidad`, `domicilio_si`, `domicilio_texto`, `actividad_si`, `actividad_texto`, `predio_si`, `predio_texto`, `fecha_registro`) VALUES
(1, 2, '46679238', 'APAZA TICONA', 'ESTEBAN', 'Segundo Grado', 'Sí', '46670239', 'Sí', 'ENGORDE DE GANADO', 'Sí', 'PREDIO COMPARTIDO', '2025-12-09 14:31:11'),
(2, 11, '466789034', 'APAZA LOPEZ', 'GERONIMO', 'Segundo Grado', 'Sí', 'Jr Ilo E-04 Puno', 'Sí', 'KAKINGORA', 'Sí', 'COMUNIDAD CAMPESINA', '2025-12-09 18:54:45'),
(3, 15, '34', '34', '3434', 'Segundo Grado', 'No', '3434', 'No', '3434', 'No', '3434', '2025-12-10 17:39:01'),
(4, 36, '46679237', 'APAZA TICONA', 'SEBASTIAN', 'Primer Grado', 'Sí', 'JR ILO E-04 PUNO', 'No', 'NO TIENE ACTIVIDAD REGISTRADA', 'No', 'NO TIENE PREDIO VINCULADO', '2025-12-11 14:27:45'),
(5, 37, '34343434', '343434', '434343', 'Primer Grado', 'Sí', 'JR ILO E-04 PUNO', 'No', 'NO TIENE ACTIVIDAD REGISTRADA', 'No', 'NO TIENE PREDIO VINCULADO', '2025-12-11 14:55:48'),
(6, 38, '01258764', 'APAZA COLQUE', 'FELIX', 'Primer Grado', 'Sí', 'JR ILO E-04 PUNO', 'No', 'NO TIENE ACTIVIDAD REGISTRADA', 'No', 'NO TIENE PREDIO VINCULADO', '2025-12-11 16:33:20'),
(7, 39, '46679237', 'QUIÑONEZ FERNANDEZ', 'FABIOLA', 'Segundo Grado', 'No', 'NO TIENE DOMICILIO VINCULADO', 'Sí', 'PECUARIO', 'No', 'NO TIENE PREDIO VINCULADO', '2025-12-11 16:33:20'),
(8, 39, '46679239', 'APAZA COSSI', 'LEONCIO', 'Segundo Grado', 'No', 'NO TIENE DOMICILIO VINCULADO', 'No', 'NO TIENE ACTIVIDAD REGISTRADA', 'Sí', 'PREDIO DEL PADRE', '2025-12-11 16:33:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_creditos`
--

CREATE TABLE `tipos_creditos` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `dni` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `rol` enum('admin','usuario') NOT NULL DEFAULT 'usuario',
  `id_zona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `apellidos`, `nombres`, `dni`, `correo`, `telefono`, `usuario`, `password`, `estado`, `fecha_registro`, `rol`, `id_zona`) VALUES
(1, 'Apaza Ticona', 'Esteban', '46679237', 'admin@sistema.com', '999999999', 'eapaza', '$2y$10$U9xBOeKA9rN3sxV5DqBLG.2qVuZ8MdrG3FDIqZ3VUa2PDaOfI1v1W', 1, '2025-11-21 20:30:18', 'admin', NULL),
(2, 'Perez', 'Juan', '11111111', 'juan@correo.com', '988888888', 'juan', '$2y$10$qGoSUlhfC1rN./CbdNW19OOFhOyr5oHiX9jRxrZ68gYUR.1Vd3g.m', 1, '2025-11-21 20:30:18', 'usuario', NULL),
(4, 'Apaza Ticona', 'Esteban', '46679237', 'eapaza@agrobanco.com.pe', '980874152', 'eapazasur', '$2y$10$ACWFeF2fhpPFy/NvJ0/pKutzmzvyqemwzC2CMI309pU4xKp9RYGGe', 1, '2025-12-10 03:11:08', 'usuario', 1),
(5, 'Huamani Quispe', 'Madonna', '46921881', 'mhuamani@agrobanco.com.pe', '999999999', 'mhuamani', '$2y$10$v.edSuGga3Di/Uwh.rgshu3ervBb4bz3oVg/UY4ioC3BD8alHIZ3e', 1, '2025-12-10 14:15:23', 'usuario', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zonas`
--

CREATE TABLE `zonas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `zonas`
--

INSERT INTO `zonas` (`id`, `nombre`) VALUES
(1, 'Sur'),
(2, 'Sur Oriente'),
(3, 'Norte'),
(4, 'Nor Oriente'),
(5, 'Centro'),
(6, 'Oriente'),
(7, 'Centro Oriente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agencia`
--
ALTER TABLE `agencia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`);

--
-- Indices de la tabla `comite`
--
ALTER TABLE `comite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `comite_modalidad`
--
ALTER TABLE `comite_modalidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_comite` (`id_comite`),
  ADD KEY `id_detalle_comite` (`id_detalle_comite`),
  ADD KEY `id_usuario_registro` (`id_usuario_registro`);

--
-- Indices de la tabla `decision`
--
ALTER TABLE `decision`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_comite`
--
ALTER TABLE `detalle_comite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_comite` (`id_comite`),
  ADD KEY `id_agencia` (`id_agencia`),
  ADD KEY `id_oficial_proponente` (`id_oficial_proponente`),
  ADD KEY `id_oficial_participante1` (`id_oficial_participante1`),
  ADD KEY `id_oficial_participante2` (`id_oficial_participante2`),
  ADD KEY `id_jefe_agencia` (`id_jefe_agencia`),
  ADD KEY `id_decision` (`id_decision`);

--
-- Indices de la tabla `jefes_agencia`
--
ALTER TABLE `jefes_agencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_agencia` (`id_agencia`);

--
-- Indices de la tabla `oficiales_negocios`
--
ALTER TABLE `oficiales_negocios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_agencia` (`id_agencia`);

--
-- Indices de la tabla `riesgo_vinculado`
--
ALTER TABLE `riesgo_vinculado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_detalle_comite` (`id_detalle_comite`);

--
-- Indices de la tabla `tipos_creditos`
--
ALTER TABLE `tipos_creditos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD KEY `fk_usuario_zona` (`id_zona`);

--
-- Indices de la tabla `zonas`
--
ALTER TABLE `zonas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agencia`
--
ALTER TABLE `agencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comite`
--
ALTER TABLE `comite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `comite_modalidad`
--
ALTER TABLE `comite_modalidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `decision`
--
ALTER TABLE `decision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_comite`
--
ALTER TABLE `detalle_comite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `jefes_agencia`
--
ALTER TABLE `jefes_agencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `oficiales_negocios`
--
ALTER TABLE `oficiales_negocios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT de la tabla `riesgo_vinculado`
--
ALTER TABLE `riesgo_vinculado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tipos_creditos`
--
ALTER TABLE `tipos_creditos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `zonas`
--
ALTER TABLE `zonas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comite`
--
ALTER TABLE `comite`
  ADD CONSTRAINT `comite_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `comite_modalidad`
--
ALTER TABLE `comite_modalidad`
  ADD CONSTRAINT `comite_modalidad_ibfk_1` FOREIGN KEY (`id_comite`) REFERENCES `comite` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comite_modalidad_ibfk_2` FOREIGN KEY (`id_detalle_comite`) REFERENCES `detalle_comite` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comite_modalidad_ibfk_3` FOREIGN KEY (`id_usuario_registro`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `detalle_comite`
--
ALTER TABLE `detalle_comite`
  ADD CONSTRAINT `detalle_comite_ibfk_1` FOREIGN KEY (`id_comite`) REFERENCES `comite` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_comite_ibfk_2` FOREIGN KEY (`id_agencia`) REFERENCES `agencia` (`id`),
  ADD CONSTRAINT `detalle_comite_ibfk_3` FOREIGN KEY (`id_oficial_proponente`) REFERENCES `oficiales_negocios` (`id`),
  ADD CONSTRAINT `detalle_comite_ibfk_4` FOREIGN KEY (`id_oficial_participante1`) REFERENCES `oficiales_negocios` (`id`),
  ADD CONSTRAINT `detalle_comite_ibfk_5` FOREIGN KEY (`id_oficial_participante2`) REFERENCES `oficiales_negocios` (`id`),
  ADD CONSTRAINT `detalle_comite_ibfk_6` FOREIGN KEY (`id_jefe_agencia`) REFERENCES `jefes_agencia` (`id`),
  ADD CONSTRAINT `detalle_comite_ibfk_7` FOREIGN KEY (`id_decision`) REFERENCES `decision` (`id`);

--
-- Filtros para la tabla `jefes_agencia`
--
ALTER TABLE `jefes_agencia`
  ADD CONSTRAINT `jefes_agencia_ibfk_1` FOREIGN KEY (`id_agencia`) REFERENCES `agencia` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `oficiales_negocios`
--
ALTER TABLE `oficiales_negocios`
  ADD CONSTRAINT `oficiales_negocios_ibfk_1` FOREIGN KEY (`id_agencia`) REFERENCES `agencia` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `riesgo_vinculado`
--
ALTER TABLE `riesgo_vinculado`
  ADD CONSTRAINT `riesgo_vinculado_ibfk_1` FOREIGN KEY (`id_detalle_comite`) REFERENCES `detalle_comite` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuario_zona` FOREIGN KEY (`id_zona`) REFERENCES `zonas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
