DROP PROCEDURE IF EXISTS universidad.sp_actualizar_estado_usuario;
DELIMITER $$
CREATE PROCEDURE universidad.sp_actualizar_estado_usuario(
    IN p_id_usuario INT,
    IN p_nuevo_estado_general INT
)
BEGIN
    UPDATE universidad.usuario 
    SET estado_general = p_nuevo_estado_general 
    WHERE id_usuario = p_id_usuario;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_actualizar_codigo_verificacion_usuario;
DELIMITER $$
CREATE PROCEDURE universidad.sp_actualizar_codigo_verificacion_usuario(
    IN p_id_usuario INT,
    IN p_nuevo_codigo VARCHAR(10),
    IN p_nueva_fecha_expiracion DATETIME
)
BEGIN
    UPDATE universidad.usuario
    SET 
        codigo_verificacion = p_nuevo_codigo,
        fecha_expiracion_codigo = p_nueva_fecha_expiracion
    WHERE id_usuario = p_id_usuario;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_buscar_usuario_por_correo;
DELIMITER $$
CREATE PROCEDURE universidad.sp_buscar_usuario_por_correo(
    IN p_correo_electronico VARCHAR(255)
)
BEGIN
    SELECT * 
    FROM universidad.usuario 
    WHERE correo_electronico = p_correo_electronico;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_listar_usuarios_por_especialidad_completo;
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_usuarios_por_especialidad_completo(
    IN p_id_usuario INT,
    IN p_id_especialidad INT
)
BEGIN
    SELECT
        -- usuario_por_especialidad
        upe.id_usuario AS id_usuario_usuario_por_especialidad,
        upe.id_especialidad AS id_especialidad_usuario_por_especialidad,
        upe.estado AS estado_usuario_por_especialidad,
        upe.usuario_creación AS usuario_creacion_usuario_por_especialidad,
        upe.fecha_creacion AS fecha_creacion_usuario_por_especialidad,
        upe.usuario_modificación AS usuario_modificacion_usuario_por_especialidad,
        upe.fecha_modificacion AS fecha_modificacion_usuario_por_especialidad,

        -- usuario
        u.id_usuario AS id_usuario_usuario,
        u.tipo_documento AS tipo_documento_usuario,
        u.nro_documento AS nro_documento_usuario,
        u.contrasenha AS contrasenha_usuario,
        u.nombre AS nombre_usuario,
        u.apellido_paterno AS apellido_paterno_usuario,
        u.apellido_materno AS apellido_materno_usuario,
        u.fecha_nacimiento AS fecha_nacimiento_usuario,
        u.correo_electronico AS correo_electronico_usuario,
        u.num_celular AS num_celular_usuario,
        u.cod_medico AS cod_medico_usuario,
        u.genero AS genero_usuario,
        u.estado_general AS estado_general_usuario,
        u.estado_logico AS estado_logico_usuario,
        u.estado AS estado_usuario,
        u.usuario_creacion AS usuario_creacion_usuario,
        u.fecha_creacion AS fecha_creacion_usuario,
        u.usuario_modificacion AS usuario_modificacion_usuario,
        u.fecha_modificacion AS fecha_modificacion_usuario,

        -- especialidad
        e.id_especialidad AS id_especialidad_especialidad,
        e.nombre_especialidad AS nombre_especialidad_especialidad,
        e.precio_consulta AS precio_consulta_especialidad,
        e.estado AS estado_especialidad,
        e.usuario_creación AS usuario_creacion_especialidad,
        e.fecha_creacion AS fecha_creacion_especialidad,
        e.usuario_modificación AS usuario_modificacion_especialidad,
        e.fecha_modificacion AS fecha_modificacion_especialidad

    FROM universidad.usuario_por_especialidad upe
    JOIN universidad.usuario u ON upe.id_usuario = u.id_usuario
    JOIN universidad.especialidad e ON upe.id_especialidad = e.id_especialidad
    WHERE (p_id_usuario IS NULL OR upe.id_usuario = p_id_usuario)
      AND (p_id_especialidad IS NULL OR upe.id_especialidad = p_id_especialidad);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_listar_interconsultas_completo;
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_interconsultas_completo(
    IN p_id_especialidad_interconsulta INT,
    IN p_id_cita INT
)
BEGIN
  SELECT
    -- interconsulta
    i.id_interconsulta AS id_interconsulta_interconsulta,
    i.id_cita AS id_cita_interconsulta,
    i.razon_interconsulta AS razon_interconsulta_interconsulta,

    -- especialidad de la interconsulta
    ei.id_especialidad AS id_especialidad_especialidad_interconsulta,
    ei.nombre_especialidad AS nombre_especialidad_interconsulta,
    ei.precio_consulta AS precio_consulta_interconsulta,
    ei.estado AS estado_interconsulta,
    ei.usuario_creación AS usuario_creacion_interconsulta,
    ei.fecha_creacion AS fecha_creacion_interconsulta,
    ei.usuario_modificación AS usuario_modificacion_interconsulta,
    ei.fecha_modificacion AS fecha_modificacion_interconsulta,

    -- cita
    c.id_cita AS id_cita_cita,
    c.id_medico AS id_medico_cita,
    c.id_especialidad AS id_especialidad_cita,
    c.id_turno AS id_turno_cita,
    c.id_consultorio AS id_consultorio_cita,
    c.hora_inicio AS hora_inicio_cita,
    c.hora_fin AS hora_fin_cita,
    c.fecha_cita AS fecha_cita_cita,
    c.estado_cita AS estado_cita_cita,
    c.usuario_creación AS usuario_creacion_cita,
    c.fecha_creacion AS fecha_creacion_cita,
    c.usuario_modificación AS usuario_modificacion_cita,
    c.fecha_modificacion AS fecha_modificacion_cita,

    -- usuario (médico)
    u.id_usuario AS id_usuario_usuario,
    u.tipo_documento AS tipo_documento_usuario,
    u.nro_documento AS nro_documento_usuario,
    u.contrasenha AS contrasenha_usuario,
    u.nombre AS nombre_usuario,
    u.apellido_paterno AS apellido_paterno_usuario,
    u.apellido_materno AS apellido_materno_usuario,
    u.fecha_nacimiento AS fecha_nacimiento_usuario,
    u.correo_electronico AS correo_electronico_usuario,
    u.num_celular AS num_celular_usuario,
    u.cod_medico AS cod_medico_usuario,
    u.genero AS genero_usuario,
    u.estado_general AS estado_general_usuario,
    u.estado_logico AS estado_logico_usuario,
    u.estado AS estado_usuario,
    u.usuario_creacion AS usuario_creacion_usuario,
    u.fecha_creacion AS fecha_creacion_usuario,
    u.usuario_modificacion AS usuario_modificacion_usuario,
    u.fecha_modificacion AS fecha_modificacion_usuario,

    -- turno
    t.id_turno AS id_turno_turno,
    t.nombre_turno AS nombre_turno_turno,
    t.hora_inicio AS hora_inicio_turno,
    t.hora_fin AS hora_fin_turno,
    t.estado_general AS estado_general_turno,
    t.usuario_creación AS usuario_creacion_turno,
    t.fecha_creacion AS fecha_creacion_turno,
    t.usuario_modificación AS usuario_modificacion_turno,
    t.fecha_modificacion AS fecha_modificacion_turno,

    -- consultorio
    con.id_consultorio AS id_consultorio_consultorio,
    con.numero_consultorio AS numero_consultorio_consultorio,
    con.piso AS piso_consultorio,
    con.estado AS estado_consultorio,
    con.usuario_creación AS usuario_creacion_consultorio,
    con.fecha_creacion AS fecha_creacion_consultorio,
    con.usuario_modificación AS usuario_modificacion_consultorio,
    con.fecha_modificacion AS fecha_modificacion_consultorio,

    -- especialidad de la cita
    ec.id_especialidad AS id_especialidad_especialidad,
    ec.nombre_especialidad AS nombre_especialidad_especialidad,
    ec.precio_consulta AS precio_consulta_especialidad,
    ec.estado AS estado_especialidad,
    ec.usuario_creación AS usuario_creacion_especialidad,
    ec.fecha_creacion AS fecha_creacion_especialidad,
    ec.usuario_modificación AS usuario_modificacion_especialidad,
    ec.fecha_modificacion AS fecha_modificacion_especialidad

  FROM universidad.interconsulta i
    JOIN universidad.cita c ON i.id_cita = c.id_cita
    JOIN universidad.especialidad ei ON i.id_interconsulta = ei.id_especialidad
    JOIN universidad.especialidad ec ON c.id_especialidad = ec.id_especialidad
    JOIN universidad.usuario u ON c.id_medico = u.id_usuario
    JOIN universidad.turno t ON c.id_turno = t.id_turno
    JOIN universidad.consultorio con ON c.id_consultorio = con.id_consultorio

  WHERE (p_id_especialidad_interconsulta IS NULL OR i.id_interconsulta = p_id_especialidad_interconsulta)
    AND (p_id_cita IS NULL OR i.id_cita = p_id_cita);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_listar_examenes_por_cita_completo;
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_examenes_por_cita_completo(
    IN p_id_cita INT,
    IN p_id_examen INT
)
BEGIN
  SELECT
    -- examen_por_cita
    epc.id_cita AS id_cita_examen_por_cita,
    epc.id_examen AS id_examen_examen_por_cita,
    epc.observacion AS observacion_examen_por_cita,
    epc.estado AS estado_examen_por_cita,
    epc.usuario_creación AS usuario_creacion_examen_por_cita,
    epc.fecha_creacion AS fecha_creacion_examen_por_cita,
    epc.usuario_modificación AS usuario_modificacion_examen_por_cita,
    epc.fecha_modificacion AS fecha_modificacion_examen_por_cita,

    -- examen
    e.id_examen AS id_examen_examen,
    e.nombre_examen AS nombre_examen_examen,
    e.estado AS estado_examen,
    e.usuario_creación AS usuario_creacion_examen,
    e.fecha_creacion AS fecha_creacion_examen,
    e.usuario_modificación AS usuario_modificacion_examen,
    e.fecha_modificacion AS fecha_modificacion_examen,

    -- tipo_de_examen
    te.id_tipo_de_examen AS id_tipo_de_examen_tipo_de_examen,
    te.nombre_examen AS nombre_examen_tipo_de_examen,
    te.indicacion AS indicacion_tipo_de_examen,

    -- cita
    c.id_cita AS id_cita_cita,
    c.id_medico AS id_medico_cita,
    c.id_especialidad AS id_especialidad_cita,
    c.id_turno AS id_turno_cita,
    c.id_consultorio AS id_consultorio_cita,
    c.hora_inicio AS hora_inicio_cita,
    c.hora_fin AS hora_fin_cita,
    c.fecha_cita AS fecha_cita_cita,
    c.estado_cita AS estado_cita_cita,
    c.usuario_creación AS usuario_creacion_cita,
    c.fecha_creacion AS fecha_creacion_cita,
    c.usuario_modificación AS usuario_modificacion_cita,
    c.fecha_modificacion AS fecha_modificacion_cita,

    -- usuario (medico)
    u.id_usuario AS id_usuario_usuario,
    u.tipo_documento AS tipo_documento_usuario,
    u.nro_documento AS nro_documento_usuario,
    u.contrasenha AS contrasenha_usuario,
    u.nombre AS nombre_usuario,
    u.apellido_paterno AS apellido_paterno_usuario,
    u.apellido_materno AS apellido_materno_usuario,
    u.fecha_nacimiento AS fecha_nacimiento_usuario,
    u.correo_electronico AS correo_electronico_usuario,
    u.num_celular AS num_celular_usuario,
    u.cod_medico AS cod_medico_usuario,
    u.genero AS genero_usuario,
    u.estado_general AS estado_general_usuario,
    u.estado_logico AS estado_logico_usuario,
    u.estado AS estado_usuario,
    u.usuario_creacion AS usuario_creacion_usuario,
    u.fecha_creacion AS fecha_creacion_usuario,
    u.usuario_modificacion AS usuario_modificacion_usuario,
    u.fecha_modificacion AS fecha_modificacion_usuario,

    -- turno
    t.id_turno AS id_turno_turno,
    t.nombre_turno AS nombre_turno_turno,
    t.hora_inicio AS hora_inicio_turno,
    t.hora_fin AS hora_fin_turno,
    t.estado_general AS estado_general_turno,
    t.usuario_creación AS usuario_creacion_turno,
    t.fecha_creacion AS fecha_creacion_turno,
    t.usuario_modificación AS usuario_modificacion_turno,
    t.fecha_modificacion AS fecha_modificacion_turno,

    -- consultorio
    con.id_consultorio AS id_consultorio_consultorio,
    con.numero_consultorio AS numero_consultorio_consultorio,
    con.piso AS piso_consultorio,
    con.estado AS estado_consultorio,
    con.usuario_creación AS usuario_creacion_consultorio,
    con.fecha_creacion AS fecha_creacion_consultorio,
    con.usuario_modificación AS usuario_modificacion_consultorio,
    con.fecha_modificacion AS fecha_modificacion_consultorio,

    -- especialidad
    esp.id_especialidad AS id_especialidad_especialidad,
    esp.nombre_especialidad AS nombre_especialidad_especialidad,
    esp.precio_consulta AS precio_consulta_especialidad,
    esp.estado AS estado_especialidad,
    esp.usuario_creación AS usuario_creacion_especialidad,
    esp.fecha_creacion AS fecha_creacion_especialidad,
    esp.usuario_modificación AS usuario_modificacion_especialidad,
    esp.fecha_modificacion AS fecha_modificacion_especialidad

  FROM universidad.examen_por_cita epc
    JOIN universidad.examen e ON epc.id_examen = e.id_examen
    JOIN universidad.tipo_de_examen te ON e.id_tipo_de_examen = te.id_tipo_de_examen
    JOIN universidad.cita c ON epc.id_cita = c.id_cita
    JOIN universidad.usuario u ON c.id_medico = u.id_usuario
    JOIN universidad.turno t ON c.id_turno = t.id_turno
    JOIN universidad.consultorio con ON c.id_consultorio = con.id_consultorio
    JOIN universidad.especialidad esp ON c.id_especialidad = esp.id_especialidad

  WHERE (p_id_cita IS NULL OR epc.id_cita = p_id_cita)
    AND (p_id_examen IS NULL OR epc.id_examen = p_id_examen);
