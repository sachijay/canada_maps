
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Files for plotting maps of Canada

This repository contains **simplified** GeoJSON and Spatial object files
for plotting maps of Canada. The original shapefiles were obtained from
[Statistics Canada 2016 Census - Boundary
files](https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm)
which are saved in the [`statcan_files/`](statcan_files/) directory.

The purpose of this repository is to provide simplified map files, as
the original files can be large and takes time to plot. **The
simplifying process can remove fine details in the boundaries,
especially along small geographies**.

## What to download

The converted files are available in the
[`exported_files`](exported_files/) directory as - GeoJSON files
obtained from directly converting shapefiles
(`province_territory.geojson`), - GeoJSON files of the simplified
boundaries (`province_territory_simplified.geojson`), - Spatial object
files of the simplified boundaries (`province_territory_simplified_sp`).

## Example: How to plot in `R`

### Original shapefiles
