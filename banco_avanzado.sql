-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-03-2026 a las 23:46:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET SESSION sql_require_primary_key = 0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `banco_avanzado`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_saldos`
--

CREATE TABLE `auditoria_saldos` (
  `id` int(11) NOT NULL,
  `cuenta_id` int(11) DEFAULT NULL,
  `saldo_anterior` decimal(15,2) DEFAULT NULL,
  `saldo_nuevo` decimal(15,2) DEFAULT NULL,
  `usuario_cambio` varchar(50) DEFAULT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria_saldos`
--

INSERT INTO `auditoria_saldos` (`id`, `cuenta_id`, `saldo_anterior`, `saldo_nuevo`, `usuario_cambio`, `fecha_cambio`) VALUES
(1, 1, 4500.00, 5000.00, 'admin@banco.com', '2026-01-08 17:55:30'),
(2, 3, 400.00, 300.00, 'system_proc', '2026-01-08 17:55:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `email`, `telefono`, `creado_en`) VALUES
(1, 'Juan Pérez', 'juan.perez@email.com', '555-0101', '2026-01-08 17:55:30'),
(2, 'María García', 'maria.garcia@email.com', '555-0102', '2026-01-08 17:55:30'),
(3, 'Carlos López', 'carlos.lopez@email.com', '555-0103', '2026-01-08 17:55:30'),
(4, 'Ana Martínez', 'ana.martinez@email.com', '555-0104', '2026-01-08 17:55:30'),
(5, 'Luis Rodríguez', 'luis.rodriguez@email.com', '555-0105', '2026-01-08 17:55:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `numero_cuenta` varchar(20) NOT NULL,
  `tipo_cuenta` enum('Ahorro','Corriente') DEFAULT 'Ahorro',
  `saldo` decimal(15,2) DEFAULT 0.00,
  `estado` enum('Activa','Bloqueada','Inactiva') DEFAULT 'Activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `cliente_id`, `numero_cuenta`, `tipo_cuenta`, `saldo`, `estado`) VALUES
(1, 1, '100001', 'Ahorro', 4500.00, 'Activa'),
(2, 2, '100002', 'Corriente', 13000.50, 'Activa'),
(3, 3, '100003', 'Ahorro', 300.00, 'Activa'),
(4, 3, '100004', 'Corriente', 1500.00, 'Activa'),
(5, 4, '100005', 'Ahorro', 0.00, 'Bloqueada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`) VALUES
(1, 'admin', 'Administrador con acceso total'),
(2, 'cliente', 'Usuario final con acceso a sus cuentas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

CREATE TABLE `transacciones` (
  `id` int(11) NOT NULL,
  `cuenta_origen_id` int(11) DEFAULT NULL,
  `cuenta_destino_id` int(11) DEFAULT NULL,
  `monto` decimal(15,2) NOT NULL,
  `tipo_movimiento` enum('Deposito','Retiro','Transferencia') NOT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `transacciones`
--

INSERT INTO `transacciones` (`id`, `cuenta_origen_id`, `cuenta_destino_id`, `monto`, `tipo_movimiento`, `fecha_hora`) VALUES
(1, NULL, 1, 5000.00, 'Deposito', '2026-01-08 17:55:30'),
(2, NULL, 2, 12500.50, 'Deposito', '2026-01-08 17:55:30'),
(3, 2, 1, 500.00, 'Transferencia', '2026-01-08 17:55:30'),
(4, 3, NULL, 100.00, 'Retiro', '2026-01-08 17:55:30'),
(5, 1, 2, 500.00, 'Transferencia', '2026-03-06 20:39:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `ultimo_login` datetime DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `rol_id`, `email`, `password`, `cliente_id`, `activo`, `ultimo_login`, `creado_en`) VALUES
(1, 1, 'admin@banco.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 1, NULL, '2026-01-08 17:55:30'),
(2, 2, 'juan.perez@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 1, NULL, '2026-01-08 17:55:30'),
(3, 2, 'maria.garcia@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 2, 1, NULL, '2026-01-08 17:55:30'),
(4, 2, 'carlos.lopez@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 3, 1, NULL, '2026-01-08 17:55:30');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_detalle_movimientos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_detalle_movimientos` (
`transaccion_id` int(11)
,`fecha_hora` timestamp
,`tipo_movimiento` enum('Deposito','Retiro','Transferencia')
,`monto` decimal(15,2)
,`cuenta_origen` varchar(20)
,`cliente_origen` varchar(100)
,`cuenta_destino` varchar(20)
,`cliente_destino` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_reporte_auditoria`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_reporte_auditoria` (
`cliente_id` int(11)
,`nombre` varchar(100)
,`email` varchar(100)
,`cantidad_de_cuentas` bigint(21)
,`saldo_total_global` decimal(37,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_detalle_movimientos`
--
DROP TABLE IF EXISTS `vista_detalle_movimientos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_detalle_movimientos`  AS SELECT `t`.`id` AS `transaccion_id`, `t`.`fecha_hora` AS `fecha_hora`, `t`.`tipo_movimiento` AS `tipo_movimiento`, `t`.`monto` AS `monto`, coalesce(`c_origen`.`numero_cuenta`,'Ventanilla/Externo') AS `cuenta_origen`, `cl_origen`.`nombre` AS `cliente_origen`, coalesce(`c_destino`.`numero_cuenta`,'Ventanilla/Externo') AS `cuenta_destino`, `cl_destino`.`nombre` AS `cliente_destino` FROM ((((`transacciones` `t` left join `cuentas` `c_origen` on(`t`.`cuenta_origen_id` = `c_origen`.`id`)) left join `clientes` `cl_origen` on(`c_origen`.`cliente_id` = `cl_origen`.`id`)) left join `cuentas` `c_destino` on(`t`.`cuenta_destino_id` = `c_destino`.`id`)) left join `clientes` `cl_destino` on(`c_destino`.`cliente_id` = `cl_destino`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_reporte_auditoria`
--
DROP TABLE IF EXISTS `vista_reporte_auditoria`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_reporte_auditoria`  AS SELECT `c`.`id` AS `cliente_id`, `c`.`nombre` AS `nombre`, `c`.`email` AS `email`, count(`cu`.`id`) AS `cantidad_de_cuentas`, coalesce(sum(`cu`.`saldo`),0.00) AS `saldo_total_global` FROM (`clientes` `c` left join `cuentas` `cu` on(`c`.`id` = `cu`.`cliente_id`)) GROUP BY `c`.`id`, `c`.`nombre`, `c`.`email` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria_saldos`
--
ALTER TABLE `auditoria_saldos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_nombre_cliente` (`nombre`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_cuenta` (`numero_cuenta`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuenta_origen_id` (`cuenta_origen_id`),
  ADD KEY `cuenta_destino_id` (`cuenta_destino_id`),
  ADD KEY `idx_transacciones_fecha` (`fecha_hora`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `rol_id` (`rol_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria_saldos`
--
ALTER TABLE `auditoria_saldos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`cuenta_origen_id`) REFERENCES `cuentas` (`id`),
  ADD CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`cuenta_destino_id`) REFERENCES `cuentas` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
