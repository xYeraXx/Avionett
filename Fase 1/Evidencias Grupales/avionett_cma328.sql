-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-09-2026 a las 00:26:52
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `avionett_cma328`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos_normativos`
--

CREATE TABLE `documentos_normativos` (
  `id_documento` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `resolucion_dgac` varchar(100) DEFAULT NULL,
  `url_archivo_pdf` varchar(255) NOT NULL,
  `fecha_vigencia` date DEFAULT NULL,
  `fecha_subida` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos_normativos`
--

INSERT INTO `documentos_normativos` (`id_documento`, `id_usuario`, `titulo`, `resolucion_dgac`, `url_archivo_pdf`, `fecha_vigencia`, `fecha_subida`) VALUES
(1, 1, 'Certificado CMA N° 328', 'Resolución Exenta DGAC N° 328', '/docs/certificado_cma_328.pdf', '2027-12-31', '2026-09-15 18:42:29'),
(2, 1, 'Lista de Capacidades Técnicas Autorizadas', 'Habilitación Técnica Oficial', '/docs/lista_capacidades.pdf', '2027-12-31', '2026-09-15 18:42:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria_imagenes`
--

CREATE TABLE `galeria_imagenes` (
  `id_imagen` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `titulo` varchar(100) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `url_imagen` varchar(255) NOT NULL,
  `fecha_publicacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(11) NOT NULL,
  `nombre_servicio` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `normativa_dan` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nombre_servicio`, `descripcion`, `normativa_dan`, `activo`) VALUES
(1, 'Mangueras Aeronáuticas', 'Fabricación, armado, control de calidad y pruebas de presión hidrostática.', 'DAN 145 / Form 8130-3', 1),
(2, 'Gobernadores e Hidráulica', 'Overhaul general, calibración en banco e inspecciones NDI (Hartzell, McCauley, Woodward).', 'DAN 145 / Form 8130-3', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_cotizacion`
--

CREATE TABLE `solicitudes_cotizacion` (
  `id_solicitud` int(11) NOT NULL,
  `id_servicio` int(11) DEFAULT NULL,
  `nombre_cliente` varchar(150) NOT NULL,
  `empresa_aeronautica` varchar(150) DEFAULT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fabricante` varchar(100) DEFAULT NULL,
  `part_number` varchar(50) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `tipo_trabajo` varchar(50) DEFAULT NULL,
  `descripcion_falla` text DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` varchar(30) NOT NULL DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_admin`
--

CREATE TABLE `usuarios_admin` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` varchar(30) NOT NULL DEFAULT 'Administrador',
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios_admin`
--

INSERT INTO `usuarios_admin` (`id_usuario`, `nombre`, `correo`, `password_hash`, `rol`, `fecha_registro`) VALUES
(1, 'Administrador Parragué', 'admin@parrague.cl', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHeX1R0gqF25MvFkZz48d13x7E9hR1cMqe', 'Administrador', '2026-09-15 18:42:29');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `documentos_normativos`
--
ALTER TABLE `documentos_normativos`
  ADD PRIMARY KEY (`id_documento`),
  ADD KEY `fk_documento_usuario_idx` (`id_usuario`);

--
-- Indices de la tabla `galeria_imagenes`
--
ALTER TABLE `galeria_imagenes`
  ADD PRIMARY KEY (`id_imagen`),
  ADD KEY `fk_imagen_usuario_idx` (`id_usuario`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`);

--
-- Indices de la tabla `solicitudes_cotizacion`
--
ALTER TABLE `solicitudes_cotizacion`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `fk_solicitud_servicio_idx` (`id_servicio`);

--
-- Indices de la tabla `usuarios_admin`
--
ALTER TABLE `usuarios_admin`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documentos_normativos`
--
ALTER TABLE `documentos_normativos`
  MODIFY `id_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `galeria_imagenes`
--
ALTER TABLE `galeria_imagenes`
  MODIFY `id_imagen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `solicitudes_cotizacion`
--
ALTER TABLE `solicitudes_cotizacion`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios_admin`
--
ALTER TABLE `usuarios_admin`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documentos_normativos`
--
ALTER TABLE `documentos_normativos`
  ADD CONSTRAINT `fk_documento_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios_admin` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `galeria_imagenes`
--
ALTER TABLE `galeria_imagenes`
  ADD CONSTRAINT `fk_imagen_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios_admin` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicitudes_cotizacion`
--
ALTER TABLE `solicitudes_cotizacion`
  ADD CONSTRAINT `fk_solicitud_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
