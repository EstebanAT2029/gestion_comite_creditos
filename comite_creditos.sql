-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-12-2025 a las 18:16:56
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comite_modalidad`
--
ALTER TABLE `comite_modalidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `decision`
--
ALTER TABLE `decision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_comite`
--
ALTER TABLE `detalle_comite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
