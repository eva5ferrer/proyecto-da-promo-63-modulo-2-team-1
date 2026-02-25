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

-- ----------------------------------
USE echo_milenial;

-- 📅 DÍA 1: "The Titans of the Era" (Mainstream Pop & Hip Hop)
-- Defensa Estratégica: Este día está diseñado para el volumen masivo y el retorno de inversión rápido. 

-- 1. Consulta de generos

SELECT g.genero, COUNT(c.id_cancion) AS numero_canciones
FROM generos AS g
LEFT JOIN FK_id_cancion_id_genero AS fk ON g.id_genero = fk.id_genero
LEFT JOIN Canciones AS c ON fk.id_cancion = c.id_cancion
GROUP BY g.genero
ORDER BY numero_canciones DESC;



-- A prtir de estos resultados, usamos el Hip Hop (Top 1) y el Pop (Top 2) para asegurar el sold out. 
-- Los datos demuestran quiénes son los dueños del mercado.

-- 2. Ranking de Convocatoria: Seleccionar los 10 artistas de Pop y Hip Hop con más reproducciones para definir los cabezas de cartel (Headliners).

SELECT nombre_artista, reproducciones 
FROM artistas 
ORDER BY reproducciones DESC 
LIMIT 10;


-- 3. Dominio de Catálogo: Contar cuántas canciones tiene cada artista de Hip Hop para identificar quién tiene el repertorio más sólido para un show largo.

SELECT a.nombre_artista, COUNT(c.id_cancion) AS num_canciones, a.oyentes 
FROM artistas a
LEFT JOIN canciones c ON a.id_artista = c.id_artista
GROUP BY a.id_artista
HAVING num_canciones > 5
ORDER BY a.oyentes DESC;

-- 4. El "Efecto 2000": Filtrar todas las canciones de Pop del año 2000 para crear un bloque nostálgico de apertura del festival.

SELECT titulo, anio 
FROM canciones 
WHERE anio = 2000 
LIMIT 20;

-- 5. Audiencia Acumulada: Sumar el total de oyentes de los géneros Pop y Hip Hop para presentar al cliente el alcance potencial de marketing.


SELECT g.genero, SUM(a.oyentes) AS alcance_total
FROM artistas AS a
INNER JOIN canciones AS c
  ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE LOWER(g.genero) IN ('pop', 'hip-hop')
GROUP BY g.genero;


-- 6. Análisis de "Power Play": Identificar artistas que tengan más de 1,000,000 de reproducciones pero menos de 5 canciones (artistas de "One Hit Wonder" ideales para apariciones especiales).

SELECT nombre_artista, reproducciones, oyentes 
FROM artistas 
WHERE id_artista IN (
SELECT id_artista FROM canciones GROUP BY id_artista HAVING COUNT(id_cancion) < 5
)
AND reproducciones > 1000000;

-- 📅 DÍA 2: "The Urban Pulse" (Latin & Rap)
-- Defensa Estratégica: Es el día de la tendencia y la fidelidad. 
-- 7. canciones por genero

SELECT g.genero, COUNT(c.id_cancion) AS total_canciones
FROM canciones AS c
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero IN ('latin', 'rap')
GROUP BY g.genero;

-- Aunque el volumen de canciones es menor (35 de cada uno), estos géneros representan el sonido que estaba a punto de explotar globalmente en 2003. Es una apuesta por la "calidad y el prestigio urbano".

-- 8. Curaduría de Nicho: Listado de todos los títulos de canciones de 'Latin' y 'Rap' para armar el programa de mano del segundo escenario.

SELECT c.titulo, g.genero, a.nombre_artista
FROM canciones AS c
INNER JOIN artistas AS a 
  ON c.id_artista = a.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero IN ('latin', 'rap')
ORDER BY g.genero, c.titulo;

-- 9. El Rey del Cierre: Identificar al artista de 'Rap' con más oyentes para liderar el cierre del día 2.

SELECT DISTINCT a.nombre_artista, a.oyentes
FROM artistas AS a
INNER JOIN canciones AS c
  ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero = 'rap'
ORDER BY a.oyentes DESC
LIMIT 1;


-- 10. Evolución del Género: Seleccionar canciones de 'Latin' lanzadas específicamente en 2003 para mostrar la modernidad del catálogo.

SELECT c.titulo, a.nombre_artista, c.anio
FROM canciones AS c
INNER JOIN artistas AS a
  ON c.id_artista = a.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero = 'latin'
  AND c.anio = 2003;
  
  
-- Revisar artista y título de canción, no coinciden, pueden estar mal las tuplas??. 
 
SELECT 
  c.titulo,
  a.nombre_artista,
  c.anio
FROM canciones AS c
INNER JOIN artistas AS a
  ON c.id_artista = a.id_artista
WHERE a.nombre_artista = 'Revolver'
  AND c.anio = 2003;
  

