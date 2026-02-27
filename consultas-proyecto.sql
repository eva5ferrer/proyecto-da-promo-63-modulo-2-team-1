USE echo_milenial;

-- 📅 DÍA 1: "The Urban Pulse" (Latin & Rap)
-- Defensa Estratégica: Es el día de la tendencia y la fidelidad. 
-- 1. canciones por genero

SELECT g.genero, COUNT(c.id_cancion) AS total_canciones
FROM canciones AS c
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero IN ('latin', 'rap')
GROUP BY g.genero;

-- Aunque el volumen de canciones es menor (35 de cada uno), estos géneros representan el sonido que estaba a punto de explotar globalmente en 2003. Es una apuesta por la "calidad y el prestigio urbano".

-- 2. Curaduría de Nicho: Listado de todos los títulos de canciones de 'Latin' y 'Rap' para armar el programa. 
-- Ordenar por reproducciones y limitar a 20.

SELECT c.titulo, g.genero, a.nombre_artista, a.reproducciones
FROM canciones AS c
INNER JOIN artistas AS a 
  ON c.id_artista = a.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero IN ('latin', 'rap')
ORDER BY a.reproducciones DESC
LIMIT 20;

-- 3. Los reyes del Cierre: Identificar los artista de 'Latin' con más oyentes para liderar el cierre del día.

SELECT DISTINCT a.nombre_artista, a.oyentes
FROM artistas AS a
INNER JOIN canciones AS c
  ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
  ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
  ON fk.id_genero = g.id_genero
WHERE g.genero = 'latin'
ORDER BY a.oyentes DESC
LIMIT 3;


-- 4. Evolución del Género: Seleccionar canciones de 'Latin' lanzadas específicamente en 2003.

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
  
  
-- 5. Eficiencia de Reproducción: Calcular el promedio (AVG) de reproducciones de los artistas de 'Latin' vs. los de 'Pop' para demostrar que, aunque son menos, tienen un impacto por canción muy alto.

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

-- calculo de todos los géneros -- 
SELECT g.genero, AVG(a.reproducciones) AS impacto_promedio
FROM artistas AS a
INNER JOIN canciones c ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero fk ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g ON fk.id_genero = g.id_genero
WHERE g.genero IN ('Latin', 'Pop', 'Hip-hop', 'Rap', 'Regaetton')
GROUP BY g.genero;


-- 📅 DÍA 2: "The Titans of the Era" (Mainstream Pop & Hip Hop)
-- Defensa Estratégica: Este día está diseñado para el volumen masivo y el retorno de inversión rápido. 

-- 7. Consulta de generos
SELECT g.genero, COUNT(c.id_cancion) AS numero_canciones
FROM generos AS g
LEFT JOIN FK_id_cancion_id_genero AS fk ON g.id_genero = fk.id_genero
LEFT JOIN Canciones AS c ON fk.id_cancion = c.id_cancion
GROUP BY g.genero
ORDER BY numero_canciones DESC;

-- A prtir de estos resultados, usamos el Hip Hop (Top 1) y el Pop (Top 2) para asegurar el sold out. 
-- Los datos demuestran quiénes son los dueños del mercado.

-- 8. Ranking de Convocatoria: Seleccionar los 10 artistas de Pop y Hip Hop con más reproducciones para definir los cabezas de cartel (Headliners).

SELECT nombre_artista, reproducciones 
FROM artistas 
ORDER BY reproducciones DESC 
LIMIT 10;

-- 9. Dominio de Catálogo: Contar cuántas canciones tiene cada artista de Hip Hop para identificar quién tiene el repertorio 
-- más sólido para un show largo.

SELECT a.nombre_artista, COUNT(c.id_cancion) AS num_canciones, a.oyentes 
FROM artistas a
LEFT JOIN canciones c ON a.id_artista = c.id_artista
GROUP BY a.id_artista
HAVING num_canciones > 5
ORDER BY a.oyentes DESC; -- lo ordenamos por oyentes o por canciones?

-- 10. El "Efecto 2000": Filtrar todas las canciones de Pop del año 2000 para crear un bloque nostálgico de apertura del festival. 
-- Limitar respuesta a 20 canciones y ordenar por reproducciones de los artistas y mostrando el nombre de los cantantes.

SELECT c.titulo, c.anio, a. reproducciones AS reproducciones_artista, a.nombre_artista
FROM canciones AS c
LEFT JOIN artistas AS a
USING (id_artista)
WHERE c.anio = 2000 
ORDER BY a.reproducciones DESC
LIMIT 20; 

-- 11. Audiencia Acumulada: Sumar el total de oyentes de los géneros Pop y Hip Hop para presentar al cliente el alcance potencial de marketing.

SELECT g.genero, SUM(a.oyentes) AS alcance_total
FROM artistas AS a
INNER JOIN canciones AS c
ON a.id_artista = c.id_artista
INNER JOIN fk_id_cancion_id_genero AS fk
ON c.id_cancion = fk.id_cancion
INNER JOIN generos AS g
ON fk.id_genero = g.id_genero
WHERE g.genero IN ('pop', 'hip-hop')
GROUP BY g.genero;


-- 12. Análisis de "Power Play": Identificar artistas que tengan más de 1,000,000 de reproducciones pero menos de 5 canciones 
-- (artistas de "One Hit Wonder" ideales para apariciones especiales).

SELECT a.nombre_artista, a.reproducciones, a.oyentes,COUNT(c.id_cancion) AS N_canciones 
FROM artistas AS a
INNER JOIN canciones AS c ON a.id_artista = c.id_artista
WHERE a.id_artista IN (
    SELECT id_artista 
    FROM canciones 
    GROUP BY id_artista 
    HAVING COUNT(id_cancion) < 5
)
AND a.reproducciones > 1000000
GROUP BY a.nombre_artista, a.reproducciones, a.oyentes
ORDER BY a.reproducciones DESC;
