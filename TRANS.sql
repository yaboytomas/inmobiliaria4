alter session set "_ORACLE_SCRIPT"=true

CREATE USER TRANS IDENTIFIED BY TRANS 
DEFAULT TABLESPACE SYSAUX
TEMPORARY TABLESPACE TEMP;
ALTER USER TRANS QUOTA UNLIMITED ON SYSAUX;
GRANT CONNECT TO TRANS  ;
GRANT RESOURCE TO TRANS ;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    apellido_paterno VARCHAR(100),
    nombre VARCHAR(100),
    estado_civil VARCHAR(20),
    renta DECIMAL(10, 2)  
);

CREATE TABLE propiedades (
    id_propiedad INT PRIMARY KEY,
    direccion VARCHAR(200),
    tipo VARCHAR(50),
    precio_arriendo DECIMAL(10, 2), 
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE inmobiliarias (
    id_inmobiliaria INT PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(200)
);

CREATE TABLE convenios (
    id_convenio INT PRIMARY KEY,
    id_inmobiliaria INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (id_inmobiliaria) REFERENCES inmobiliarias(id_inmobiliaria)
);

INSERT INTO clientes (id_cliente, apellido_paterno, nombre, estado_civil, renta)
VALUES (1, 'Garcia', 'Juan', 'Soltero', 750000);

INSERT INTO clientes (id_cliente, apellido_paterno, nombre, estado_civil, renta)
VALUES (2, 'Lopez', 'Ana', 'Divorciada', 850000);

INSERT INTO clientes (id_cliente, apellido_paterno, nombre, estado_civil, renta)
VALUES (3, 'Martinez', 'Pedro', 'Separado', 900000);

INSERT INTO clientes (id_cliente, apellido_paterno, nombre, estado_civil, renta)
VALUES (4, 'Rodriguez', 'Luis', 'Soltero', 600000);

INSERT INTO clientes (id_cliente, apellido_paterno, nombre, estado_civil, renta)
VALUES (5, 'Sanchez', 'Maria', 'Divorciada', 820000);

INSERT INTO propiedades (id_propiedad, direccion, tipo, precio_arriendo, id_cliente)
VALUES (1, 'Av. Siempre Viva 742', 'Departamento', 500000, 1);

INSERT INTO propiedades (id_propiedad, direccion, tipo, precio_arriendo, id_cliente)
VALUES (2, 'Calle Falsa 123', 'Loft', 600000, 2);

INSERT INTO propiedades (id_propiedad, direccion, tipo, precio_arriendo, id_cliente)
VALUES (3, 'Av. Las Flores 321', 'Departamento', 700000, 3);

INSERT INTO propiedades (id_propiedad, direccion, tipo, precio_arriendo, id_cliente)
VALUES (4, 'Pasaje Los Cedros 456', 'Loft', 400000, 4);

INSERT INTO propiedades (id_propiedad, direccion, tipo, precio_arriendo, id_cliente)
VALUES (5, 'Calle La Paz 678', 'Departamento', 800000, 5);

INSERT INTO inmobiliarias (id_inmobiliaria, nombre, contacto)
VALUES (1, 'UN SUEÑO', 'contacto@unsueno.com');

INSERT INTO inmobiliarias (id_inmobiliaria, nombre, contacto)
VALUES (2, 'HOGAR IDEAL', 'contacto@hogarideal.com');

INSERT INTO convenios (id_convenio, id_inmobiliaria, fecha_inicio, fecha_fin)
VALUES (1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO convenios (id_convenio, id_inmobiliaria, fecha_inicio, fecha_fin)
VALUES (2, 2, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'));


SELECT *
FROM clientes
WHERE estado_civil IN ('Soltero', 'Separado', 'Divorciada')
ORDER BY apellido_paterno, nombre;


SELECT *
FROM clientes
WHERE estado_civil IN ('Separado', 'Divorciada')
AND renta >= 800000
ORDER BY apellido_paterno, nombre;

CREATE OR REPLACE VIEW view_marketing AS
SELECT *
FROM clientes
WHERE estado_civil IN ('Separado', 'Divorciada')
AND renta >= 800000;

SELECT *
FROM view_marketing
ORDER BY apellido_paterno, nombre;

SELECT p.id_propiedad, p.direccion, p.tipo, p.precio_arriendo,
       c.id_cliente, c.apellido_paterno, c.nombre, c.estado_civil, c.renta
FROM propiedades p
JOIN clientes c ON p.id_cliente = c.id_cliente
ORDER BY p.tipo, p.direccion;


INSERT INTO convenios (id_convenio, id_inmobiliaria, fecha_inicio, fecha_fin)
VALUES (3, 1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


SELECT c.id_convenio, i.id_inmobiliaria, i.nombre AS nombre_inmobiliaria, i.contacto,
       c.fecha_inicio, c.fecha_fin
FROM convenios c
JOIN inmobiliarias i ON c.id_inmobiliaria = i.id_inmobiliaria
WHERE SYSDATE BETWEEN c.fecha_inicio AND c.fecha_fin;




































