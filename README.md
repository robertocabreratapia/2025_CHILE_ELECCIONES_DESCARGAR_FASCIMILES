# Código R para descargar los facsímiles de las elecciones presidenciales, diputados y senadores en Chile 2025

## Descripción

Este script permite descargar automáticamente los facsímiles/maquetas de los votos en PDF de las elecciones presidenciales, de diputados y senadores en Chile, programadas para el 16 de noviembre de 2025. Los PDFs son oficiales y publicados por el SERVEL. Si buscas sólo un facsímil, puedes descargarlo directamente desde \INPUTS.

El script:

-   Está en \TRABAJO\251101 Elecciones nacionales, descarga automática facsimiles SERVEL.R
-   Verifica la existencia de cada PDF antes de descargarlo.
-   Descarga los PDFs en la carpeta `INPUTS` dentro de la `carpeta_base`.
-   Genera automáticamente las carpetas necesarias si no existen.
-   Mide el tiempo total del proceso. En mi caso, tarda aproximadamente 2 minutos en descargar la totalidad de los archivos.

## Estructura de carpetas

Al ejecutar el script, se crean estas subcarpetas dentro de la `carpeta_base`: \
carpeta_base/ \
├─ INPUTS/ \# Descarga de PDFs de facsímiles \
├─ TRABAJO/ \# Aquí se guarda este script \
└─ OUTPUTS/ \# Carpeta reservada para resultados futuros

## Requisitos

-   R y RStudio instalados.
-   Conexión a Internet para descargar los PDFs.

## Cómo usar el script

1.  Guardar este script en la subcarpeta `TRABAJO` de la `carpeta_base`.
2.  Modificar únicamente la variable `ruta_base` al inicio del script, copiando y pegando la ruta completa entre comillas.
3.  Ejecutar todo el script de inicio a fin en RStudio.
4.  Los PDFs se descargarán en la carpeta `INPUTS`.

NOTA: SERVEL va cambiando las rutas, por lo que este código, aunque puede servir de base, no necesariamente permitirá descargar los facsímiles más adelante.

## Qué hace cada sección del script

-   **Configuración de directorios:** define la `carpeta_base` y crea las subcarpetas `INPUTS`, `OUTPUTS` y `TRABAJO` si no existen.
-   **Definición de regiones y distritos:** contiene los nombres de las regiones de Chile, los distritos de diputados y las circunscripciones senatoriales. Son los utilizados por SERVEL en la construcción de las URLs de descarga.
-   **Creación de URLs de los PDFs:** construye automáticamente los enlaces a cada facsímil según distrito, circunscripción y tipo de elección.
-   **Verificación de existencia:** comprueba si cada PDF existe en el servidor antes de intentar descargarlo.
-   **Descarga de PDFs:** descarga los archivos existentes en la carpeta `INPUTS` con pausas aleatorias entre descargas para no saturar el servidor.
-   **Medición del tiempo:** mide y muestra el tiempo total del proceso.

## Notas

-   Este script está pensado para usuarios con conocimientos básicos de R.
-   No requiere guardar resultados en `OUTPUTS`, pero la carpeta queda disponible para uso futuro.
-   Los PDFs descargados corresponden a los facsímiles oficiales publicados por el SERVEL.

## Créditos

Este script fue desarrollado con el apoyo de ChatGPT (modelo GPT-5) para la estructuración del código, comentarios explicativos y buenas prácticas en la descarga automatizada de PDFs.

Si usas este código, por favor cítalo como:

**APA 7ma edición:**\
Cabrera Tapia, R. (2025, 1 de noviembre). *Código R para descargar los facsímiles de las elecciones presidenciales, diputados y senadores en Chile 2025*. Con apoyo de ChatGPT.GitHub. <https://github.com/robertocabreratapia/2025_CHILE_ELECCIONES_FACSIMILES>
