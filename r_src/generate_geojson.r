##++++++++++++++++++++++++++++++++++++++++++++++++++++##
##                                                    ##
## This file exports simplified map data into a files ##
##                                                    ##
##++++++++++++++++++++++++++++++++++++++++++++++++++++##



## Install packages from CRAN ####
## `rgdal` - To read the shapefiles
## `geojsonio` - GeoJSON object handling
## `rmapshaper` - Simplify the shapefile

cran_packages <- c("rgdal",
                   "geojsonio",
                   "rmapshaper")
if (length(missing_pkgs <- setdiff(cran_packages, rownames(installed.packages()))) > 0) {
  message("Installing missing package(s): ", 
          paste(missing_pkgs, collapse = ", "))
  install.packages(missing_pkgs, 
                   repos = "https://cloud.r-project.org")
} else {
  message("All CRAN packages already installed!")
}
rm(cran_packages, missing_pkgs)



## Global variables ####

raw_map_file_dir <- "statcan_files/"
exported_map_file_dir <- "exported_files/"



## Provinces and territories maps ####

## Read the original shapefiles
province_territory_map_raw <- rgdal::readOGR(dsn = paste0(raw_map_file_dir, "province_territory_map"), 
                                             layer = "lpr_000b16a_e",
                                             use_iconv = TRUE, 
                                             encoding = "CP1250")

## Convert the `sp` object into a GeoJSON object
province_territory_map_raw_json <- geojsonio::geojson_json(province_territory_map_raw)

## Simplify the map object
province_territory_map_raw_sim <- rmapshaper::ms_simplify(province_territory_map_raw_json)


## Save the simplified file
geojsonio::geojson_write(canada_raw_sim, 
                         file = paste0(exported_map_file_dir, "province_territory_simplified.geojson"))


# map_sf <- read_sf("canada_map/gpr_000b11a_e.shp") 
# 
# map_data <-  rmapshaper::ms_simplify(input = as(map_sf, "Spatial")) %>%
#   st_as_sf() %>% 
#   left_join(dat_last_week %>% 
#               select(pruid, unvacc_fully_txt),
#             by = c("PRUID" = "pruid"))
# 
# 
# 
# map_data %>% 
#   ggplot() +
#   geom_sf(aes(geometry = geometry)) + 
#   geom_sf_label(aes(label = unvacc_fully_txt),
#                 fun.geometry = sf::st_centroid) + 
#   geom_label(x = -140,
#              y = 80,
#              label = dat_last_week %>% 
#                filter(pruid == 1) %>% 
#                pull(unvacc_fully_txt))
# theme_minimal()

