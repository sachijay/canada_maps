##++++++++++++++++++++++++++++++++++++++++++++++++++++##
##                                                    ##
## This file exports simplified map data into a files ##
##                                                    ##
##++++++++++++++++++++++++++++++++++++++++++++++++++++##



## Install packages from CRAN ####
## `sf` - To read the shapefiles
## `geojsonio` - GeoJSON object handling
## `rmapshaper` - Simplify the shapefile
## `here` - To find files

cran_packages <- c(
  "sf",
  "geojsonio",
  "rmapshaper",
  "here"
)
if (length(missing_pkgs <- setdiff(cran_packages, rownames(installed.packages()))) > 0) {
  message("Installing missing package(s): ", 
          paste(missing_pkgs, collapse = ", "))
  install.packages(missing_pkgs, 
                   repos = "https://cloud.r-project.org")
} else {
  message("All CRAN packages already installed!")
}
rm(cran_packages, missing_pkgs)



## Provinces and territories maps ####

## Read the original shapefiles
province_territory_map_raw <- sf::read_sf(
  dsn = here::here("statcan_files", "province_territory_map"), 
  layer = "lpr_000b16a_e"
)

## Convert the `sp` object into a GeoJSON object
province_territory_map_raw_json <- geojsonio::geojson_json(
  province_territory_map_raw
)

## Save the GeoJSON file
geojsonio::geojson_write(
  province_territory_map_raw_json,
  file = here::here("exported_files", "province_territory.geojson")
)

## Simplify the map object
province_territory_map_sim_sp <- rmapshaper::ms_simplify(province_territory_map_raw)
province_territory_map_sim_json <- rmapshaper::ms_simplify(province_territory_map_raw_json)


## Save the simplified file
sf::st_write(
  obj = province_territory_map_sim_sp, 
  dsn = here::here("exported_files", "province_territory_simplified_sp"), 
  layer = "province_territory_simplified_sp", 
  driver = "ESRI Shapefile"
)
geojsonio::geojson_write(
  province_territory_map_sim_json,
  file = here::here("exported_files", "province_territory_simplified.geojson")
)



## Census forward sortation areas (FSA) maps ####

## Read the original shapefiles
fsa_map_raw <- sf::read_sf(
  dsn = here::here("statcan_files", "forward_sortation_areas_map"), 
  layer = "lfsa000b21a_e"
)

## Convert the `sp` object into a GeoJSON object
fsa_map_raw_json <- geojsonio::geojson_json(
  fsa_map_raw
)

## Save the GeoJSON file
geojsonio::geojson_write(
  fsa_map_raw_json,
  file = here::here("exported_files", "forward_sortation_areas.geojson")
)


## Simplify the map object
fsa_map_sim_sp <- rmapshaper::ms_simplify(
  fsa_map_raw,
  sys = TRUE,
  sys_mem = 32
)
fsa_map_sim_json <- rmapshaper::ms_simplify(
  fsa_map_raw_json,
  sys = TRUE,
  sys_mem = 32
)


## Save the simplified file
sf::st_write(
  obj = fsa_map_sim_sp, 
  dsn = here::here("exported_files", "forward_sortation_areas_simplified_sp"), 
  layer = "forward_sortation_areas_simplified_sp", 
  driver = "ESRI Shapefile"
)
geojsonio::geojson_write(
  fsa_map_sim_json,
  file = here::here("exported_files", "forward_sortation_areas_simplified.geojson")
)
