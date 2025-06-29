-- Insertar los 3 roles básicos
INSERT INTO `universidad`.`rol` (`nombre`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
('Administrador', 1, 1, NOW()),
('Médico', 1, 1, NOW()),
('Paciente', 1, 1, NOW());

-- Administradores
INSERT INTO `universidad`.`usuario` (`tipo_documento`, `nro_documento`, `contrasenha`, `nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `correo_electronico`, `num_celular`, `genero`, `estado_general`, `estado_logico`, `estado`, `usuario_creacion`, `fecha_creacion`) VALUES 
('DNI', '12345678', 'i1g0EPUZi80=', 'Juan', 'Pérez', 'Gómez', '1980-05-15', 'juan.perez@universidad.edu', '987654321', 'MASCULINO', 1, 1, 'activo', 1, NOW()),
('DNI', '87654321', 'uBlOciigYlM=', 'María', 'López', 'Sánchez', '1985-08-20', 'maria.lopez@universidad.edu', '987123456', 'FEMENINO', 1, 1, 'activo', 1, NOW());

-- Médicos
INSERT INTO `universidad`.`usuario` (`tipo_documento`, `nro_documento`, `contrasenha`, `nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `correo_electronico`, `num_celular`, `cod_medico`, `genero`, `estado_general`, `estado_logico`, `estado`, `usuario_creacion`, `fecha_creacion`) VALUES 
('DNI', '23456789', 'EHYZZHOkTCw=', 'Carlos', 'García', 'Martínez', '1975-03-10', 'carlos.garcia@universidad.edu', '987654322', 'MED001', 'MASCULINO', 1, 1, 'activo', 1, NOW()),
('DNI', '34567890', 'v2LEhBpU3EM=', 'Ana', 'Rodríguez', 'Fernández', '1982-11-25', 'ana.rodriguez@universidad.edu', '987654323', 'MED002', 'FEMENINO', 1, 1, 'activo', 1, NOW()),
('DNI', '45678901', 'HdtPFlEKhEE=', 'Luis', 'Martínez', 'Díaz', '1978-07-30', 'luis.martinez@universidad.edu', '987654324', 'MED003', 'MASCULINO', 1, 3, 'activo', 1, NOW()); -- EN_CAPACITACION

-- Pacientes
INSERT INTO `universidad`.`usuario` (`tipo_documento`, `nro_documento`, `contrasenha`, `nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `correo_electronico`, `num_celular`, `genero`, `estado_general`, `estado_logico`, `estado`, `usuario_creacion`, `fecha_creacion`) VALUES 
('DNI', '56789012', 'GpHRQZxCR+4=', 'Pedro', 'Sánchez', 'Gómez', '1990-02-15', 'pedro.sanchez@gmail.com', '987654325', 'MASCULINO', 1, 1, 'activo', 1, NOW()),
('DNI', '67890123', '7DxMhtDbqzo=', 'Laura', 'Gómez', 'Pérez', '1992-09-20', 'laura.gomez@gmail.com', '987654326', 'FEMENINO', 1, 1, 'activo', 1, NOW()),
('DNI', '78901234', 'ygS+/h13M58=', 'Miguel', 'Díaz', 'López', '1988-12-05', 'miguel.diaz@gmail.com', '987654327', 'MASCULINO', 1, 1, 'activo', 1, NOW()),
('CE', 'X1234567', 'jDI1gFMevJ4=', 'Sofía', 'Fernández', 'Martínez', '1995-04-18', 'sofia.fernandez@gmail.com', '987654328', 'FEMENINO', 1, 1, 'activo', 1, NOW());

-- Asignar roles (1=Admin, 2=Médico, 3=Paciente)
INSERT INTO `universidad`.`usuario_por_rol` (`id_usuario`, `id_rol`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
(1, 1, 1, 1, NOW()), -- Juan Pérez es Admin
(2, 1, 1, 1, NOW()), -- María López es Admin
(3, 2, 1, 1, NOW()), -- Carlos García es Médico
(4, 2, 1, 1, NOW()), -- Ana Rodríguez es Médico
(5, 2, 1, 1, NOW()), -- Luis Martínez es Médico
(6, 3, 1, 1, NOW()), -- Pedro Sánchez es Paciente
(7, 3, 1, 1, NOW()), -- Laura Gómez es Paciente
(8, 3, 1, 1, NOW()), -- Miguel Díaz es Paciente
(9, 3, 1, 1, NOW()), -- Sofía Fernández es Paciente
(2, 2, 1, 1, NOW()), -- María López es Médico
(5, 3, 1, 1, NOW()), -- Luis Martínez es Paciente
(2, 3, 1, 1, NOW()); -- María López es Paciente

INSERT INTO `universidad`.`especialidad` (`nombre_especialidad`, `precio_consulta`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
('Medicina General', 80.00, 1, 1, NOW()),
('Cardiología', 150.00, 1, 1, NOW()),
('Dermatología', 120.00, 1, 1, NOW()),
('Pediatría', 100.00, 1, 1, NOW()),
('Ginecología', 130.00, 1, 1, NOW()),
('Oftalmología', 110.00, 1, 1, NOW());

INSERT INTO `universidad`.`usuario_por_especialidad` (`id_especialidad`, `id_usuario`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
(1, 3, 1, 1, NOW()), -- Carlos García: Medicina General
(2, 3, 1, 1, NOW()), -- Carlos García: Cardiología
(3, 4, 1, 1, NOW()), -- Ana Rodríguez: Dermatología
(4, 4, 1, 1, NOW()), -- Ana Rodríguez: Pediatría
(5, 5, 1, 1, NOW()), -- Luis Martínez: Ginecología
(6, 5, 1, 1, NOW()), -- Luis Martínez: Oftalmología
(1, 2, 1, 1, NOW()); -- María López: Medicina General

INSERT INTO `universidad`.`turno` (`nombre_turno`, `hora_inicio`, `hora_fin`, `estado_general`, `usuario_creación`, `fecha_creacion`) VALUES 
('Mañana', '08:00:00', '12:00:00', 1, 1, NOW()),
('Tarde', '14:00:00', '18:00:00', 1, 1, NOW()),
('Noche', '18:00:00', '22:00:00', 1, 1, NOW());

INSERT INTO `universidad`.`consultorio` (`numero_consultorio`, `piso`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
(101, 1, 1, 1, NOW()),
(102, 1, 1, 1, NOW()),
(201, 2, 1, 1, NOW()),
(202, 2, 1, 1, NOW()),
(301, 3, 1, 1, NOW());

-- 
INSERT INTO `universidad`.`tipo_de_examen` (`nombre_examen`, `indicacion`) VALUES 
('Laboratorio', 'Análisis de sangre, orina, etc.'),
('Imagenología', 'Rayos X, ecografías, etc.'),
('Prueba Funcional', 'Pruebas de esfuerzo, etc.');

INSERT INTO `universidad`.`examen` (`nombre_examen`, `id_tipo_de_examen`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
('Hemograma completo', 1, 1, 1, NOW()),
('Perfil lipídico', 1, 1, 1, NOW()),
('Radiografía de tórax', 2, 1, 1, NOW()),
('Ecografía abdominal', 2, 1, 1, NOW()),
('Electrocardiograma', 3, 1, 1, NOW()),
('Prueba de esfuerzo', 3, 1, 1, NOW());

INSERT INTO `universidad`.`diagnostico` (`nombre_diagnostico`, `descripcion`, `capitulo`, `grupo`, `nivel`, `activo`) VALUES 
('Diabetes mellitus tipo 2', 'Diabetes no insulinodependiente', 'Enfermedades endocrinas', 'Diabetes mellitus', 3, TRUE),
('Hipertensión esencial', 'Hipertensión arterial primaria', 'Enfermedades circulatorias', 'Hipertensión', 3, TRUE),
('Neumonía', 'Infección del parénquima pulmonar', 'Enfermedades respiratorias', 'Neumonía', 3, TRUE),
('Dorsalgia', 'Dolor de espalda', 'Enfermedades musculoesqueléticas', 'Dorsalgia', 3, TRUE),
('Episodio depresivo', 'Depresión unipolar', 'Trastornos mentales', 'Trastornos del humor', 3, TRUE),
('Dermatitis', 'Inflamación de la piel', 'Enfermedades de la piel', 'Dermatitis y eczema', 3, TRUE);

INSERT INTO `universidad`.`historia_clinica` (`id_paciente`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
(6, 1, 1, NOW()), -- Historia de Pedro Sánchez
(7, 1, 1, NOW()), -- Historia de Laura Gómez
(8, 1, 1, NOW()), -- Historia de Miguel Díaz
(9, 1, 1, NOW()), -- Historia de Sofía Fernández
(5, 1, 1, NOW()), -- Historia de Luis Martínez
(2, 1, 1, NOW()); -- Historia de María López

-- Citas pasadas
INSERT INTO `universidad`.`cita` (`id_medico`, `id_especialidad`, `id_turno`, `id_consultorio`, `hora_inicio`, `hora_fin`, `fecha_cita`, `estado_cita`, `usuario_creación`, `fecha_creacion`) VALUES 
(3, 1, 1, 1, '09:00:00', '09:30:00', '2023-05-10', 2, 1, NOW()), -- Pedro con Carlos (Medicina General)
(4, 3, 2, 3, '15:00:00', '15:30:00', '2023-05-12', 2, 1, NOW()), -- Laura con Ana (Dermatología)
(5, 5, 1, 5, '10:00:00', '10:30:00', '2023-05-15', 2, 1, NOW()), -- Sofía con Luis (Ginecología)
(3, 2, 3, 1, '19:00:00', '19:30:00', '2023-05-18', 2, 1, NOW()); -- Miguel con Carlos (Cardiología)

-- Citas disponibles futuras
INSERT INTO `universidad`.`cita` (`id_medico`, `id_especialidad`, `id_turno`, `id_consultorio`, `hora_inicio`, `hora_fin`, `fecha_cita`, `estado_cita`, `usuario_creación`, `fecha_creacion`) VALUES 
(3, 1, 1, 1, '09:00:00', '09:30:00', '2025-06-22', 1, 1, NOW()),
(3, 1, 1, 1, '09:30:00', '10:00:00', '2025-06-25', 1, 1, NOW()),
(4, 3, 2, 3, '15:00:00', '15:30:00', '2025-06-23', 1, 1, NOW()),
(5, 5, 3, 5, '18:30:00', '19:00:00', '2025-06-24', 1, 1, NOW()),
(3, 2, 1, 2, '10:00:00', '10:30:00', '2025-06-25', 1, 1, NOW()),
-- Nuevas citas
(3, 1, 1, 4, '11:00:00', '11:30:00', '2025-06-25', 1, 1, NOW()),
(3, 2, 1, 4, '11:30:00', '12:00:00', '2025-06-27', 1, 1, NOW()),
(5, 5, 2, 5, '16:00:00', '16:30:00', '2025-06-26', 1, 1, NOW()),
(5, 6, 2, 5, '17:00:00', '17:30:00', '2025-06-28', 1, 1, NOW()),
(4, 4, 3, 2, '20:30:00', '21:00:00', '2025-06-30', 1, 1, NOW()),
(4, 3, 3, 2, '21:30:00', '22:00:00', '2025-07-02', 1, 1, NOW()),
(5, 5, 1, 3, '08:00:00', '08:30:00', '2025-07-05', 1, 1, NOW());

INSERT INTO `universidad`.`historia_clinica_por_cita` (`id_historia`, `id_cita`, `peso`, `talla`, `presion_arterial`, `temperatura`, `frecuencia_cardiaca`, `motivo_consulta`, `tratamiento`, `evolucion`, `recomendacion`, `receta`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
(1, 1, 70.5, 1.75, '120/80', 36.5, 75, 'Dolor de cabeza persistente', 'Paracetamol 500mg cada 8 horas', 'Mejoría del dolor', 'Reposo y control en 1 semana', 'Paracetamol 500mg, 20 comprimidos', 1, 3, NOW()),
(2, 2, 60.0, 1.65, '110/70', 36.8, 72, 'Erupción cutánea en brazos', 'Crema hidrocortisona 1%', 'Disminución de la erupción', 'Evitar exposición al sol', 'Hidrocortisona crema 1%, 30g', 1, 4, NOW()),
(4, 3, 55.0, 1.60, '115/75', 36.7, 78, 'Control anual ginecológico', 'Ninguno necesario', 'Todo normal', 'Próximo control en 1 año', NULL, 1, 5, NOW()),
(3, 4, 80.0, 1.80, '140/90', 36.9, 85, 'Presión arterial elevada', 'Losartán 50mg diarios', 'Presión mejor controlada', 'Dieta baja en sal y ejercicio', 'Losartán 50mg, 30 tabletas', 1, 3, NOW());

INSERT INTO `universidad`.`examen_por_cita` (`id_examen`, `id_cita`, `observacion`, `estado`, `usuario_creación`, `fecha_creacion`) VALUES 
(1, 1, 'Control de glucosa', 1, 3, NOW()), -- Hemograma para Pedro
(3, 4, 'Evaluar tamaño cardíaco', 1, 3, NOW()), -- Radiografía para Miguel
(5, 4, 'Evaluar ritmo cardíaco', 1, 3, NOW()); -- Electro para Miguel

INSERT INTO `universidad`.`diagnostico_por_cita` (`id_cita`, `id_diagnostico`, `observacion`) VALUES 
(1, 4, 'Dolor de cabeza tensional'),
(2, 6, 'Dermatitis de contacto'),
(4, 2, 'Hipertensión grado 1');

INSERT INTO `universidad`.`interconsulta` (`id_interconsulta`, `id_cita`, `razon_interconsulta`) VALUES 
(2, 1, 'Evaluar posible hipertensión secundaria'), -- Cardiología para Pedro
(3, 4, 'Evaluar lesiones en piel por medicación'); -- Dermatología para Miguel