END$$

DELIMITER ;


DROP PROCEDURE IF EXISTS universidad.sp_listar_examenes_completo;
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_examenes_completo(
    IN p_id_examen INT,
    IN p_id_tipo_de_examen INT
)
BEGIN
  SELECT
    -- examen
    e.id_examen AS id_examen_examen,
    e.nombre_examen AS nombre_examen_examen,
    e.estado AS estado_examen,
    e.usuario_creación AS usuario_creacion_examen,
    e.fecha_creacion AS fecha_creacion_examen,
    e.usuario_modificación AS usuario_modificacion_examen,
    e.fecha_modificacion AS fecha_modificacion_examen,

    -- tipo_de_examen
    te.id_tipo_de_examen AS id_tipo_de_examen_tipo_de_examen,
    te.nombre_examen AS nombre_examen_tipo_de_examen,
    te.indicacion AS indicacion_tipo_de_examen

  FROM universidad.examen e
  JOIN universidad.tipo_de_examen te ON e.id_tipo_de_examen = te.id_tipo_de_examen
  WHERE (p_id_examen IS NULL OR e.id_examen = p_id_examen)
    AND (p_id_tipo_de_examen IS NULL OR te.id_tipo_de_examen = p_id_tipo_de_examen);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_listar_historia_clinica_por_cita;
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_historia_clinica_por_cita(
    IN p_id_historia INT,
    IN p_id_cita INT
)
BEGIN
  SELECT
    -- historia_clinica_por_cita
    hcc.id_historia AS id_historia_historia_clinica_por_cita,
    hcc.id_cita AS id_cita_historia_clinica_por_cita,
    hcc.peso AS peso_historia_clinica_por_cita,
    hcc.talla AS talla_historia_clinica_por_cita,
    hcc.presion_arterial AS presion_arterial_historia_clinica_por_cita,
    hcc.temperatura AS temperatura_historia_clinica_por_cita,
    hcc.frecuencia_cardiaca AS frecuencia_cardiaca_historia_clinica_por_cita,
    hcc.motivo_consulta AS motivo_consulta_historia_clinica_por_cita,
    hcc.tratamiento AS tratamiento_historia_clinica_por_cita,
    hcc.evolucion AS evolucion_historia_clinica_por_cita,
    hcc.recomendacion AS recomendacion_historia_clinica_por_cita,
    hcc.receta AS receta_historia_clinica_por_cita,
    hcc.estado AS estado_historia_clinica_por_cita,
    hcc.usuario_creación AS usuario_creacion_historia_clinica_por_cita,
    hcc.fecha_creacion AS fecha_creacion_historia_clinica_por_cita,
    hcc.usuario_modificación AS usuario_modificacion_historia_clinica_por_cita,
    hcc.fecha_modificacion AS fecha_modificacion_historia_clinica_por_cita,

    -- historia_clinica
    hc.id_historia AS id_historia_historia_clinica,
    hc.id_paciente AS id_paciente_historia_clinica,
    hc.estado AS estado_historia_clinica,
    hc.usuario_creación AS usuario_creacion_historia_clinica,
    hc.fecha_creacion AS fecha_creacion_historia_clinica,
    hc.usuario_modificación AS usuario_modificacion_historia_clinica,
    hc.fecha_modificacion AS fecha_modificacion_historia_clinica,

    -- cita
    c.id_cita AS id_cita_cita,
    c.id_medico AS id_medico_cita,
    c.id_especialidad AS id_especialidad_cita,
    c.id_turno AS id_turno_cita,
    c.id_consultorio AS id_consultorio_cita,
    c.hora_inicio AS hora_inicio_cita,
    c.hora_fin AS hora_fin_cita,
    c.fecha_cita AS fecha_cita_cita,
    c.estado_cita AS estado_cita_cita,
    c.usuario_creación AS usuario_creacion_cita,
    c.fecha_creacion AS fecha_creacion_cita,
    c.usuario_modificación AS usuario_modificacion_cita,
    c.fecha_modificacion AS fecha_modificacion_cita,

    -- usuario (médico)
    u.id_usuario AS id_usuario_usuario,
    u.tipo_documento AS tipo_documento_usuario,
    u.nro_documento AS nro_documento_usuario,
    u.contrasenha AS contrasenha_usuario,
    u.nombre AS nombre_usuario,
    u.apellido_paterno AS apellido_paterno_usuario,
    u.apellido_materno AS apellido_materno_usuario,
    u.fecha_nacimiento AS fecha_nacimiento_usuario,
    u.correo_electronico AS correo_electronico_usuario,
    u.num_celular AS num_celular_usuario,
    u.cod_medico AS cod_medico_usuario,
    u.genero AS genero_usuario,
    u.estado_general AS estado_general_usuario,
    u.estado_logico AS estado_logico_usuario,
    u.estado AS estado_usuario,
    u.usuario_creacion AS usuario_creacion_usuario,
    u.fecha_creacion AS fecha_creacion_usuario,
    u.usuario_modificacion AS usuario_modificacion_usuario,
    u.fecha_modificacion AS fecha_modificacion_usuario,

    -- turno
    t.id_turno AS id_turno_turno,
    t.nombre_turno AS nombre_turno_turno,
    t.hora_inicio AS hora_inicio_turno,
    t.hora_fin AS hora_fin_turno,
    t.estado_general AS estado_general_turno,
    t.usuario_creación AS usuario_creacion_turno,
    t.fecha_creacion AS fecha_creacion_turno,
    t.usuario_modificación AS usuario_modificacion_turno,
    t.fecha_modificacion AS fecha_modificacion_turno,

    -- consultorio
    con.id_consultorio AS id_consultorio_consultorio,
    con.numero_consultorio AS numero_consultorio_consultorio,
    con.piso AS piso_consultorio,
    con.estado AS estado_consultorio,
    con.usuario_creación AS usuario_creacion_consultorio,
    con.fecha_creacion AS fecha_creacion_consultorio,
    con.usuario_modificación AS usuario_modificacion_consultorio,
    con.fecha_modificacion AS fecha_modificacion_consultorio,

    -- especialidad
    e.id_especialidad AS id_especialidad_especialidad,
    e.nombre_especialidad AS nombre_especialidad_especialidad,
    e.precio_consulta AS precio_consulta_especialidad,
    e.estado AS estado_especialidad,
    e.usuario_creación AS usuario_creacion_especialidad,
    e.fecha_creacion AS fecha_creacion_especialidad,
    e.usuario_modificación AS usuario_modificacion_especialidad,
    e.fecha_modificacion AS fecha_modificacion_especialidad

  FROM universidad.historia_clinica_por_cita hcc
    JOIN universidad.historia_clinica hc    ON hcc.id_historia   = hc.id_historia
    JOIN universidad.cita c                 ON hcc.id_cita       = c.id_cita
    JOIN universidad.usuario u              ON c.id_medico       = u.id_usuario
    JOIN universidad.turno t                ON c.id_turno        = t.id_turno
    JOIN universidad.consultorio con        ON c.id_consultorio  = con.id_consultorio
    JOIN universidad.especialidad e         ON c.id_especialidad = e.id_especialidad

  WHERE (p_id_historia IS NULL OR hcc.id_historia = p_id_historia)
    AND (p_id_cita IS NULL OR hcc.id_cita = p_id_cita);
