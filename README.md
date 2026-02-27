# Proyecto Base de Datos -- Echo Milenial

## 1. Descripción General

Echo Milenial es un proyecto desarrollado en MySQL cuyo
objetivo es almacenar, estructurar y analizar información musical
relacionada con artistas, canciones y géneros.

El proyecto integra procesos básicos mediante Python (Jupyter
Notebook) para la limpieza, filtrado y carga automatizada de datos
provenientes de los API´s Spotify y LastFM.

Se ha diseñado bajo criterios de integridad referencial, normalización y
trazabilidad de datos.

------------------------------------------------------------------------

## 2. Arquitectura del Proyecto

El Proyecto fue dividido en 4 fases:

Fase 1: procesamiento y extracción de datos utilizando herramientas de Python
Fase 2: inserción de los datos filtrados a la base de datos en MySQL Workbench
Fase 3: realización de las consultas para obtener información necesaria
Fase 4: análisis de la información obtenida + establecimiento de conclusiónes 

------------------------------------------------------------------------

## 3. Modelo de Datos

La base de datos sigue un modelo relacional con las siguientes entidades
principales:

-   Artistas
-   Canciones
-   Géneros

Relaciones implementadas mediante claves foráneas para garantizar
integridad referencial.

Características del modelo:

-   Claves primarias autoincrementales
-   Claves foráneas con restricción ON DELETE / ON UPDATE según
    configuración
-   Estructura normalizada 
-   Separación de entidades

------------------------------------------------------------------------

## 4. Estructura de Archivos

### script_nuevo-echo-milenial.sql

Script SQL para la creación completa del esquema.

Incluye:

-   CREATE DATABASE
-   CREATE TABLE
-   Definición de PK
-   Definición de FK
-   Tipos de datos optimizados

------------------------------------------------------------------------

### consultas-proyecto.sql

Archivo con consultas avanzadas para explotación de datos.

Incluye:

-   INNER JOIN y LEFT JOIN
-   GROUP BY y funciones agregadas (COUNT, SUM, AVG)
-   Funciones de filtración WHERE, LIMIT, ORDER BY
-   Consultas analíticas básicas

------------------------------------------------------------------------

### diagrama-bbdd-echo-milenial.mwb

Archivo de diagrama  de MySQL Workbench.

Incluye:
-   Estructura de tablas 
-   Nombres de las columnas de cada tabla
-   Tipos de datos de cada columna
-   Relaciónes entre tablas

------------------------------------------------------------------------

### diagrama-bbdd-echo-milenial-imagen.jpeg

Exportación visual del modelo entidad-relación.

Uso:

-   Documentación técnica
-   Presentacion del proyecto

------------------------------------------------------------------------

### insercion-datos-artistas.ipynb

Jypiter notebook orientado a procesos extracción de datos

Funciones principales:

-   Conexión a MySQL mediante conector Python
-   Transformación de datos
-   Inserciones automatizadas
-   Manejo de excepciones
-   Validación básica de integridad

------------------------------------------------------------------------

### filtrado-datos-spotify.ipynb

Proceso de limpieza y filtrado de datos de la API Spotify.

Incluye:

-   Normalización de campos
-   Eliminación de duplicados y datos nulos
-   Filtrado por criterios específicos
-   Preparación para inserción estructurada

------------------------------------------------------------------------

### filtrado-datos-lastfm.ipynb

Proceso equivalente aplicado a dataset de LastFM.

Permite:

-   Unificación de formatos
-   Ajuste de estructura al modelo relacional
-   Eliminación de duplicados y datos nulos
-   Control de calidad de datos

------------------------------------------------------------------------

## 5. Flujo Operativo Recomendado

1.  Ejecutar script_nuevo-echo-milenial.sql
2.  Procesar datasets (spotify y lastfm) con notebooks de filtrado
3.  Ejecutar insercion-datos-artistas.ipynb
4.  Validar con consultas-proyecto.sql
5.  Generar backup mediante exportación

------------------------------------------------------------------------

## 6. Consideraciones Técnicas

-   Compatible con MySQL 8.x
-   Requiere entorno Python 3.9+ recomendado
-   Uso sugerido de entorno virtual
-   Separación clara entre datos crudos y datos normalizados
-   Posibilidad de escalar el modelo añadiendo tablas intermedias (por
    ejemplo, relación N:M entre canciones y géneros)

------------------------------------------------------------------------

## 7. Posibles Mejoras Futuras

-   Implementación de índices adicionales para optimización de consultas
-   Implementación de procedimientos almacenados
-   Creación de vistas materializadas
-   control del repositorio GitHub
    para evitar posibles conflictos de las versiónes de los archivos
-   Integración con API en tiempo real
