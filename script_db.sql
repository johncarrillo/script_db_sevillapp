-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.categoria_id_categoria_seq;

CREATE SEQUENCE public.categoria_id_categoria_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.cliente_id_cliente_seq;

CREATE SEQUENCE public.cliente_id_cliente_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.empresas_id_empresa_seq;

CREATE SEQUENCE public.empresas_id_empresa_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.horario_empresa_id_horario_empresa_seq;

CREATE SEQUENCE public.horario_empresa_id_horario_empresa_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.horario_servicio_id_horario_servicio_seq;

CREATE SEQUENCE public.horario_servicio_id_horario_servicio_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.producto_id_producto_seq;

CREATE SEQUENCE public.producto_id_producto_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.servicio_id_servicio_seq;

CREATE SEQUENCE public.servicio_id_servicio_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.turno_id_turno_seq;

CREATE SEQUENCE public.turno_id_turno_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.cliente definition

-- Drop table

-- DROP TABLE cliente;

CREATE TABLE cliente (
	id_cliente serial4 NOT NULL,
	nombre varchar(100) NULL,
	correo varchar(100) NULL,
	telefono varchar(20) NULL,
	CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
);


-- public.empresa definition

-- Drop table

-- DROP TABLE empresa;

CREATE TABLE empresa (
	id_empresa int4 NOT NULL DEFAULT nextval('empresas_id_empresa_seq'::regclass),
	nit varchar(20) NULL,
	nombre varchar(100) NULL,
	direccion varchar(200) NULL,
	correo varchar(100) NULL,
	imagen_url varchar(200) NULL,
	menu_url varchar(200) NULL,
	telefono varchar(20) NULL,
	whatsapp_url varchar(200) NULL,
	descripcion varchar(500) NULL,
	codigo_qr varchar(200) NULL,
	coordenada point NULL,
	CONSTRAINT empresas_pkey PRIMARY KEY (id_empresa)
);


-- public.categoria definition

-- Drop table

-- DROP TABLE categoria;

CREATE TABLE categoria (
	id_categoria serial4 NOT NULL,
	id_empresa int4 NULL,
	nombre varchar(100) NULL,
	descripcion varchar(500) NULL,
	imagen_url varchar(200) NULL,
	CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria),
	CONSTRAINT categoria_id_empresa_fkey FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);


-- public.horario_empresa definition

-- Drop table

-- DROP TABLE horario_empresa;

CREATE TABLE horario_empresa (
	id_horario_empresa serial4 NOT NULL,
	id_empresa int4 NULL,
	dia_semana varchar(30) NULL,
	hora_ini varchar(10) NULL,
	hora_fin varchar(10) NULL,
	estado bool NULL,
	CONSTRAINT horario_empresa_pkey PRIMARY KEY (id_horario_empresa),
	CONSTRAINT horario_empresa_id_empresa_fkey FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);


-- public.producto definition

-- Drop table

-- DROP TABLE producto;

CREATE TABLE producto (
	id_producto serial4 NOT NULL,
	id_empresa int4 NULL,
	nombre varchar(100) NULL,
	descripcion varchar(500) NULL,
	imagen_url varchar(200) NULL,
	precio numeric(10, 2) NULL,
	id_categoria int4 NULL,
	CONSTRAINT producto_pkey PRIMARY KEY (id_producto),
	CONSTRAINT producto_fk FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
	CONSTRAINT producto_id_empresa_fkey FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);


-- public.servicio definition

-- Drop table

-- DROP TABLE servicio;

CREATE TABLE servicio (
	id_servicio serial4 NOT NULL,
	id_empresa int4 NULL,
	nombre varchar(100) NULL,
	descripcion varchar(500) NULL,
	imagen_url varchar(200) NULL,
	precio numeric(10, 2) NULL,
	manejo_horario bool NULL,
	manejo_turno bool NULL,
	tiempo_turno_min int2 NULL,
	id_categoria int4 NULL,
	CONSTRAINT servicio_pkey PRIMARY KEY (id_servicio),
	CONSTRAINT servicio_fk FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
	CONSTRAINT servicio_id_empresa_fkey FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);


-- public.horario_servicio definition

-- Drop table

-- DROP TABLE horario_servicio;

CREATE TABLE horario_servicio (
	id_horario_servicio serial4 NOT NULL,
	id_servicio int4 NULL,
	dia_semana varchar(30) NULL,
	hora_ini varchar(10) NULL,
	hora_fin varchar(10) NULL,
	estado bool NULL,
	CONSTRAINT horario_servicio_pkey PRIMARY KEY (id_horario_servicio),
	CONSTRAINT horario_servicio_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);


-- public.turno definition

-- Drop table

-- DROP TABLE turno;

CREATE TABLE turno (
	id_turno serial4 NOT NULL,
	id_cliente int4 NULL,
	id_horario_servicio int4 NULL,
	creado timestamp NULL DEFAULT now(),
	descripcion varchar(500) NULL,
	estado bool NULL,
	CONSTRAINT turno_pkey PRIMARY KEY (id_turno),
	CONSTRAINT turno_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	CONSTRAINT turno_id_horario_servicio_fkey FOREIGN KEY (id_horario_servicio) REFERENCES horario_servicio(id_horario_servicio)
);
