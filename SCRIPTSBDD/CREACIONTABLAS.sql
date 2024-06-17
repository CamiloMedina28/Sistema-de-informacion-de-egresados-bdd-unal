-- MySQL Script generated by MySQL Workbench
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema egresado_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS egresado_db ;

-- -----------------------------------------------------
-- Schema egresado_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS egresado_db DEFAULT CHARACTER SET utf8 ;
USE egresado_db ;


-- -----------------------------------------------------
-- Table egresado_db.informacion_personal_egresado
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.informacion_personal_egresado ;

CREATE TABLE IF NOT EXISTS egresado_db.informacion_personal_egresado (
  egr_numero_de_identificacion INT NOT NULL,
  egr_primer_nombre VARCHAR(45) NOT NULL,
  egr_primer_apellido VARCHAR(45) NOT NULL,
  egr_segundo_apellido VARCHAR(45) NULL,
  egr_sexo ENUM('Masculino', 'Femenino', 'Otro') DEFAULT 'Otro',
  egr_estrato INT NULL,
  egr_grupo_etnico ENUM('Afro', 'Negro', 'Indigena', 'Ninguno', 'Palenquero', 'Raizal del archipielago de San Andres Providencia y Santa Catalina', 'Rom/Gitano') NOT NULL DEFAULT 'Ninguno',
  egr_estado_civil ENUM('Soltero', 'Casado', 'Divorciado', 'Viudo', 'Union libre') NOT NULL DEFAULT 'Soltero',
  egr_discapacidad ENUM('Auditiva', 'Multiples', 'Fisica', 'Intelectual', 'Ninguna', 'Psicosocial', 'Sordoceguera', 'Sordomudismo', 'Visual') NOT NULL DEFAULT 'Ninguna',
  egr_admision_especial ENUM('Paes', 'Peama', 'Ninguna') NULL DEFAULT 'Ninguna',
  egr_victima_conflicto_armado ENUM('Si', 'No') NOT NULL DEFAULT 'No',
  egr_tipo_identificacion VARCHAR(45) NOT NULL,
  egr_pais_nacimiento VARCHAR(45) NOT NULL,
  egr_departamento_nacimiento VARCHAR(45) NULL,
  egr_municipio_nacimiento VARCHAR(45) NOT NULL,
  egr_segundo_nombre VARCHAR(45) NULL,
  PRIMARY KEY (egr_numero_de_identificacion))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table egresado_db.informacion_residencia
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.informacion_residencia ;

