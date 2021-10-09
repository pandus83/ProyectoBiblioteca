CREATE TABLE btc.persona
(
    pe_id serial NOT NULL,
    pe_nombre character varying(250),
    pe_apellido_pat character varying(250),
    pe_apellido_mat character varying(250),
    pe_ci character varying(12),
    pe_exp character varying(4),
    pe_nacimiento date,
    pe_direccion character varying(300),
    pe_telefono character varying(12),
    CONSTRAINT persona_pkey PRIMARY KEY (pe_id)

)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;


 
 CREATE TABLE btc.rol
(
    rl_id serial NOT NULL,
    rl_tipo character varying(250),
    rl_descripcion character varying(250),   
    CONSTRAINT rol_pkey PRIMARY KEY (rl_id)    
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;

  CREATE TABLE btc.operacion
(
    op_id serial NOT NULL,
    op_tipo character varying(250),    
    CONSTRAINT operacion_pkey PRIMARY KEY (op_id)    
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;

  CREATE TABLE btc.rol_operacion
(
    rop_id serial NOT NULL,
    op_id integer NOT NULL DEFAULT 0,
    rl_id integer NOT NULL DEFAULT 0,       
    CONSTRAINT rol_operacion_pkey PRIMARY KEY (rop_id),
    FOREIGN KEY(op_id)  REFERENCES btc.operacion(op_id),
    FOREIGN KEY(rl_id)  REFERENCES btc.rol(rl_id)
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE btc.usuario
(
    usu_id serial NOT NULL,
    pe_id integer NOT NULL DEFAULT 0,
    rl_id integer NOT NULL DEFAULT 0,
    usu_nombre character varying(250),   
    usu_correo character varying(300),
    usu_password character varying(300),
    CONSTRAINT usuario_pkey PRIMARY KEY (usu_id), 
    FOREIGN KEY(pe_id)  REFERENCES btc.persona(pe_id),
    FOREIGN KEY(rl_id)  REFERENCES btc.rol(rl_id)
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;
CREATE TABLE btc.autor
(
    at_id serial NOT NULL,
    pe_id integer NOT NULL DEFAULT 0,  
    at_correo character varying(300),
    CONSTRAINT autor_pkey PRIMARY KEY (at_id), 
    FOREIGN KEY(pe_id)  REFERENCES btc.persona(pe_id)    
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE btc.libro
(
    lb_id serial NOT NULL,    
    lb_titulo character varying(250),   
    lb_fecha_publicacion date,
    lb_editorial character varying(300),
    lb_nro_publicacion integer NOT NULL DEFAULT 0,
    lb_pais character varying(300),
    lb_categoria character varying(300),
    CONSTRAINT libro_pkey PRIMARY KEY (lb_id)    
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;
  CREATE TABLE btc.autor_libro
(
    atl_id serial NOT NULL,
    lb_id integer NOT NULL DEFAULT 0,
    at_id integer NOT NULL DEFAULT 0,   
    CONSTRAINT autor_libro_pkey PRIMARY KEY (atl_id),
    FOREIGN KEY(lb_id)  REFERENCES btc.libro(lb_id),
    FOREIGN KEY(at_id)  REFERENCES btc.autor(at_id)
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;
CREATE TABLE btc.ejemplar
(
    ej_id serial NOT NULL,
    lb_id integer NOT NULL DEFAULT 0, 
    ej_status boolean NOT NULL DEFAULT true,
    ej_descripcion character varying(300),    
    CONSTRAINT ejemplar_pkey PRIMARY KEY (ej_id),
    FOREIGN KEY(lb_id)  REFERENCES btc.libro(lb_id)
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;

  CREATE TABLE btc.usuario_ejemplar
(
    uej_id serial NOT NULL,
    ej_id integer NOT NULL DEFAULT 0,
    usu_id integer NOT NULL DEFAULT 0,
    uej_fecha_prestamo date,
    uej_fecha_limite date,
    uej_observacion character varying(1000),
    CONSTRAINT usuario_ejemplar_pkey PRIMARY KEY (uej_id),
    FOREIGN KEY(ej_id)  REFERENCES btc.ejemplar(ej_id),
    FOREIGN KEY(usu_id)  REFERENCES btc.usuario(usu_id)
)
WITH 
(
    OIDS = FALSE
)
TABLESPACE pg_default;