-- 11. Contenido de Marca: Extraer el nombre del artista y su biografia (solo de los géneros Latin/Rap) para generar contenido en redes sociales antes del evento.

SELECT DISTINCT a.nombre_artista, a.biografia
FROM artistas AS a
INNER JOIN canciones AS c
  ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero IN ('latin', 'rap')
  AND a.biografia IS NOT NULL;

-- 12. Eficiencia de Reproducción: Calcular el promedio (AVG) de reproducciones de los artistas de 'Latin' vs. los de 'Pop' para demostrar que, aunque son menos, tienen un impacto por canción muy alto.

SELECT g.genero, AVG(a.reproducciones) AS impacto_promedio
FROM artistas AS a
INNER JOIN canciones AS c
  ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero IN ('latin', 'pop')
GROUP BY g.genero;

/*SELECT g.genero, AVG(a.reproducciones) AS impacto_promedio
FROM artistas a
JOIN canciones c ON a.id_artista = c.id_artista
JOIN fk_id_cancion_id_genero fk ON c.id_cancion = fk.id_cancion
JOIN generos g ON fk.id_genero = g.id_genero
WHERE g.genero IN ('Latin', 'Pop', 'Hip-hop', 'Rap')
GROUP BY g.genero;*/

-- 📅 DÍA 3: "The Connection Network" (Discovery & Look-Alikes)
-- Defensa Estratégica: El día del descubrimiento y la optimización de costes. Usamos la tabla de similares para contratar artistas con alta afinidad pero menor caché, 
-- garantizando que el público del Día 1 y 2 regrese para descubrir "su nueva banda favorita".

-- 13. El Artista Influencer: Ranking de los nombre_artista_similar que más se repiten en la tabla de relaciones para identificar al artista más influyente de la época.

SELECT nombre_artista_similar, COUNT(*) AS veces_citado
FROM relacion_artista_con_similares
GROUP BY nombre_artista_similar
ORDER BY veces_citado DESC
LIMIT 5;

-- 14. Algoritmo de Programación: Buscar todos los artistas similares vinculados a los artistas que tocaron el Día 1 (Pop) para asegurar la retención de esa audiencia.

SELECT DISTINCT r.nombre_artista_similar
FROM relacion_artista_con_similares AS r
INNER JOIN artistas AS a
  ON r.nombre_artista = a.nombre_artista
INNER JOIN canciones AS c
  ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
WHERE fk.id_genero = (
  SELECT id_genero 
  FROM generos 
  WHERE genero = 'pop'
);

-- 15. Validación de Talento: Cruzar la tabla de relacion_artista_con_similares con la de artistas para ver cuántos oyentes reales tienen esos artistas recomendados.**********

SELECT r.nombre_artista_similar, a.oyentes, a.reproducciones
FROM relacion_artista_con_similares AS r
INNER JOIN artistas AS a
  ON r.nombre_artista_similar = a.nombre_artista;
  

-- 16. Detección de "Joyas Ocultas": Listar artistas similares que tienen más de 500,000 reproducciones pero que NO están en la lista principal de canciones (oportunidades de contratación externa).

/*SELECT r.nombre_artista_similar, a.reproducciones
FROM relacion_artista_con_similares r
JOIN artistas a ON r.nombre_artista_similar = a.nombre_artista
WHERE a.reproducciones > 500000 
AND r.nombre_artista_similar NOT IN (SELECT DISTINCT nombre_artista FROM artistas);*/

SELECT r.nombre_artista_similar, a.reproducciones
FROM relacion_artista_con_similares AS r
INNER JOIN artistas AS a
  ON r.nombre_artista_similar = a.nombre_artista
WHERE a.reproducciones > 500000
  AND r.nombre_artista_similar NOT IN (
    SELECT DISTINCT a2.nombre_artista
    FROM artistas AS a2
  );


-- 17. Consistencia Estilística: Unir las tablas de canciones, artistas y generos para verificar que los artistas similares propuestos realmente pertenecen al género que el público espera.

  
SELECT DISTINCT r.nombre_artista AS artista_original,
r.nombre_artista_similar AS artista_similar,
g.genero
FROM relacion_artista_con_similares AS r
INNER JOIN artistas AS ao
  ON ao.nombre_artista = r.nombre_artista
INNER JOIN canciones AS co
  ON co.id_artista = ao.id_artista
INNER JOIN fk_id_cancion_id_genero AS fko
  ON fko.id_cancion = co.id_cancion
INNER JOIN generos AS g
  ON g.id_genero = fko.id_genero
INNER JOIN artistas AS asim
  ON asim.nombre_artista = r.nombre_artista_similar
INNER JOIN canciones AS cs
  ON cs.id_artista = asim.id_artista
INNER JOIN fk_id_cancion_id_genero AS fks
  ON fks.id_cancion = cs.id_cancion
WHERE fks.id_genero = fko.id_genero;  




