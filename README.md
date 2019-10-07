
<!-- README.md is generated from README.Rmd. Please edit that file -->

# docklearn

<!-- badges: start -->

<!-- badges: end -->

The goal of docklearn is to deploy shiny\_prerendered rmd from R
packages and/or docker

## As an R package

### install the packages

``` r
remotes::install_github("vincentguyader/docklearn")
```

### launch function

``` r
docklearn::run_app()
```

## Using Docker

from the package source ( for example using the Rsutio project)

### build the package

create `"docklearn_*.tar.gz"` file

``` r
devtools::build()
```

### Create a Dockerfile

``` r
#install.packages("golem")
golem::add_dockerfile()
```

> Be sure to put your `docklearn_*.tar.gz` file (generated using
> `devtools::build()` ) in the same folder as the Dockerfile file
> generated.

### build a docker image

In the same folder, put together `docklearn_*.tar.gz` and the
`Dockerfile`. from this folder using terminal launch :

``` bash
docker build -t docklearn .
```

you can now use your container

``` bash
docker run -p 80:80 docklearn
```