END$$

DELIMITER ;


-- PROCEDIMIENTO ALMACENADO PARA LISTAR HISTORIA CLÍNICA
-- con opción de filtro por id_historia o id_paciente

DROP PROCEDURE IF EXISTS universidad.sp_listar_historia_clinica;
DELIMITER $$
CREATE PROCEDURE universidad.sp_listar_historia_clinica (
    IN p_id_historia INT,
    IN p_id_paciente INT
)
BEGIN
    SELECT 
        hc.id_historia AS id_historia_historia_clinica,
        hc.id_paciente AS id_paciente_historia_clinica,
        hc.estado AS estado_historia_clinica,
        hc.usuario_creación AS usuario_creacion_historia_clinica,
        hc.fecha_creacion AS fecha_creacion_historia_clinica,
        hc.usuario_modificación AS usuario_modificacion_historia_clinica,
        hc.fecha_modificacion AS fecha_modificacion_historia_clinica,

        -- Usuario (paciente)
        u.id_usuario AS id_usuario_usuario,
        u.tipo_documento AS tipo_documento_usuario,
        u.nro_documento AS nro_documento_usuario,
        u.contrasenha AS contrasenha_usuario,
        u.nombre AS nombre_usuario,
        u.apellido_paterno AS apellido_paterno_usuario,
        u.apellido_materno AS apellido_materno_usuario,
        u.fecha_nacimiento AS fecha_nacimiento_usuario,
        u.correo_electronico AS correo_electronico_usuario,
        u.num_celular AS num_celular_usuario,
        u.cod_medico AS cod_medico_usuario,
        u.genero AS genero_usuario,
        u.estado_general AS estado_general_usuario,
        u.estado_logico AS estado_logico_usuario,
        u.estado AS estado_usuario,
        u.usuario_creacion AS usuario_creacion_usuario,
        u.fecha_creacion AS fecha_creacion_usuario,
        u.usuario_modificacion AS usuario_modificacion_usuario,
        u.fecha_modificacion AS fecha_modificacion_usuario

    FROM universidad.historia_clinica hc
    JOIN universidad.usuario u ON hc.id_paciente = u.id_usuario
    WHERE (p_id_historia IS NULL OR hc.id_historia = p_id_historia)
      AND (p_id_paciente IS NULL OR hc.id_paciente = p_id_paciente);
