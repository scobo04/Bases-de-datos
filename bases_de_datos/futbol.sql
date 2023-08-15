-- phpMyAdmin SQL Dump
-- version 5.2.1deb1+jammy2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-04-2023 a las 09:32:10
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
-- Base de datos: `futbol`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equip`
--

CREATE TABLE `equip` (
  `id` int NOT NULL,
  `nom` varchar(45) NOT NULL,
  `tipus` enum('SEL','NORMAL') DEFAULT NULL,
  `id_pais` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equips`
--

CREATE TABLE `equips` (
  `Equip` varchar(5) DEFAULT NULL,
  `Temporada` varchar(5) DEFAULT NULL,
  `NombreGols` int DEFAULT NULL,
  `Titol1` varchar(21) DEFAULT NULL,
  `Titol2` varchar(10) DEFAULT NULL,
  `Titol3` varchar(21) DEFAULT NULL,
  `Titol4` varchar(10) DEFAULT NULL,
  `Titol5` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `equips`
--

INSERT INTO `equips` (`Equip`, `Temporada`, `NombreGols`, `Titol1`, `Titol2`, `Titol3`, `Titol4`, `Titol5`) VALUES
('Barça', '21-22', 68, 'Champions League 2009', 'LLiga 2022', 'Chanpions League 2023', '', ''),
('Barça', '20-21', 50, 'Champions League 2009', 'LLiga 2022', 'Chanpions League 2023', '', ''),
('Barça', '19-20', 120, 'Champions League 2009', 'LLiga 2022', 'Chanpions League 2023', '', ''),
('PSG', '21-22', 150, 'LLiga 2018', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gols`
--

CREATE TABLE `gols` (
  `id_equip` int NOT NULL,
  `id_temporada` int NOT NULL,
  `numero_gols` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `id` int NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `llinatge1` varchar(45) DEFAULT NULL,
  `llinatge2` varchar(45) DEFAULT NULL,
  `data_naixement` date DEFAULT NULL,
  `id_pais` int NOT NULL,
  `id_equip` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugadors`
--

CREATE TABLE `jugadors` (
  `Jugador` varchar(6) DEFAULT NULL,
  `País` varchar(6) DEFAULT NULL,
  `Seleccio_que_juga` varchar(6) DEFAULT NULL,
  `Millor partit 1` varchar(31) DEFAULT NULL,
  `Millor partit 2` varchar(25) DEFAULT NULL,
  `Millor partit 3` varchar(10) DEFAULT NULL,
  `Millor partit 4` varchar(10) DEFAULT NULL,
  `Millor partit 5` varchar(10) DEFAULT NULL,
  `Data_naixement` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `jugadors`
--

INSERT INTO `jugadors` (`Jugador`, `País`, `Seleccio_que_juga`, `Millor partit 1`, `Millor partit 2`, `Millor partit 3`, `Millor partit 4`, `Millor partit 5`, `Data_naixement`) VALUES
('Mbappe', 'França', 'França', 'PSG-Argentina, 1-1-2002, 1, 3-0', 'Barça-PSG,2-3-2019,2, 1-4', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `millor_Partit`
--

CREATE TABLE `millor_Partit` (
  `id_partit` int NOT NULL,
  `id_jugador` int NOT NULL,
  `equip` enum('1','2') DEFAULT NULL,
  `id_millor_partit` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `id` int NOT NULL,
  `nom` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id`, `nom`) VALUES
(1, 'França'),
(2, 'França');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partit`
--

CREATE TABLE `partit` (
  `id` int NOT NULL,
  `id_equip_local` int NOT NULL,
  `id_equip_visitant` int NOT NULL,
  `data` date NOT NULL,
  `resultat` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temporada`
--

CREATE TABLE `temporada` (
  `id` int NOT NULL,
  `nom` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titol`
--

CREATE TABLE `titol` (
  `id` int NOT NULL,
  `nom` varchar(45) NOT NULL,
  `id_equip` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `equip`
--
ALTER TABLE `equip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pais` (`id_pais`);

--
-- Indices de la tabla `gols`
--
ALTER TABLE `gols`
  ADD PRIMARY KEY (`id_equip`),
  ADD UNIQUE KEY `id_temporada` (`id_temporada`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pais` (`id_pais`),
  ADD KEY `id_equip` (`id_equip`);

--
-- Indices de la tabla `millor_Partit`
--
ALTER TABLE `millor_Partit`
  ADD PRIMARY KEY (`id_millor_partit`),
  ADD KEY `id_partit` (`id_partit`),
  ADD KEY `id_jugador` (`id_jugador`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `partit`
--
ALTER TABLE `partit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_equip_local` (`id_equip_local`),
  ADD UNIQUE KEY `id_equip_visitant` (`id_equip_visitant`),
  ADD UNIQUE KEY `data` (`data`);

--
-- Indices de la tabla `temporada`
--
ALTER TABLE `temporada`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `titol`
--
ALTER TABLE `titol`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_equip` (`id_equip`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `millor_Partit`
--
ALTER TABLE `millor_Partit`
  MODIFY `id_millor_partit` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pais`
--
ALTER TABLE `pais`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `partit`
--
ALTER TABLE `partit`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `temporada`
--
ALTER TABLE `temporada`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `titol`
--
ALTER TABLE `titol`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `equip`
--
ALTER TABLE `equip`
  ADD CONSTRAINT `equip_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id`);

--
-- Filtros para la tabla `gols`
--
ALTER TABLE `gols`
  ADD CONSTRAINT `gols_ibfk_1` FOREIGN KEY (`id_equip`) REFERENCES `equip` (`id`),
  ADD CONSTRAINT `gols_ibfk_2` FOREIGN KEY (`id_temporada`) REFERENCES `temporada` (`id`);

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `jugador_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id`),
  ADD CONSTRAINT `jugador_ibfk_2` FOREIGN KEY (`id_equip`) REFERENCES `equip` (`id`);

--
-- Filtros para la tabla `millor_Partit`
--
ALTER TABLE `millor_Partit`
  ADD CONSTRAINT `millor_Partit_ibfk_1` FOREIGN KEY (`id_partit`) REFERENCES `partit` (`id`),
  ADD CONSTRAINT `millor_Partit_ibfk_2` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id`);

--
-- Filtros para la tabla `partit`
--
ALTER TABLE `partit`
  ADD CONSTRAINT `partit_ibfk_1` FOREIGN KEY (`id_equip_local`) REFERENCES `equip` (`id`),
  ADD CONSTRAINT `partit_ibfk_2` FOREIGN KEY (`id_equip_visitant`) REFERENCES `equip` (`id`);

--
-- Filtros para la tabla `titol`
--
ALTER TABLE `titol`
  ADD CONSTRAINT `titol_ibfk_1` FOREIGN KEY (`id_equip`) REFERENCES `equip` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
