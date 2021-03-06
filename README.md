
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Files for plotting maps of Canada

This repository contains **simplified** GeoJSON and shapefiles for
plotting maps of Canada. The original shapefiles were obtained from
[Statistics Canada 2016 Census - Boundary
files](https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm)
which are saved in the [`statcan_files/`](statcan_files/) directory.

The purpose of this repository is to provide simplified map files, as
the original files can be large and takes time to plot. **The
simplifying process can remove fine details in the boundaries,
especially along small geographies**.

## What to download

The converted files are available in the
[`exported_files`](exported_files/) directory as  
- GeoJSON files obtained from directly converting shapefiles
([`province_territory.geojson`](exported_files/province_territory.geojson)),  
- GeoJSON files of the simplified boundaries
([`province_territory_simplified.geojson`](exported_files/province_territory_simplified.geojson)),  
- shapefiles of the simplified boundaries
([`province_territory_simplified_sp`](exported_files/province_territory_simplified_sp/)).

## Example: How to plot in `R`

These are plotted using the [`ggplot2`](https://ggplot2.tidyverse.org/)
package. See \[1\] and \[2\] for code to plot using base plotting
functions.

``` r
library(ggplot2)
```

### From shapefiles

``` r
province_territory_map_sim_sp <- rgdal::readOGR(dsn = here::here("exported_files", "province_territory_simplified_sp"), 
                                                layer = "province_territory_simplified_sp",
                                                use_iconv = TRUE)
```

    ## OGR data source with driver: ESRI Shapefile 
    ## Source: "Z:\documents\github\canada_maps\exported_files\province_territory_simplified_sp", layer: "province_territory_simplified_sp"
    ## with 13 features
    ## It has 6 fields

``` r
ggplot(data = province_territory_map_sim_sp,
       mapping = aes(x = long, y = lat, group = group)) + 
  geom_polygon(colour = "white") + 
  theme_void()
```

    ## Regions defined for each Polygons

<img src="README_files/figure-gfm/shapefile_plot-1.png" width="100%" />

### From GeoJSON files

``` r
province_territory_map_sim_json <- geojsonio::geojson_read(here::here("exported_files", "province_territory_simplified.geojson"),
                                                           what = "sp")
```

    ## Registered S3 method overwritten by 'geojsonsf':
    ##   method        from   
    ##   print.geojson geojson

``` r
ggplot(data = province_territory_map_sim_json,
       mapping = aes(x = long, y = lat, group = group)) + 
  geom_polygon(colour = "white") + 
  theme_void()
```

    ## Regions defined for each Polygons

<img src="README_files/figure-gfm/geojson_plot-1.png" width="100%" />

## Additional notes

The R code used to generate simplified boundary files are available at
[`r_src/generate_geojson.r`](r_src/generate_geojson.r).

## References

\[1\]
<https://www.r-graph-gallery.com/168-load-a-shape-file-into-r.html>  
\[2\]
<https://www.r-graph-gallery.com/325-background-map-from-geojson-format-in-r.html>