END$$
DELIMITER ;

-- Eliminar si ya existe
DROP PROCEDURE IF EXISTS universidad.sp_listar_diagnostico_por_cita;

DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_diagnostico_por_cita (
    IN p_id_cita INT,
    IN p_id_diagnostico INT
)
BEGIN
    SELECT
        -- Tabla diagnostico_por_cita
        dpc.id_cita AS id_cita_diagnostico_por_cita,
        dpc.id_diagnostico AS id_diagnostico_diagnostico_por_cita,
        dpc.observacion AS observacion_diagnostico_por_cita,

        -- Tabla diagnostico
        d.id_diagnostico AS id_diagnostico_diagnostico,
        d.nombre_diagnostico AS nombre_diagnostico_diagnostico,
        d.descripcion AS descripcion_diagnostico,
        d.capitulo AS capitulo_diagnostico,
        d.grupo AS grupo_diagnostico,
        d.nivel AS nivel_diagnostico,
        d.activo AS activo_diagnostico,

        -- Tabla cita
        c.id_cita AS id_cita_cita,
        c.id_medico AS id_medico_cita,
        c.id_especialidad AS id_especialidad_cita,
        c.id_turno AS id_turno_cita,
        c.id_consultorio AS id_consultorio_cita,
        c.hora_inicio AS hora_inicio_cita,
        c.hora_fin AS hora_fin_cita,
        c.fecha_cita AS fecha_cita_cita,
        c.estado_cita AS estado_cita_cita,
        c.usuario_creación AS usuario_creacion_cita,
        c.fecha_creacion AS fecha_creacion_cita,
        c.usuario_modificación AS usuario_modificacion_cita,
        c.fecha_modificacion AS fecha_modificacion_cita,

        -- Usuario (médico)
        u.id_usuario AS id_usuario_usuario,
        u.tipo_documento AS tipo_documento_usuario,
        u.nro_documento AS nro_documento_usuario,
        u.contrasenha AS contrasenha_usuario,
        u.nombre AS nombre_usuario,
        u.apellido_paterno AS apellido_paterno_usuario,
        u.apellido_materno AS apellido_materno_usuario,
        u.fecha_nacimiento AS fecha_nacimiento_usuario,
        u.correo_electronico AS correo_electronico_usuario,
        u.num_celular AS num_celular_usuario,
        u.cod_medico AS cod_medico_usuario,
        u.genero AS genero_usuario,
        u.estado_general AS estado_general_usuario,
        u.estado_logico AS estado_logico_usuario,
        u.estado AS estado_usuario,
        u.usuario_creacion AS usuario_creacion_usuario,
        u.fecha_creacion AS fecha_creacion_usuario,
        u.usuario_modificacion AS usuario_modificacion_usuario,
        u.fecha_modificacion AS fecha_modificacion_usuario,

        -- Turno
        t.id_turno AS id_turno_turno,
        t.nombre_turno AS nombre_turno_turno,
        t.hora_inicio AS hora_inicio_turno,
        t.hora_fin AS hora_fin_turno,
        t.estado_general AS estado_general_turno,
        t.usuario_creación AS usuario_creacion_turno,
        t.fecha_creacion AS fecha_creacion_turno,
        t.usuario_modificación AS usuario_modificacion_turno,
        t.fecha_modificacion AS fecha_modificacion_turno,

        -- Consultorio
        con.id_consultorio AS id_consultorio_consultorio,
        con.numero_consultorio AS numero_consultorio_consultorio,
        con.piso AS piso_consultorio,
        con.estado AS estado_consultorio,
        con.usuario_creación AS usuario_creacion_consultorio,
        con.fecha_creacion AS fecha_creacion_consultorio,
        con.usuario_modificación AS usuario_modificacion_consultorio,
        con.fecha_modificacion AS fecha_modificacion_consultorio,

        -- Especialidad
        e.id_especialidad AS id_especialidad_especialidad,
        e.nombre_especialidad AS nombre_especialidad_especialidad,
        e.precio_consulta AS precio_consulta_especialidad,
        e.estado AS estado_especialidad,
        e.usuario_creación AS usuario_creacion_especialidad,
        e.fecha_creacion AS fecha_creacion_especialidad,
        e.usuario_modificación AS usuario_modificacion_especialidad,
        e.fecha_modificacion AS fecha_modificacion_especialidad

    FROM universidad.diagnostico_por_cita dpc
    JOIN universidad.diagnostico d ON dpc.id_diagnostico = d.id_diagnostico
    JOIN universidad.cita c ON dpc.id_cita = c.id_cita
    JOIN universidad.usuario u ON c.id_medico = u.id_usuario
    JOIN universidad.turno t ON c.id_turno = t.id_turno
    JOIN universidad.consultorio con ON c.id_consultorio = con.id_consultorio
    JOIN universidad.especialidad e ON c.id_especialidad = e.id_especialidad

    WHERE
        (p_id_cita IS NULL OR dpc.id_cita = p_id_cita)
        AND (p_id_diagnostico IS NULL OR dpc.id_diagnostico = p_id_diagnostico);