CREATE TABLE IF NOT EXISTS egresado_db.informacion_residencia (
  inf_res_egr_numero_de_identificacion INT NOT NULL,
  inf_res_pais_residencia VARCHAR(45) NULL,
  inf_res_departamento_residencia VARCHAR(45) NULL,
  inf_res_municipio_residencia VARCHAR(45) NOT NULL,
  inf_res_ciudad_residencia VARCHAR(45) NOT NULL,
  inf_res_direccion_residencia VARCHAR(45) NULL,
  PRIMARY KEY (inf_res_egr_numero_de_identificacion),
    FOREIGN KEY (inf_res_egr_numero_de_identificacion)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.contacto
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.contacto ;

CREATE TABLE IF NOT EXISTS egresado_db.contacto (
  con_egr_numero_de_identificacion INT NOT NULL,
  con_numero_telefono_principal INT NOT NULL,
  con_correo_electronico_principal VARCHAR(45) NOT NULL,
  con_numero_telefono_adicional INT NULL,
  con_correo_adicional VARCHAR(45) NULL,
  PRIMARY KEY (con_egr_numero_de_identificacion),
    FOREIGN KEY (con_egr_numero_de_identificacion)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.distincion
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.distincion ;

CREATE TABLE IF NOT EXISTS egresado_db.distincion (
  dis_documento_egresado INT NOT NULL,
  dis_año YEAR NOT NULL,
  dist_nombre_distincion VARCHAR(45) NOT NULL,
  dist_descripcion VARCHAR(150) NOT NULL,
  PRIMARY KEY (dis_documento_egresado),
    FOREIGN KEY (dis_documento_egresado)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.hijo_egresado
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.hijo_egresado ;

CREATE TABLE IF NOT EXISTS egresado_db.hijo_egresado (
  hij_documento INT NOT NULL,
  hij_nombre VARCHAR(45) NOT NULL,
  hij_primer_apellido VARCHAR(45) NOT NULL,
  hij_segundo_apellido VARCHAR(45) NULL,
  hij_año_nacimiento YEAR NULL,
  hij_direccion_residencia VARCHAR(45) NULL,
  PRIMARY KEY (hij_documento))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.Familiar
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.familiar ;

CREATE TABLE IF NOT EXISTS egresado_db.familiar (
  fam_egr_numero_documento_identidad INT NOT NULL,
  fam_hijo_egresado_documento INT NOT NULL,
  PRIMARY KEY (fam_egr_numero_documento_identidad, fam_hijo_egresado_documento),
    FOREIGN KEY (fam_egr_numero_documento_identidad)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (fam_hijo_egresado_documento)
    REFERENCES egresado_db.hijo_egresado (hij_documento)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table egresado_db.estudio_realizado
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.estudio_realizado ;

CREATE TABLE IF NOT EXISTS egresado_db.estudio_realizado (
  est_documento_egresado INT NOT NULL,
  est_programa VARCHAR(45) NOT NULL,
  est_institucion_educativa VARCHAR(45) NOT NULL,
  est_sede VARCHAR(45) NULL,
  est_facultad VARCHAR(45) NULL,
  est_fecha_inicio DATE NOT NULL,
  est_fecha_finalizacion DATE NULL,
  est_estado_formación ENUM('En formacion', 'Finalizada', 'No finalizada') NOT NULL DEFAULT 'Finalizada',
  est_nivel_educativo ENUM('Pregrado', 'Tecnico', 'Tecnologo', 'Especializacion', 'Maestria', 'Doctorado', 'Posdoctorado') NOT NULL DEFAULT 'Pregrado',
  PRIMARY KEY (est_documento_egresado, est_programa),
    FOREIGN KEY (est_documento_egresado)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.beca
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.beca ;

CREATE TABLE IF NOT EXISTS egresado_db.beca (
  bec_est_programa_formativo VARCHAR(45) NOT NULL,
  bec_est_documento_egresado INT NOT NULL,
  bec_nombre_beca VARCHAR(45) NOT NULL,
  bec_entidad_otorga VARCHAR(45) NOT NULL,
  bec_fecha_inicio DATE NOT NULL,
  bec_fecha_finalizacion DATE NOT NULL,
  bec_duracion VARCHAR(45) NULL,
  PRIMARY KEY (bec_est_programa_formativo, bec_est_documento_egresado),
    FOREIGN KEY (bec_est_documento_egresado , bec_est_programa_formativo)
    REFERENCES egresado_db.estudio_realizado (est_documento_egresado , est_programa)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '	';

-- -----------------------------------------------------
-- Table egresado_db.idioma
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.idioma ;

CREATE TABLE IF NOT EXISTS egresado_db.idioma (
  idi_nombre VARCHAR(45) NOT NULL,
  idi_idioma_id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (idi_idioma_id))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.idioma_egresado
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.idioma_egresado ;

CREATE TABLE IF NOT EXISTS egresado_db.idioma_egresado (
  idi_egr_numero_de_identificacion INT NOT NULL,
  idi_egr_idi_idioma_id INT NOT NULL,
  idi_egr_nivel VARCHAR(45) NOT NULL,
  PRIMARY KEY (idi_egr_numero_de_identificacion, idi_egr_idi_idioma_id),
  FOREIGN KEY (idi_egr_numero_de_identificacion)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (idi_egr_idi_idioma_id)
    REFERENCES egresado_db.idioma (idi_idioma_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table egresado_db.proyecto_de_investigacion
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.proyecto_de_investigacion ;

CREATE TABLE IF NOT EXISTS egresado_db.proyecto_de_investigacion (
  pro_inv_id_colciencias INT NOT NULL,
  pro_inv_nombre_grupo LONGTEXT NOT NULL,
  pro_inv_descripcion LONGTEXT NOT NULL,
  pro_inv_institucion VARCHAR(45) NOT NULL,
  PRIMARY KEY (pro_inv_id_colciencias))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table egresado_db.investigacion_del_egresado
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.investigacion_del_egresado ;

CREATE TABLE IF NOT EXISTS egresado_db.investigacion_del_egresado (
  inv_documento_egresado INT NOT NULL,
  inv_id_colciencias INT NOT NULL,
  inv_rol_en_grupo VARCHAR(45) NOT NULL,
  inv_fecha_inicio DATE NOT NULL,
  inv_fecha_finalizacion DATE NOT NULL,
  PRIMARY KEY (inv_documento_egresado, inv_id_colciencias),
    FOREIGN KEY (inv_documento_egresado)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (inv_id_colciencias)
    REFERENCES egresado_db.proyecto_de_investigacion (pro_inv_id_colciencias)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.empresa
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.empresa ;

CREATE TABLE IF NOT EXISTS egresado_db.empresa (
  emp_idNit INT NOT NULL,
  emp_matricula_mercantil VARCHAR(45) NULL,
  emp_razon_social VARCHAR(45) NOT NULL,
  emp_direccion VARCHAR(45) NOT NULL,
  emp_telefono INT NOT NULL,
  emp_actividad_economica VARCHAR(45) NULL,
  emp_numero_empleados INT NULL,
  emp_representante_legal VARCHAR(45) NOT NULL,
  emp_correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (emp_idNit))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.convocatoria
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.convocatoria ;

CREATE TABLE IF NOT EXISTS egresado_db.convocatoria (
  con_id INT NOT NULL AUTO_INCREMENT,
  con_empresa_idNit INT NOT NULL,
  con_nombre_cargo VARCHAR(45) NOT NULL,
  con_habilidades VARCHAR(45) NOT NULL,
  con_competencias VARCHAR(45) NOT NULL,
  con_meses_experiencia INT NOT NULL DEFAULT 0,
  con_numero_vacantes VARCHAR(45) NOT NULL,
  con_salario INT NULL,
  con_jornada_trabajo ENUM('MEDIA', 'COMPLETA', 'HORAS') NOT NULL DEFAULT 'COMPLETA',
  con_horario_trabajo MEDIUMTEXT NULL,
  con_teletrabajo ENUM('Si', 'No') NOT NULL DEFAULT 'No',
  con_pais_convocatoria VARCHAR(45) NOT NULL,
  con_ciudad_convocatoria VARCHAR(45) NOT NULL,
  con_fecha_convocatoria DATE NOT NULL,
  con_fecha_expiracion DATE NOT NULL,
  PRIMARY KEY (con_id, con_empresa_idNit),
    FOREIGN KEY (con_empresa_idNit)
    REFERENCES egresado_db.empresa (emp_idNit)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.convocatorias_aplicadas
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.convocatorias_aplicadas ;

CREATE TABLE IF NOT EXISTS egresado_db.convocatorias_aplicadas (
  con_apl_id INT NOT NULL,
  con_apl_emp_idNit INT NOT NULL,
  conv_documento_identidad INT NOT NULL,
  conv_apl_fecha_aplicacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  con_estado ENUM('ACEPTADA', 'EN EVALUACION', 'RECHAZADA') NOT NULL DEFAULT 'EN EVALUACION',
  PRIMARY KEY (con_apl_id, con_apl_emp_idNit, conv_documento_identidad ),
    FOREIGN KEY (con_apl_id , con_apl_emp_idNit)
    REFERENCES egresado_db.convocatoria (con_id , con_empresa_idNit)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (conv_documento_identidad )
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table egresado_db.trabajo
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.trabajo ;

CREATE TABLE IF NOT EXISTS egresado_db.trabajo (
  tra_id INT NOT NULL AUTO_INCREMENT ,
  tra_egr_documento_egresado INT NOT NULL,
  tra_nombre_cargo VARCHAR(45) NULL,
  tra_ocupacion VARCHAR(45) NOT NULL,
  tra_tipo_vinculacion VARCHAR(45) NOT NULL,
  tra_area_desempeño VARCHAR(45) NOT NULL,
  tra_rango_salario VARCHAR(45) NULL,
  tra_fecha_inicio DATE NOT NULL,
  tra_fecha_finalizacion DATE NULL,
  tra_pais VARCHAR(45) NOT NULL,
  tra_departamento VARCHAR(45) NULL,
  tra_municipio VARCHAR(45) NOT NULL,
  tra_emp_id_Nit INT NOT NULL,
  tra_trabajo_actual TINYINT,
  PRIMARY KEY (tra_id,tra_egr_documento_egresado),
    FOREIGN KEY (tra_egr_documento_egresado)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (tra_emp_id_Nit)
    REFERENCES egresado_db.empresa (emp_idNit)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.jefe
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.jefe ;

CREATE TABLE IF NOT EXISTS egresado_db.jefe (
  jef_id INT AUTO_INCREMENT,
  jef_documento_egresado INT NOT NULL,
  jef_nombre VARCHAR(45) NOT NULL,
  jef_primer_apellido VARCHAR(45) NOT NULL,
  jef_segundo_apellidos VARCHAR(45) NULL,
  jef_telefono BIGINT NOT NULL,
  PRIMARY KEY (jef_id,jef_documento_egresado),
    FOREIGN KEY (jef_id,jef_documento_egresado)
    REFERENCES egresado_db.trabajo (tra_id,tra_egr_documento_egresado)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.carnet
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.carnet ;

CREATE TABLE IF NOT EXISTS egresado_db.carnet (
  car_egr_numero_de_identificacion INT NOT NULL,
  car_egr_solicitud TINYINT DEFAULT 1,
  PRIMARY KEY (car_egr_numero_de_identificacion),
    FOREIGN KEY (car_egr_numero_de_identificacion)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.estudiante_pregrado
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.estudiante_pregrado ;

CREATE TABLE IF NOT EXISTS egresado_db.estudiante_pregrado (
  est_pre_numero_de_identificacion INT NOT NULL,
  est_pre_nombre VARCHAR(45) NOT NULL,
  est_pre_primer_apellido VARCHAR(45) NOT NULL,
  est_pre_segundo_apellido VARCHAR(45) NULL,
  est_pre_facultad VARCHAR(45) NOT NULL,
  est_pre_carrera VARCHAR(45) NOT NULL,
  est_pre_admision_especial ENUM('Paes', 'Peama') NULL,
  est_pre_solicitud TINYINT DEFAULT 1,
  PRIMARY KEY (est_pre_numero_de_identificacion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.asesoria
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.asesoria ;

CREATE TABLE IF NOT EXISTS egresado_db.asesoria (
  ase_egr_numero_de_identificacion INT NOT NULL,
  ase_est_pre_numero_de_identificacion INT NOT NULL,
  ase_fecha_inicio DATE NOT NULL,
  ase_fecha_finalizacion VARCHAR(45) NULL,
  PRIMARY KEY ( ase_egr_numero_de_identificacion, ase_est_pre_numero_de_identificacion,ase_fecha_inicio),
    FOREIGN KEY (ase_est_pre_numero_de_identificacion)
    REFERENCES egresado_db.estudiante_pregrado (est_pre_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (ase_egr_numero_de_identificacion)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.prestamo
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.prestamo ;

CREATE TABLE IF NOT EXISTS egresado_db.prestamo (
  pre_egr_numero_documento_identidad INT NOT NULL,
  pre_lib_id INT NOT NULL,
  pre_fecha_prestamo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  pre_fecha_vencimiento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (pre_egr_numero_documento_identidad, pre_lib_id, pre_fecha_prestamo),
    FOREIGN KEY (pre_egr_numero_documento_identidad)
    REFERENCES egresado_db.informacion_personal_egresado (egr_numero_de_identificacion) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (pre_lib_id)
    REFERENCES egresado_db.libro (lib_id_libro)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table egresado_db.libro
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.libro ;
CREATE TABLE IF NOT EXISTS egresado_db.libro (
  lib_id_libro INT NOT NULL,
  lib_titulo VARCHAR(45) NOT NULL,
  lib_biblioteca VARCHAR(45) NOT NULL,
  lib_autor VARCHAR(45) NOT NULL,
  lib_estante VARCHAR(45) NOT NULL,
  PRIMARY KEY (lib_id_libro))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.usuarios
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.usuarios;
CREATE TABLE IF NOT EXISTS usuarios(
	usr_documento INT NOT NULL, 
    usr_username VARCHAR(45) NOT NULL, 
    usr_password TEXT, 
    usr_role VARCHAR(45),
    PRIMARY KEY(usr_documento))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table egresado_db.usuarios por autorizar
-- -----------------------------------------------------
DROP TABLE IF EXISTS egresado_db.usuarios_por_autorizar;
CREATE TABLE IF NOT EXISTS usuarios_por_autorizar(
	usr_aut_documento INT NOT NULL,
    usr_aut_rol VARCHAR(45) NOT NULL, 
	usr_aut_user_name VARCHAR(45) NOT NULL, 
	usr_aut_password TEXT,
    PRIMARY KEY(usr_aut_documento)
)ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Información predeterminada
-- -----------------------------------------------------

INSERT INTO usuarios VALUES 
(111, 'cmedinasa', 'scrypt:32768:8:1$BTVfdDXu77UaPD7q$a8e120f2fdebaa5c4b8f396741f2f9c3c8f230305c31b83cf588a81797e6f200aaafe6eac668553b1e84a90b533ee7914a6803a26e0749ba24fa148b3516f349', 'Administrador'), 
(222, 'sisuarezc', 'scrypt:32768:8:1$BTVfdDXu77UaPD7q$a8e120f2fdebaa5c4b8f396741f2f9c3c8f230305c31b83cf588a81797e6f200aaafe6eac668553b1e84a90b533ee7914a6803a26e0749ba24fa148b3516f349', 'Administrador'), 
(333, 'jramirezes', 'scrypt:32768:8:1$BTVfdDXu77UaPD7q$a8e120f2fdebaa5c4b8f396741f2f9c3c8f230305c31b83cf588a81797e6f200aaafe6eac668553b1e84a90b533ee7914a6803a26e0749ba24fa148b3516f349', 'Administrador');
