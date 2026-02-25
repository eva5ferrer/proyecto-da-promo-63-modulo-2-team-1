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

/* 📅 DÍA 1: "The Titans of the Era" (Mainstream Pop & Hip Hop)
Defensa Estratégica: Este día está diseñado para el volumen masivo y el retorno de inversión rápido. Usamos el Hip Hop (Top 1) y el Pop (Top 2) para asegurar el sold out. Los datos demuestran quiénes son los dueños del mercado.

Ranking de Convocatoria: Seleccionar los 10 artistas de Pop y Hip Hop con más reproducciones para definir los cabezas de cartel (Headliners).

Dominio de Catálogo: Contar cuántas canciones tiene cada artista de Hip Hop para identificar quién tiene el repertorio más sólido para un show largo.

El "Efecto 2000": Filtrar todas las canciones de Pop del año 2000 para crear un bloque nostálgico de apertura del festival.

Audiencia Acumulada: Sumar el total de oyentes de los géneros Pop y Hip Hop para presentar al cliente el alcance potencial de marketing.

Análisis de "Power Play": Identificar artistas que tengan más de 1,000,000 de reproducciones pero menos de 5 canciones (artistas de "One Hit Wonder" ideales para apariciones especiales).

📅 DÍA 2: "The Urban Pulse" (Latin & Rap)
Defensa Estratégica: Es el día de la tendencia y la fidelidad. Aunque el volumen de canciones es menor (35 de cada uno), estos géneros representan el sonido que estaba a punto de explotar globalmente en 2003. Es una apuesta por la "calidad y el prestigio urbano".

Curaduría de Nicho: Listado de todos los títulos de canciones de 'Latin' y 'Rap' para armar el programa de mano del segundo escenario.

El Rey del Cierre: Identificar al artista de 'Rap' con más oyentes para liderar el cierre del día 2.

Evolución del Género: Seleccionar canciones de 'Latin' lanzadas específicamente en 2003 para mostrar la modernidad del catálogo.

Contenido de Marca: Extraer el nombre del artista y su biografia (solo de los géneros Latin/Rap) para generar contenido en redes sociales antes del evento.

Eficiencia de Reproducción: Calcular el promedio (AVG) de reproducciones de los artistas de 'Latin' vs. los de 'Pop' para demostrar que, aunque son menos, tienen un impacto por canción muy alto.

📅 DÍA 3: "The Connection Network" (Discovery & Look-Alikes)
Defensa Estratégica: El día del descubrimiento y la optimización de costes. Usamos la tabla de similares para contratar artistas con alta afinidad pero menor caché, garantizando que el público del Día 1 y 2 regrese para descubrir "su nueva banda favorita".

El Artista Influencer: Ranking de los nombre_artista_similar que más se repiten en la tabla de relaciones para identificar al artista más influyente de la época.

Algoritmo de Programación: Buscar todos los artistas similares vinculados a los artistas que tocaron el Día 1 (Pop) para asegurar la retención de esa audiencia.

Validación de Talento: Cruzar la tabla de relacion_artista_con_similares con la de artistas para ver cuántos oyentes reales tienen esos artistas recomendados.

Detección de "Joyas Ocultas": Listar artistas similares que tienen más de 500,000 reproducciones pero que NO están en la lista principal de canciones (oportunidades de contratación externa).

Consistencia Estilística: Unir las tablas de canciones, artistas y generos para verificar que los artistas similares propuestos realmente pertenecen al género que el público espera.

💡 Cómo presentar esto al cliente:
Al presentar los datos, diles:

"Nuestra propuesta no es azarosa. El Día 1 se basa en Magnitud (consultas 1-5), el Día 2 en Identidad (consultas 6-10) y el Día 3 en Inteligencia de Datos (consultas 11-15) para maximizar cada euro invertido mediante afinidad de audiencia."*/

