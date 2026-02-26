#"Inicialmente definimos los nombres como VARCHAR(50), pero durante la fase de carga de datos reales de la API de Last.fm, detectamos un error de truncamiento debido a la longitud de ciertos nombres de artistas. Optamos por una migración en caliente usando ALTER TABLE para ampliar la capacidad a 255 caracteres, asegurando así que no se perdiera ninguna relación de similitud por restricciones de esquema."





Este proyecto académico aborda el ciclo completo de vida de los datos musicales, desde su obtención a través de APIs externas hasta su transformación, normalización y almacenamiento en una base de datos relacional diseñada específicamente para este fin. El trabajo combina información procedente de dos fuentes distintas (Spotify y LastFM) y culmina con la creación de un modelo de datos propio que permite realizar consultas y análisis posteriores para presentar a un cliente un proyecto de festival basado en el analisis de las consultas que hemos hecho a la base de datos.

Funcionalidades del proyecto
El proyecto permite:
- Obtener datos musicales desde dos APIs externas: una fuente tipo Spotify y la API pública de LastFM.
- Filtrar y transformar los datos obtenidos para adaptarlos a un modelo relacional.
- Diseñar y crear las tablas necesarias para representar canciones, artistas, géneros y relaciones entre ellos.
- Integrar información procedente de ambas APIs en una única base de datos.
- Insertar los datos procesados en la base de datos echo_milenial.
- Ejecutar consultas SQL sobre la base de datos creada para obtener información relevante.

Técnicas y conceptos aplicados
- Instalación y uso de librerías para el tratamiento de datos.
- Llamadas a APIs y manejo de respuestas en formato JSON.
- Filtrado de datos según criterios definidos (años, géneros, artistas).
- Manipulación de datos con Pandas: normalización, limpieza de texto, explosión de listas y creación de estructuras tabulares.
- Creación de bases de datos relacionales y definición de claves primarias y foráneas.
- Construcción de tablas intermedias para relaciones de tipo N–N.
- Integración de datos procedentes de múltiples fuentes en un único modelo.
- Inserción de datos en MySQL y control de duplicados.
- Consultas SQL utilizando:
- SELECT
- WHERE
- JOIN
- GROUP BY
- ORDER BY
- Funciones de agregación como COUNT y AVG.

Proceso de extracción y tratamiento de datos
1. Datos procedentes de Spotify
Se partió de un archivo JSON con información musical que incluía canciones, artistas, géneros y años.
El proceso consistió en:
- Seleccionar únicamente las canciones pertenecientes a los años 2000–2003.
- Filtrar los géneros de interés (hip-hop, pop, latin, rap y reggaeton).
- Extraer los campos relevantes para cada canción.
- Generar una lista única de artistas.
- Crear identificadores autoincrementales para los artistas.
- Normalizar la información para construir:
- Una tabla de canciones.
- Una tabla de artistas.
- Una tabla intermedia que relaciona canciones con géneros.
Toda esta información se preparó para su posterior inserción en MySQL.

2. Datos procedentes de LastFM
Para enriquecer la base de datos con información adicional sobre los artistas, se realizó una segunda fase de extracción utilizando la API de LastFM.
El proceso incluyó:
- Carga de variables de entorno para proteger la API key.
- Uso de la lista de artistas obtenida en la fase anterior como punto de partida.
- Realización de peticiones al endpoint de información de artistas.
- Obtención de datos como:
- Nombre del artista
- Número de oyentes
- Número de reproducciones
- Biografía
- Artistas similares
- Limpieza del contenido de la biografía para eliminar elementos no deseados.
- Transformación de la lista de artistas similares en una estructura tabular adecuada.
- Preparación de dos tablas:
- Una tabla con la información principal de cada artista.
- Una tabla con las relaciones entre artistas y artistas similares.

Integración en la base de datos MySQL
Una vez procesados los datos de ambas APIs, se diseñó y creó la base de datos echo_milenial, compuesta por varias tablas relacionadas entre sí.
El modelo incluye:
- Tabla de canciones
- Tabla de artistas
- Tabla de géneros
- Tabla intermedia canción–género
- Tabla de relaciones entre artistas y artistas similares
El diagrama de la base de datos (incluido en el repositorio) muestra la estructura completa y las relaciones entre todas las tablas.
Los datos fueron insertados utilizando sentencias SQL que garantizan la integridad y evitan duplicados.

Contenido del repositorio
El repositorio contiene los siguientes documentos:
- Extracción y filtrado de datos de Spotify: archivo .ipynb con el proceso de selección, normalización y preparación de datos.
- Extracción y tratamiento de datos de LastFM: archivo .ipynb con la obtención de información adicional de artistas y su transformación.
- Construcción de la base de datos: archivo .sql con la creación de tablas, definición de claves y carga de datos.
- Diagrama de la base de datos: archivo .png que representa visualmente la estructura final.
- Consultas SQL: archivo .sql con las consultas realizadas sobre la base de datos creada.


