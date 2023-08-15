-- phpMyAdmin SQL Dump
-- version 5.2.1deb1+jammy2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-04-2023 a las 09:32:18
-- Versión del servidor: 8.0.32-0ubuntu0.22.04.2
-- Versión de PHP: 8.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ordenadores`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE `aula` (
  `id` int NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejemplar_ordenador`
--

CREATE TABLE `ejemplar_ordenador` (
  `id` int NOT NULL,
  `num_serie` varchar(20) NOT NULL,
  `fecha_fin_garantia` date NOT NULL,
  `fecha_adquisicion` date NOT NULL,
  `id_aula` int NOT NULL,
  `id_modelo_ordenador` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejemplar_periferico`
--

CREATE TABLE `ejemplar_periferico` (
  `id` int NOT NULL,
  `id_ejemplar_ordenador` int NOT NULL,
  `id_modelo_periferico` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `id` int NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_ordenador`
--

CREATE TABLE `modelo_ordenador` (
  `id` int NOT NULL,
  `cantidad` int NOT NULL,
  `id_tipo_memoria` int NOT NULL,
  `id_marca` int NOT NULL,
  `id_tipo_procesador` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `id_tipo_placa` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_periferico`
--

CREATE TABLE `modelo_periferico` (
  `id` int NOT NULL,
  `id_marca` int NOT NULL,
  `id_tipo_periferico` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id` int NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_memoria`
--

CREATE TABLE `tipo_memoria` (
  `id` int NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_periferico`
--

CREATE TABLE `tipo_periferico` (
  `id` int NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_placa`
--

CREATE TABLE `tipo_placa` (
  `id` int NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_procesador`
--

CREATE TABLE `tipo_procesador` (
  `id` int NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ejemplar_ordenador`
--
ALTER TABLE `ejemplar_ordenador`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `num_serie` (`num_serie`),
  ADD KEY `fk aula` (`id_aula`),
  ADD KEY `fk modelo_ordenador` (`id_modelo_ordenador`);

--
-- Indices de la tabla `ejemplar_periferico`
--
ALTER TABLE `ejemplar_periferico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk ejemplar_ordenador` (`id_ejemplar_ordenador`),
  ADD KEY `fk modelo_periferico` (`id_modelo_periferico`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modelo_ordenador`
--
ALTER TABLE `modelo_ordenador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk tipo_memoria` (`id_tipo_memoria`),
  ADD KEY `fk tipo_procesador` (`id_tipo_procesador`),
  ADD KEY `fk proveedor` (`id_proveedor`),
  ADD KEY `fk tipo_placa` (`id_tipo_placa`),
  ADD KEY `id_marca` (`id_marca`);

--
-- Indices de la tabla `modelo_periferico`
--
ALTER TABLE `modelo_periferico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk marca` (`id_marca`),
  ADD KEY `fk tipo_periferico` (`id_tipo_periferico`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_memoria`
--
ALTER TABLE `tipo_memoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_periferico`
--
ALTER TABLE `tipo_periferico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_placa`
--
ALTER TABLE `tipo_placa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_procesador`
--
ALTER TABLE `tipo_procesador`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aula`
--
ALTER TABLE `aula`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ejemplar_ordenador`
--
ALTER TABLE `ejemplar_ordenador`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ejemplar_periferico`
--
ALTER TABLE `ejemplar_periferico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modelo_ordenador`
--
ALTER TABLE `modelo_ordenador`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modelo_periferico`
--
ALTER TABLE `modelo_periferico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_memoria`
--
ALTER TABLE `tipo_memoria`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_periferico`
--
ALTER TABLE `tipo_periferico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_placa`
--
ALTER TABLE `tipo_placa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_procesador`
--
ALTER TABLE `tipo_procesador`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ejemplar_ordenador`
--
ALTER TABLE `ejemplar_ordenador`
  ADD CONSTRAINT `fk aula` FOREIGN KEY (`id_aula`) REFERENCES `aula` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk modelo_ordenador` FOREIGN KEY (`id_modelo_ordenador`) REFERENCES `modelo_ordenador` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `ejemplar_periferico`
--
ALTER TABLE `ejemplar_periferico`
  ADD CONSTRAINT `fk ejemplar_ordenador` FOREIGN KEY (`id_ejemplar_ordenador`) REFERENCES `ejemplar_ordenador` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk modelo_periferico` FOREIGN KEY (`id_modelo_periferico`) REFERENCES `modelo_periferico` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `modelo_ordenador`
--
ALTER TABLE `modelo_ordenador`
  ADD CONSTRAINT `fk proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk tipo_memoria` FOREIGN KEY (`id_tipo_memoria`) REFERENCES `tipo_memoria` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk tipo_placa` FOREIGN KEY (`id_tipo_placa`) REFERENCES `tipo_placa` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk tipo_procesador` FOREIGN KEY (`id_tipo_procesador`) REFERENCES `tipo_procesador` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `modelo_ordenador_ibfk_1` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `modelo_periferico`
--
ALTER TABLE `modelo_periferico`
  ADD CONSTRAINT `fk marca` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk tipo_periferico` FOREIGN KEY (`id_tipo_periferico`) REFERENCES `tipo_periferico` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
