##++++++++++++++++++++++++++++++++++++++++++++++++++++##
##                                                    ##
## This file exports simplified map data into a files ##
##                                                    ##
##++++++++++++++++++++++++++++++++++++++++++++++++++++##



## Install packages from CRAN ####
## `rgdal` - To read the shapefiles
## `geojsonio` - GeoJSON object handling
## `rmapshaper` - Simplify the shapefile
## `here` - To find files

cran_packages <- c("rgdal",
                   "geojsonio",
                   "rmapshaper",
                   "here")
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
province_territory_map_raw <- rgdal::readOGR(dsn = here::here("statcan_files", "province_territory_map"), 
                                             layer = "lpr_000b16a_e",
                                             use_iconv = TRUE, 
                                             encoding = "CP1250")

## Convert the `sp` object into a GeoJSON object
province_territory_map_raw_json <- geojsonio::geojson_json(province_territory_map_raw)

## Save the GeoJSON file
geojsonio::geojson_write(province_territory_map_raw_json,
                         file = here::here("exported_files", "province_territory.geojson"))

## Simplify the map object
province_territory_map_raw_sim_sp <- rmapshaper::ms_simplify(province_territory_map_raw)
province_territory_map_raw_sim_json <- rmapshaper::ms_simplify(province_territory_map_raw_json)


## Save the simplified file
rgdal::writeOGR(obj = province_territory_map_raw_sim_sp, 
                dsn = here::here("exported_files", "province_territory_simplified_sp"), 
                layer = "province_territory_simplified_sp", 
                driver = "ESRI Shapefile")
geojsonio::geojson_write(province_territory_map_raw_sim_json,
                         file = here::here("exported_files", "province_territory_simplified.geojson"))









