##########
## OBJETIVO ###
# Este script descarga automáticamente los facsímiles/maquetas de los votos en PDFs oficiales de las elecciones 
# presidenciales, de diputados y senadores en Chile, programadas para el 16 de noviembre de 2025.
# Verifica la existencia de cada PDF antes de descargarlo.
# 
# Los PDFs se guardarán en la carpeta INPUTS de la carpeta_base.
# Si INPUTS no existe, se creará automáticamente, al igual que TRABAJO.
# 
# USO PARA USUARIOS NO AVANZADOS EN R:
# 1. Instalar R y RStudio.
# 2. Guardar este código en la subcarpeta TRABAJO de la carpeta_base.
# 3. Modificar únicamente "ruta_base" al inicio, copiando y pegando la ruta completa entre comillas.
# 4. Ejecutar todo el código de inicio a fin.
# 5. Los PDFs se descargarán en INPUTS.
##########

## LICENCIA Y CITACIÓN ###
# Autor: Roberto Cabrera Tapia
# Fecha: 1 de noviembre de 2025
# Licencia: Creative Commons Atribución 4.0 Internacional (CC BY 4.0)
# https://creativecommons.org/licenses/by/4.0/
#
# Se permite compartir y adaptar este código, incluso con fines comerciales,
# siempre que se otorgue el crédito correspondiente al autor.
#
# Por favor cite así:
# Cabrera Tapia, R. (2025, 1 de noviembre). Código R para descargar los facsímiles de las elecciones 
# presidenciales, diputados y senadores en Chile 2025. Con apoyo de ChatGPT. 
# GitHub. https://github.com/robertocabreratapia/2025_CHILE_ELECCIONES_FACSIMILES
##########



# --- MARCA DE INICIO DEL PROCESO ---
inicio <- Sys.time()  
if(!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, httr) 

# --- DEFINICIÓN DE LA CARPETA BASE ---
ruta_base <- "D:/OneDrive - Universidad Complutense de Madrid (UCM)/01 Ues/Doctorado/UCM/23Experimento/INPUTS/SERVEL/2511 Elecciones Nacionales/2511 Facsimiles"

# --- CREAR SUBCARPETAS AUTOMÁTICAMENTE ---
dir.create(file.path(ruta_base, "INPUTS"), recursive = TRUE, showWarnings = FALSE)
dir.create(file.path(ruta_base, "TRABAJO"), showWarnings = FALSE)

# Rutas que se usarán
carpeta_destino <- file.path(ruta_base, "INPUTS")
script_carpeta <- file.path(ruta_base, "TRABAJO")

message("Carpetas listas:")
message("Descargas: ", carpeta_destino)
message("Scripts: ", script_carpeta)

# --- URL BASE DE SERVEL ---
url_base <- "https://www.servel.cl/wp-content/uploads/2025/10/"

# --- LISTA DE REGIONES CON CÓDIGO OFICIAL ---
regiones_nombres <- c(
  "DE_TARAPACA" = "01", 
  "DE_ANTOFAGASTA" = "02",
  "DE_ATACAMA" = "03",
  "DE_COQUIMBO" = "04",
  "DE_VALPARAISO" = "05",
  "DEL_LIBERTADOR_BDO_OHIGGINS" = "06",
  "DEL_MAULE" = "07",
  "DEL_BIOBIO" = "08", 
  "DE_LA_ARAUCANIA" = "09",
  "DE_LOS_LAGOS" = "10",
  "DE_AYSEN" = "11",
  "DE_MAGALLANES_Y_DE_ANTARTICA_CHILENA" = "12",
  "METROPOLITANA" = "13",
  "DE_LOS_RIOS" = "14",
  "DE_ARICA_Y_PARINACOTA" = "15",
  "DEL_NUBLE" = "16"
  )

# --- DIPUTADOS ---
diputados_df <- tribble(
  ~nombre_region, ~distrito,
  "DE_ARICA_Y_PARINACOTA", 1, 
  "DE_TARAPACA", 2, 
  "DE_ANTOFAGASTA", 3,
  "DE_ATACAMA", 4,
  "DE_COQUIMBO", 5, 
  "DE_VALPARAISO", 6,
  "DE_VALPARAISO", 7,
  "METROPOLITANA", 8,
  "METROPOLITANA", 9,
  "METROPOLITANA", 10, 
  "METROPOLITANA", 11, 
  "METROPOLITANA", 12,
  "METROPOLITANA", 13, 
  "METROPOLITANA", 14, 
  "DEL_LIB_GRAL_BDO_OHIGGINS", 15, 
  "DEL_LIB_GRAL_BDO_OHIGGINS", 16, 
  "DEL_MAULE", 17, 
  "DEL_MAULE", 18,
  "DEL_NUBLE", 19, 
  "DEL_BIOBIO", 20, 
  "DEL_BIOBIO", 21,
  "DE_LA_ARAUCANIA", 22, 
  "DE_LA_ARAUCANIA", 23,
  "DE_LOS_RIOS", 24,
  "DE_LOS_LAGOS", 25, 
  "DE_LOS_LAGOS", 26, 
  "DE_AYSEN", 27, 
  "DE_MAGALLANES_Y_DE_ANTARTICA_CHILENA", 28
  ) %>%
  mutate(
    distrito = str_pad(distrito, 2, pad="0"),
    num_region = regiones_nombres[nombre_region],
    cargo = "DIPUTADOS",
    url = paste0(url_base, "DIPUTADOS_", distrito, "_", num_region, "_REGION_", nombre_region, ".pdf")
  )