END$$

DELIMITER ;

-- Eliminar si ya existe
DROP PROCEDURE IF EXISTS universidad.sp_listar_citas_completas;

-- Crear el procedimiento
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_citas_completas (
    IN p_id_cita INT,
    IN p_id_especialidad INT,
    IN p_id_medico INT,
    IN p_fecha_cita DATE,
    IN p_hora_inicio TIME,
    IN p_estado_cita TINYINT
)
BEGIN
  SELECT
    -- Tabla cita
    c.id_cita AS id_cita_cita,
    c.id_medico AS id_medico_cita,
    c.id_especialidad AS id_especialidad_cita,
    c.id_turno AS id_turno_cita,
    c.id_consultorio AS id_consultorio_cita,
    c.hora_inicio AS hora_inicio_cita,
    c.hora_fin AS hora_fin_cita,
    c.fecha_cita AS fecha_cita_cita,
    c.estado_cita AS estado_cita_cita,
    c.usuario_creación AS usuario_creacion_cita,
    c.fecha_creacion AS fecha_creacion_cita,
    c.usuario_modificación AS usuario_modificacion_cita,
    c.fecha_modificacion AS fecha_modificacion_cita,

    -- Usuario (medico)
    u.id_usuario AS id_usuario_usuario,
    u.tipo_documento AS tipo_documento_usuario,
    u.nro_documento AS nro_documento_usuario,
    u.contrasenha AS contrasenha_usuario,
    u.nombre AS nombre_usuario,
    u.apellido_paterno AS apellido_paterno_usuario,
    u.apellido_materno AS apellido_materno_usuario,
    u.fecha_nacimiento AS fecha_nacimiento_usuario,
    u.correo_electronico AS correo_electronico_usuario,
    u.num_celular AS num_celular_usuario,
    u.cod_medico AS cod_medico_usuario,
    u.genero AS genero_usuario,
    u.estado_general AS estado_general_usuario,
    u.estado_logico AS estado_logico_usuario,
    u.estado AS estado_usuario,
    u.usuario_creacion AS usuario_creacion_usuario,
    u.fecha_creacion AS fecha_creacion_usuario,
    u.usuario_modificacion AS usuario_modificacion_usuario,
    u.fecha_modificacion AS fecha_modificacion_usuario,

    -- Turno
    t.id_turno AS id_turno_turno,
    t.nombre_turno AS nombre_turno_turno,
    t.hora_inicio AS hora_inicio_turno,
    t.hora_fin AS hora_fin_turno,
    t.estado_general AS estado_general_turno,
    t.usuario_creación AS usuario_creacion_turno,
    t.fecha_creacion AS fecha_creacion_turno,
    t.usuario_modificación AS usuario_modificacion_turno,
    t.fecha_modificacion AS fecha_modificacion_turno,

    -- Consultorio
    con.id_consultorio AS id_consultorio_consultorio,
    con.numero_consultorio AS numero_consultorio_consultorio,
    con.piso AS piso_consultorio,
    con.estado AS estado_consultorio,
    con.usuario_creación AS usuario_creacion_consultorio,
    con.fecha_creacion AS fecha_creacion_consultorio,
    con.usuario_modificación AS usuario_modificacion_consultorio,
    con.fecha_modificacion AS fecha_modificacion_consultorio,

    -- Especialidad
    e.id_especialidad AS id_especialidad_especialidad,
    e.nombre_especialidad AS nombre_especialidad_especialidad,
    e.precio_consulta AS precio_consulta_especialidad,
    e.estado AS estado_especialidad,
    e.usuario_creación AS usuario_creacion_especialidad,
    e.fecha_creacion AS fecha_creacion_especialidad,
    e.usuario_modificación AS usuario_modificacion_especialidad,
    e.fecha_modificacion AS fecha_modificacion_especialidad

  FROM universidad.cita c
  JOIN universidad.usuario u ON c.id_medico = u.id_usuario
  JOIN universidad.turno t ON c.id_turno = t.id_turno
  JOIN universidad.consultorio con ON c.id_consultorio = con.id_consultorio
  JOIN universidad.especialidad e ON c.id_especialidad = e.id_especialidad

  WHERE
    (p_id_cita IS NULL OR c.id_cita = p_id_cita)
    AND (p_id_especialidad IS NULL OR c.id_especialidad = p_id_especialidad)
    AND (p_id_medico IS NULL OR c.id_medico = p_id_medico)
    AND (p_fecha_cita IS NULL OR c.fecha_cita = p_fecha_cita)
    AND (p_hora_inicio IS NULL OR c.hora_inicio = p_hora_inicio)
    AND (p_estado_cita IS NULL OR c.estado_cita = p_estado_cita);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_listar_usuarios_por_rol_completo;
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_usuarios_por_rol_completo(
    IN p_id_usuario INT,
    IN p_id_rol INT
)
BEGIN
    SELECT
        -- usuario_por_rol
        upr.id_usuario AS id_usuario_usuario_por_rol,
        upr.id_rol AS id_rol_usuario_por_rol,
        upr.estado AS estado_usuario_por_rol,
        upr.usuario_creación AS usuario_creacion_usuario_por_rol,
        upr.fecha_creacion AS fecha_creacion_usuario_por_rol,
        upr.usuario_modificación AS usuario_modificacion_usuario_por_rol,
        upr.fecha_modificacion AS fecha_modificacion_usuario_por_rol,

        -- usuario
        u.id_usuario AS id_usuario_usuario,
        u.tipo_documento AS tipo_documento_usuario,
        u.nro_documento AS nro_documento_usuario,
        u.contrasenha AS contrasenha_usuario,
        u.nombre AS nombre_usuario,
        u.apellido_paterno AS apellido_paterno_usuario,
        u.apellido_materno AS apellido_materno_usuario,
        u.fecha_nacimiento AS fecha_nacimiento_usuario,
        u.correo_electronico AS correo_electronico_usuario,
        u.num_celular AS num_celular_usuario,
        u.cod_medico AS cod_medico_usuario,
        u.genero AS genero_usuario,
        u.estado_general AS estado_general_usuario,
        u.estado_logico AS estado_logico_usuario,
        u.estado AS estado_usuario,
        u.usuario_creacion AS usuario_creacion_usuario,
        u.fecha_creacion AS fecha_creacion_usuario,
        u.usuario_modificacion AS usuario_modificacion_usuario,
        u.fecha_modificacion AS fecha_modificacion_usuario,

        -- rol
        r.id_rol AS id_rol_rol,
        r.nombre AS nombre_rol,
        r.estado AS estado_rol,
        r.usuario_creación AS usuario_creacion_rol,
        r.fecha_creacion AS fecha_creacion_rol,
        r.usuario_modificación AS usuario_modificacion_rol,
        r.fecha_modificacion AS fecha_modificacion_rol

    FROM universidad.usuario_por_rol upr
    JOIN universidad.usuario u ON upr.id_usuario = u.id_usuario
    JOIN universidad.rol r ON upr.id_rol = r.id_rol
    WHERE (p_id_usuario IS NULL OR upr.id_usuario = p_id_usuario)
      AND (p_id_rol IS NULL OR upr.id_rol = p_id_rol);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.SP_CIT_LISTAR_MEDICOS;

