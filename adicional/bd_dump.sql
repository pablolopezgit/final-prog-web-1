CREATE USER 'final'@'localhost' IDENTIFIED BY 'final';
GRANT USAGE ON *.* TO 'final'@'localhost';
CREATE DATABASE IF NOT EXISTS `final` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON `final`.* TO 'final'@'localhost';

USE final;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `final`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `vacunaId` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `hora` int(11) NOT NULL,
  `tomado` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombres` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `dni` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `vacunaId` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `hora` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `turnos`
--

INSERT INTO `turnos` (`vacunaId`, `mes`, `dia`, `hora`, `tomado`) VALUES
(1, 7, 1, 10, 0),
(1, 7, 1, 11, 0),
(1, 7, 2, 10, 0),
(1, 7, 2, 11, 0),
(1, 7, 3, 12, 0),
(1, 7, 4, 14, 0),
(1, 7, 3, 14, 0),
(1, 8, 12, 11, 0),
(1, 8, 12, 12, 0),
(1, 8, 12, 13, 0),
(1, 8, 14, 10, 0),
(1, 8, 15, 9, 0),
(1, 8, 15, 10, 0),
(1, 9, 5, 10, 0),
(1, 9, 5, 11, 0),
(1, 9, 6, 10, 0),
(1, 10, 1, 10, 0),
(1, 10, 1, 11, 0),
(1, 10, 2, 10, 0),
(1, 10, 2, 11, 0),
(1, 10, 3, 12, 0),
(1, 10, 4, 14, 0),
(1, 10, 3, 14, 0),
(1, 11, 12, 11, 0),
(1, 11, 12, 12, 0),
(1, 11, 12, 13, 0),
(1, 11, 14, 10, 0),
(1, 11, 15, 9, 0),
(1, 12, 3, 10, 0),
(1, 12, 5, 10, 0),
(1, 12, 5, 11, 0),
(1, 12, 6, 10, 0),
(2, 7, 1, 10, 0),
(2, 7, 1, 11, 0),
(2, 7, 2, 10, 0),
(2, 7, 2, 11, 0),
(2, 7, 3, 12, 0),
(2, 7, 4, 14, 0),
(2, 7, 3, 14, 0),
(2, 8, 12, 11, 0),
(2, 8, 12, 12, 0),
(2, 8, 12, 13, 0),
(2, 8, 14, 10, 0),
(2, 8, 15, 9, 0),
(2, 8, 15, 10, 0),
(2, 9, 5, 10, 0),
(2, 9, 5, 11, 0),
(2, 9, 6, 10, 0),
(2, 10, 1, 10, 0),
(2, 10, 1, 11, 0),
(2, 10, 2, 10, 0),
(2, 10, 2, 11, 0),
(2, 10, 3, 12, 0),
(2, 10, 4, 14, 0),
(2, 10, 3, 14, 0),
(2, 11, 12, 11, 0),
(2, 11, 12, 12, 0),
(2, 11, 12, 13, 0),
(2, 11, 14, 10, 0),
(2, 11, 15, 9, 0),
(2, 11, 15, 10, 0),
(2, 12, 5, 10, 0),
(2, 12, 5, 11, 0),
(2, 12, 6, 10, 0),
(3, 7, 1, 10, 0),
(3, 7, 1, 11, 0),
(3, 7, 2, 10, 0),
(3, 7, 2, 11, 0),
(3, 7, 3, 12, 0),
(3, 7, 4, 14, 0),
(3, 7, 3, 14, 0),
(3, 8, 12, 11, 0),
(3, 8, 12, 12, 0),
(3, 8, 12, 13, 0),
(3, 8, 14, 10, 0),
(3, 8, 15, 9, 0),
(3, 8, 15, 10, 0),
(3, 9, 5, 10, 0),
(3, 9, 5, 11, 0),
(3, 9, 6, 10, 0),
(3, 10, 1, 10, 0),
(3, 10, 1, 11, 0),
(3, 10, 2, 10, 0),
(3, 10, 2, 11, 0),
(3, 10, 3, 12, 0),
(3, 10, 4, 14, 0),
(3, 10, 3, 14, 0),
(3, 11, 12, 11, 0),
(3, 11, 12, 12, 0),
(3, 11, 12, 13, 0),
(3, 11, 14, 10, 0),
(3, 11, 15, 9, 0),
(3, 11, 15, 10, 0),
(3, 12, 5, 10, 0),
(3, 12, 5, 11, 0),
(3, 12, 6, 10, 0),
(4, 7, 1, 10, 0),
(4, 7, 1, 11, 0),
(4, 7, 2, 10, 0),
(4, 7, 2, 11, 0),
(4, 7, 3, 12, 0),
(4, 7, 4, 14, 0),
(4, 7, 3, 14, 0),
(4, 8, 12, 11, 0),
(4, 8, 12, 12, 0),
(4, 8, 12, 13, 0),
(4, 8, 14, 10, 0),
(4, 8, 15, 9, 0),
(4, 8, 15, 10, 0),
(4, 9, 5, 10, 0),
(4, 9, 5, 11, 0),
(4, 9, 6, 10, 0),
(4, 10, 1, 10, 0),
(4, 10, 1, 11, 0),
(4, 10, 2, 10, 0),
(4, 10, 2, 11, 0),
(4, 10, 3, 12, 0),
(4, 10, 4, 14, 0),
(4, 10, 3, 14, 0),
(4, 11, 12, 11, 0),
(4, 11, 12, 12, 0),
(4, 11, 12, 13, 0),
(4, 11, 14, 10, 0),
(4, 11, 15, 9, 0),
(4, 11, 15, 10, 0),
(4, 12, 5, 10, 0),
(4, 12, 5, 11, 0),
(4, 12, 6, 10, 0);

-- --------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