# --- DIPUTADOS METROPOLITANA ESPECIALES ---
rm_df <- tibble(
  nombre_region = "METROPOLITANA",
  id = str_pad(8:14, 2, pad = "0"),
  cargo = "DIPUTADOS",
  num_region = "13"
) %>%
  mutate(
    url = paste0(url_base, "DIPUTADOS_", id, "_REGION_METROPOLITANA.pdf")
  )

# --- SENADORES ---
senadores_df <- tribble(
  ~nombre_region, ~circunscripcion,
  "DE_ARICA_Y_PARINACOTA", 1,
  "DE_TARAPACA", 2,
  "DE_ANTOFAGASTA", 3, 
  "DE_ATACAMA", 4,
  "DE_COQUIMBO", 5,
  "DE_VALPARAISO", 6,
  "METROPOLITANA", 7, 
  "DEL_LIB_GRAL_BDO_OHIGGINS", 8,
  "DEL_MAULE", 9,
  "DEL_BIOBIO", 10, 
  "DE_LA_ARAUCANIA", 11, 
  "DE_LOS_RIOS", 12,
  "DE_LOS_LAGOS", 13, 
  "DE_AYSEN", 14, 
  "DE_MAGALLANES_Y_DE_ANTARTICA_CHILENA", 15, 
  "DEL_NUBLE", 16,
  ) %>%
  mutate(
    circunscripcion = str_pad(circunscripcion, 2, pad="0"),
    num_region = regiones_nombres[nombre_region],
    cargo = "SENADORES",
    url = paste0(url_base, "SENADORES_", circunscripcion, "_", num_region, "_REGION_", nombre_region, ".pdf")
  )

# --- PRESIDENTE ---
presidente_df <- tibble(
  cargo = "PRESIDENTE",
  id = NA,
  num_region = "00",
  nombre_region = "NACIONAL",
  url = paste0(url_base, "PRESIDENTE_2025.pdf")
)

# --- UNIR TODOS ---
listado_facsimiles <- bind_rows(
  diputados_df %>% rename(id = distrito),
  rm_df,
  senadores_df %>% rename(id = circunscripcion),
  presidente_df
)

# --- FUNCION PARA VERIFICAR EXISTENCIA ---
url_existe <- function(url) {
  Sys.sleep(runif(1, 0.2, 0.5))
  res <- try(HEAD(url), silent = TRUE)
  if(inherits(res, "try-error")) return(FALSE)
  status_code(res) == 200
}

# --- VERIFICAR EXISTENCIA ---
listado_facsimiles <- listado_facsimiles %>%
  mutate(existe = map_lgl(url, url_existe))
message("Listado completo generado y verificado.")

# --- BARRA DE PROGRESO DE DESCARGA ---
library(progress)  # Necesario para barra de progreso

pdfs_a_descargar <- listado_facsimiles %>% filter(existe)

pb <- progress_bar$new(
  total = nrow(pdfs_a_descargar),
  format = "Descargando [:bar] :percent | :current/:total PDFs"
)

pwalk(pdfs_a_descargar %>% select(url, cargo, id, num_region, nombre_region),
      function(url, cargo, id, num_region, nombre_region) {
        archivo <- ifelse(
          cargo == "PRESIDENTE",
          "2025_CHILE_PRESIDENTE.pdf",
          paste0("2025_CHILE_", cargo, "_", str_pad(id, 2, pad = "0"), "_", num_region, "_REGION_", nombre_region, ".pdf")
        )
        ruta_local <- file.path(carpeta_destino, archivo)
        
        if(!file.exists(ruta_local)) {
          tryCatch({
            download.file(url, destfile = ruta_local, mode = "wb")
            Sys.sleep(runif(1, 0.5, 1.5))
          }, error = function(e) {
            message("Error descargando ", archivo, ": ", e$message)
          })
        }
        pb$tick()  # Actualiza la barra
      })

# --- CIERRE ---
fin <- Sys.time()
duracion <- difftime(fin, inicio, units = "secs")
minutos <- floor(as.numeric(duracion) / 60)
segundos <- round(as.numeric(duracion) %% 60)
message("Proceso completado.")
message("Tiempo total: ", minutos, " minutos y ", segundos, " segundos.")