DELIMITER $$
CREATE PROCEDURE universidad.SP_CIT_LISTAR_MEDICOS()
BEGIN
    SELECT 
        u.id_usuario,
        u.tipo_documento,
        u.nro_documento,
        u.contrasenha,
        u.nombre,
        u.apellido_paterno,
        u.apellido_materno,
        u.fecha_nacimiento,
        u.correo_electronico,
        u.num_celular,
        u.cod_medico,
        u.genero,
        u.estado_general,
        u.estado_logico,
        u.usuario_creacion,
        u.fecha_creacion,
        u.usuario_modificacion,
        u.fecha_modificacion
    FROM usuario u
    INNER JOIN usuario_por_rol upr ON u.id_usuario = upr.id_usuario
    INNER JOIN rol r ON upr.id_rol = r.id_rol
    WHERE upper(r.nombre) = 'MÉDICO'
      -- AND u.estado_logico = 1
      AND upr.estado = 1;
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_reporte_citas_atendidas;

DELIMITER $$

CREATE PROCEDURE universidad.sp_reporte_citas_atendidas (
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    IN p_id_especialidad INT,
    IN p_id_doctor INT
)
BEGIN
    SELECT 
      c.id_cita,
      CONCAT(p.nombre, ' ', p.apellido_paterno, ' ', p.apellido_materno) AS paciente,
      e.nombre_especialidad AS especialidad,
      m.cod_medico,
      CONCAT(m.nombre, ' ', m.apellido_paterno, ' ', m.apellido_materno) AS doctor,
      c.fecha_cita,
      CONCAT(c.hora_inicio, ' - ', c.hora_fin) AS hora
    FROM historia_clinica_por_cita hcc
    JOIN historia_clinica hc ON hcc.id_historia = hc.id_historia
    JOIN usuario p ON hc.id_paciente = p.id_usuario
    JOIN cita c ON hcc.id_cita = c.id_cita
    JOIN usuario m ON c.id_medico = m.id_usuario
    JOIN especialidad e ON c.id_especialidad = e.id_especialidad
    WHERE (p_fecha_desde IS NULL OR c.fecha_cita >= p_fecha_desde)
      AND (p_fecha_hasta IS NULL OR c.fecha_cita <= p_fecha_hasta)
      AND (p_id_especialidad IS NULL OR c.id_especialidad = p_id_especialidad)
      AND (p_id_doctor IS NULL OR c.id_medico = p_id_doctor);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_listar_historia_clinica_por_cita;
