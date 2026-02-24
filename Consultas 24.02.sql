-- 1. Cantidad de canciones por género
SELECT g.genero, COUNT(c.id_cancion) AS numero_canciones
FROM generos AS g
JOIN FK_id_cancion_id_genero AS fk ON g.id_genero = fk.id_genero
JOIN Canciones AS c ON fk.id_cancion = c.id_cancion
GROUP BY g.genero
ORDER BY numero_canciones DESC;

-- 2. Top 10 artistas por oyentes con el género
SELECT DISTINCT a.nombre_artista, a.oyentes, g.genero
FROM artistas AS a
INNER JOIN canciones AS c
USING(id_artista)
INNER JOIN fk_id_cancion_id_genero AS fk
USING(id_cancion)
INNER JOIN generos AS g
USING(id_genero)
ORDER BY oyentes DESC
LIMIT 10;

-- 2** Selección Top 10 Artistas por un género específico
SELECT DISTINCT a.nombre_artista, a.oyentes, g.genero
FROM artistas AS a
INNER JOIN canciones AS c
USING(id_artista)
INNER JOIN fk_id_cancion_id_genero AS fk
USING(id_cancion)
INNER JOIN generos AS g
USING(id_genero) WHERE g.id_genero = 1
ORDER BY oyentes DESC
LIMIT 10;

-- 3. Top 10 artistas por reproducciones y por genero
SELECT DISTINCT a.nombre_artista, a.reproducciones, g.genero
FROM artistas AS a
INNER JOIN canciones AS c
USING(id_artista)
INNER JOIN fk_id_cancion_id_genero AS fk
USING(id_cancion)
INNER JOIN generos AS g
USING(id_genero)
ORDER BY reproducciones DESC
LIMIT 10;

-- 4. Canciones por cada Top 5 de artistas
SELECT a.nombre_artista, c.titulo, g.genero
FROM artistas AS a
INNER JOIN canciones AS c
USING(id_artista)
INNER JOIN fk_id_cancion_id_genero AS fk
USING(id_cancion)
INNER JOIN generos AS g
USING(id_genero)
WHERE a.nombre_artista IN (
SELECT nombre_artista FROM (
SELECT DISTINCT nombre_artista, oyentes
FROM artistas
ORDER BY oyentes DESC
LIMIT 10) AS top_artistas
)
ORDER BY a.nombre_artista, c.titulo;

-- 4**. Cantidad de canciones por cada Top 5 de artistas
SELECT a.nombre_artista, COUNT(c.titulo) AS recuento_canciones, g.genero
FROM artistas AS a
INNER JOIN canciones AS c
USING(id_artista)
INNER JOIN fk_id_cancion_id_genero AS fk
USING(id_cancion)
INNER JOIN generos AS g
USING(id_genero)
WHERE a.nombre_artista IN (
SELECT nombre_artista FROM (
SELECT DISTINCT nombre_artista, oyentes
FROM artistas
ORDER BY oyentes DESC
LIMIT 5) AS top_artistas
)
GROUP BY a.nombre_artista, g.genero
ORDER BY a.nombre_artista;


-- 5. Reproducciones por año de lanzamiento
SELECT DISTINCT a.nombre_artista, a.oyentes, g.genero
FROM artistas AS a
INNER JOIN canciones AS c
USING(id_artista)
INNER JOIN fk_id_cancion_id_genero AS fk
USING(id_cancion)
INNER JOIN generos AS g
USING(id_genero) WHERE g.id_genero = 1
ORDER BY oyentes DESC
LIMIT 5;
