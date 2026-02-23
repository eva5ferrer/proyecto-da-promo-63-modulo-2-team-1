CREATE DATABASE IF NOT EXISTS echo_milenial;
USE echo_milenial;

CREATE TABLE artistas (
    id_artista INT AUTO_INCREMENT, -- Vuestra columna original
    nombre_artista VARCHAR(255) NOT NULL,
    biografia TEXT, 
    oyentes INT,
    reproducciones INT,
    PRIMARY KEY (id_artista) -- El ID es el jefe de la tabla
);

CREATE TABLE canciones (
    id_cancion VARCHAR(80) PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    anio INT,
    id_artista INT,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista)
);

CREATE TABLE generos (
    id_genero INT PRIMARY KEY,
    genero VARCHAR(50) NOT NULL
);

INSERT INTO generos (id_genero, genero)
VALUES
(1, 'hip-hop'),
(2, 'latin'),
(3, 'pop'),
(4, 'regaetton'),
(5, 'rap');

CREATE TABLE fk_id_cancion_id_genero (
    id_cancion VARCHAR(80),
    id_genero INT,
    PRIMARY KEY (id_cancion, id_genero),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
);

CREATE TABLE relacion_artista_con_similares (
    id_relacion INT AUTO_INCREMENT PRIMARY KEY,
	nombre_artista VARCHAR(50) NOT NULL,
    nombre_artista_similar VARCHAR(50) NOT NULL
);
-- 1. Borramos la tabla vieja (esto borra los IDs desordenados)
DROP TABLE IF EXISTS relacion_artista_con_similares;

-- 2. La creamos de nuevo con el tamaño correcto desde el principio
CREATE TABLE relacion_artista_con_similares (
    id_relacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_artista VARCHAR(255) NOT NULL,
    nombre_artista_similar VARCHAR(255) NOT NULL
);
SHOW PROCESSLIST;

SELECT COUNT(*) FROM relacion_artista_con_similares;