DELIMITER $$

CREATE PROCEDURE universidad.sp_listar_historia_clinica_por_cita(
    IN p_id_historia INT,
    IN p_id_cita INT
)
BEGIN
  SELECT
    -- historia_clinica_por_cita
    hcc.id_historia AS id_historia_historia_clinica_por_cita,
    hcc.id_cita AS id_cita_historia_clinica_por_cita,
    hcc.peso AS peso_historia_clinica_por_cita,
    hcc.talla AS talla_historia_clinica_por_cita,
    hcc.presion_arterial AS presion_arterial_historia_clinica_por_cita,
    hcc.temperatura AS temperatura_historia_clinica_por_cita,
    hcc.frecuencia_cardiaca AS frecuencia_cardiaca_historia_clinica_por_cita,
    hcc.motivo_consulta AS motivo_consulta_historia_clinica_por_cita,
    hcc.tratamiento AS tratamiento_historia_clinica_por_cita,
    hcc.evolucion AS evolucion_historia_clinica_por_cita,
    hcc.recomendacion AS recomendacion_historia_clinica_por_cita,
    hcc.receta AS receta_historia_clinica_por_cita,
    hcc.estado AS estado_historia_clinica_por_cita,
    hcc.usuario_creación AS usuario_creacion_historia_clinica_por_cita,
    hcc.fecha_creacion AS fecha_creacion_historia_clinica_por_cita,
    hcc.usuario_modificación AS usuario_modificacion_historia_clinica_por_cita,
    hcc.fecha_modificacion AS fecha_modificacion_historia_clinica_por_cita,

    -- historia_clinica
    hc.id_historia AS id_historia_historia_clinica,
    hc.id_paciente AS id_paciente_historia_clinica,
    hc.estado AS estado_historia_clinica,
    hc.usuario_creación AS usuario_creacion_historia_clinica,
    hc.fecha_creacion AS fecha_creacion_historia_clinica,
    hc.usuario_modificación AS usuario_modificacion_historia_clinica,
    hc.fecha_modificacion AS fecha_modificacion_historia_clinica,
	
    u_paciente.id_usuario AS id_usuario_paciente,
