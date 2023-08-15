-- phpMyAdmin SQL Dump
-- version 5.2.1deb1+jammy2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-04-2023 a las 09:32:30
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
-- Base de datos: `videoclub_2_1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alquila`
--

CREATE TABLE `alquila` (
  `id_socio` int NOT NULL,
  `id_pelicula` int NOT NULL,
  `f_inicio` datetime NOT NULL DEFAULT (curdate()),
  `f_final` date DEFAULT NULL,
  `price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `alquila`
--

INSERT INTO `alquila` (`id_socio`, `id_pelicula`, `f_inicio`, `f_final`, `price`) VALUES
(1, 1, '2021-01-01 00:00:00', '2021-06-21', 10),
(1, 1, '2022-11-15 00:00:00', '2022-12-15', 10),
(1, 2, '2022-12-01 00:00:00', NULL, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cast1`
--

CREATE TABLE `cast1` (
  `id` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `ape1` varchar(45) NOT NULL,
  `ape2` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cast1`
--

INSERT INTO `cast1` (`id`, `nombre`, `ape1`, `ape2`) VALUES
(1, 'Keanu', 'Reeves', NULL),
(2, 'Denzel', 'Hayes', 'Washington');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `id` int NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id`, `nombre`) VALUES
(1, 'Menorca'),
(2, 'Tenerife');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participa`
--

CREATE TABLE `participa` (
  `id_pelicula` int NOT NULL,
  `id_cast1` int NOT NULL,
  `id_tipo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `participa`
--

INSERT INTO `participa` (`id_pelicula`, `id_cast1`, `id_tipo`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pelicula`
--

CREATE TABLE `pelicula` (
  `id` int NOT NULL,
  `titulo` varchar(45) NOT NULL,
  `preu` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `pelicula`
--

INSERT INTO `pelicula` (`id`, `titulo`, `preu`) VALUES
(1, 'Matrix', 26),
(2, 'Titanes', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `id` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `ape1` varchar(45) NOT NULL,
  `ape2` varchar(45) DEFAULT NULL,
  `tlf` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) NOT NULL,
  `dni` varchar(45) NOT NULL,
  `id_ciudad` int DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`id`, `nombre`, `ape1`, `ape2`, `tlf`, `direccion`, `dni`, `id_ciudad`, `email`) VALUES
(1, 'Maria', 'Morena', 'Ruiz', '600600600', 'Calle Cano 1', '12345678H', 1, 'maria@gmail.es'),
(2, 'Migue', 'Martin', 'Roman', NULL, 'Calle Puerto 25', '24242424R', 2, NULL),
(3, 'Miguel Ángel', 'Porras', 'Rodríguez', '625466566', 'Calle Lorenzo 2', '34276943G', 1, 'miguelangel@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `id` int NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id`, `nombre`) VALUES
(1, 'actua'),
(2, 'dirige');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alquila`
--
ALTER TABLE `alquila`
  ADD PRIMARY KEY (`id_socio`,`id_pelicula`,`f_inicio`),
  ADD KEY `id_pelicula` (`id_pelicula`);

--
-- Indices de la tabla `cast1`
--
ALTER TABLE `cast1`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `participa`
--
ALTER TABLE `participa`
  ADD PRIMARY KEY (`id_pelicula`,`id_cast1`,`id_tipo`),
  ADD KEY `id_cast1` (`id_cast1`),
  ADD KEY `id_tipo` (`id_tipo`);

--
-- Indices de la tabla `pelicula`
--
ALTER TABLE `pelicula`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_ciudad` (`id_ciudad`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo`
--
ALTER TABLE `tipo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alquila`
--
ALTER TABLE `alquila`
  ADD CONSTRAINT `alquila_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id`),
  ADD CONSTRAINT `alquila_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id`);

--
-- Filtros para la tabla `participa`
--
ALTER TABLE `participa`
  ADD CONSTRAINT `participa_ibfk_1` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id`),
  ADD CONSTRAINT `participa_ibfk_2` FOREIGN KEY (`id_cast1`) REFERENCES `cast1` (`id`),
  ADD CONSTRAINT `participa_ibfk_3` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id`);

--
-- Filtros para la tabla `socio`
--
ALTER TABLE `socio`
  ADD CONSTRAINT `socio_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