u_paciente.tipo_documento AS tipo_documento_paciente,
u_paciente.nro_documento AS nro_documento_paciente,
u_paciente.contrasenha AS contrasenha_paciente,
u_paciente.nombre AS nombre_paciente,
u_paciente.apellido_paterno AS apellido_paterno_paciente,
u_paciente.apellido_materno AS apellido_materno_paciente,
u_paciente.fecha_nacimiento AS fecha_nacimiento_paciente,
u_paciente.correo_electronico AS correo_electronico_paciente,
u_paciente.num_celular AS num_celular_paciente,
u_paciente.cod_medico AS cod_medico_paciente,
u_paciente.genero AS genero_paciente,
u_paciente.estado_general AS estado_general_paciente,
u_paciente.estado_logico AS estado_logico_paciente,
u_paciente.estado AS estado_paciente,
u_paciente.usuario_creacion AS usuario_creacion_paciente,
u_paciente.fecha_creacion AS fecha_creacion_paciente,
u_paciente.usuario_modificacion AS usuario_modificacion_paciente,
u_paciente.fecha_modificacion AS fecha_modificacion_paciente,
    
    -- cita
    c.id_cita AS id_cita_cita,
    c.id_medico AS id_medico_cita,
    c.id_especialidad AS id_especialidad_cita,
    c.id_turno AS id_turno_cita,
    c.id_consultorio AS id_consultorio_cita,
    c.hora_inicio AS hora_inicio_cita,
    c.hora_fin AS hora_fin_cita,
    c.fecha_cita AS fecha_cita_cita,
    c.estado_cita AS estado_cita_cita,
    c.usuario_creación AS usuario_creacion_cita,
    c.fecha_creacion AS fecha_creacion_cita,
    c.usuario_modificación AS usuario_modificacion_cita,
    c.fecha_modificacion AS fecha_modificacion_cita,

    -- usuario (médico)
    u.id_usuario AS id_usuario_usuario,
    u.tipo_documento AS tipo_documento_usuario,
    u.nro_documento AS nro_documento_usuario,
    u.contrasenha AS contrasenha_usuario,
    u.nombre AS nombre_usuario,
    u.apellido_paterno AS apellido_paterno_usuario,
    u.apellido_materno AS apellido_materno_usuario,
    u.fecha_nacimiento AS fecha_nacimiento_usuario,
    u.correo_electronico AS correo_electronico_usuario,
    u.num_celular AS num_celular_usuario,
    u.cod_medico AS cod_medico_usuario,
    u.genero AS genero_usuario,
    u.estado_general AS estado_general_usuario,
    u.estado_logico AS estado_logico_usuario,
    u.estado AS estado_usuario,
    u.usuario_creacion AS usuario_creacion_usuario,
    u.fecha_creacion AS fecha_creacion_usuario,
    u.usuario_modificacion AS usuario_modificacion_usuario,
    u.fecha_modificacion AS fecha_modificacion_usuario,

    -- turno
    t.id_turno AS id_turno_turno,
    t.nombre_turno AS nombre_turno_turno,
    t.hora_inicio AS hora_inicio_turno,
    t.hora_fin AS hora_fin_turno,
    t.estado_general AS estado_general_turno,
    t.usuario_creación AS usuario_creacion_turno,
    t.fecha_creacion AS fecha_creacion_turno,
    t.usuario_modificación AS usuario_modificacion_turno,
    t.fecha_modificacion AS fecha_modificacion_turno,

    -- consultorio
    con.id_consultorio AS id_consultorio_consultorio,
    con.numero_consultorio AS numero_consultorio_consultorio,
    con.piso AS piso_consultorio,
    con.estado AS estado_consultorio,
    con.usuario_creación AS usuario_creacion_consultorio,
    con.fecha_creacion AS fecha_creacion_consultorio,
    con.usuario_modificación AS usuario_modificacion_consultorio,
    con.fecha_modificacion AS fecha_modificacion_consultorio,

    -- especialidad
    e.id_especialidad AS id_especialidad_especialidad,
    e.nombre_especialidad AS nombre_especialidad_especialidad,
    e.precio_consulta AS precio_consulta_especialidad,
    e.estado AS estado_especialidad,
    e.usuario_creación AS usuario_creacion_especialidad,
    e.fecha_creacion AS fecha_creacion_especialidad,
    e.usuario_modificación AS usuario_modificacion_especialidad,
    e.fecha_modificacion AS fecha_modificacion_especialidad

  FROM universidad.historia_clinica_por_cita hcc
  
    JOIN universidad.historia_clinica hc    ON hcc.id_historia   = hc.id_historia
    JOIN universidad.cita c                 ON hcc.id_cita       = c.id_cita
    JOIN universidad.usuario u              ON c.id_medico       = u.id_usuario
    JOIN universidad.turno t                ON c.id_turno        = t.id_turno
    JOIN universidad.consultorio con        ON c.id_consultorio  = con.id_consultorio
    JOIN universidad.especialidad e         ON c.id_especialidad = e.id_especialidad
	JOIN universidad.usuario u_paciente ON hc.id_paciente = u_paciente.id_usuario
  WHERE (p_id_historia IS NULL OR hcc.id_historia = p_id_historia)
    AND (p_id_cita IS NULL OR hcc.id_cita = p_id_cita);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS universidad.sp_insertar_citas_recurrentes;

DELIMITER $$


CREATE PROCEDURE universidad.sp_insertar_citas_recurrentes (
    IN p_id_medico INT,
    IN p_id_especialidad INT,
    IN p_id_turno INT,
    IN p_id_consultorio INT,
    IN p_fecha_inicio DATE,
    IN p_hora_inicio TIME,
    IN p_hora_fin TIME,
    IN p_repeticiones INT,
    IN p_intervalo_dias INT,
    IN p_usuario_creacion INT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE fecha_actual DATE;

    -- Crear tabla temporal para citas no insertadas
    CREATE TEMPORARY TABLE IF NOT EXISTS citas_no_insertadas (
        fecha DATE,
        hora_inicio TIME,
        hora_fin TIME,
        motivo VARCHAR(100)
    );

    SET fecha_actual = p_fecha_inicio;

    WHILE i < p_repeticiones DO

        -- Verificamos si ya existe una cita para ese consultorio, fecha y rango horario
        IF NOT EXISTS (
            SELECT 1 FROM cita
            WHERE id_consultorio = p_id_consultorio
              AND fecha_cita = fecha_actual
              AND estado_cita = 1
              AND (
                    (hora_inicio < p_hora_fin AND hora_fin > p_hora_inicio)
                  )
        ) THEN
            -- Insertamos la cita
            INSERT INTO cita (
                id_medico,
                id_especialidad,
                id_turno,
                id_consultorio,
                hora_inicio,
                hora_fin,
                fecha_cita,
                estado_cita,
                usuario_creación,
                fecha_creacion
            )
            VALUES (
                p_id_medico,
                p_id_especialidad,
                p_id_turno,
                p_id_consultorio,
                p_hora_inicio,
                p_hora_fin,
                fecha_actual,
                1,
                p_usuario_creacion,
                NOW()
            );
        ELSE
            -- Registramos en la tabla temporal si hubo conflicto
            INSERT INTO citas_no_insertadas (fecha, hora_inicio, hora_fin, motivo)
            VALUES (fecha_actual, p_hora_inicio, p_hora_fin, 'Conflicto: consultorio ocupado');
        END IF;

        -- Avanzamos a la siguiente fecha
        SET fecha_actual = DATE_ADD(fecha_actual, INTERVAL p_intervalo_dias DAY);
        SET i = i + 1;
    END WHILE;

    -- Devolvemos las citas que no se pudieron insertar
    SELECT * FROM citas_no_insertadas;

    -- Limpiar tabla temporal al final
    DROP TEMPORARY TABLE IF EXISTS citas_no_insertadas;
END$$

DELIMITER ;

