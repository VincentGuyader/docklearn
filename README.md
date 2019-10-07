
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

can be created using {golem} with golem::add\_dockerfile() but, you have
to edit the CMD to have
`docklearn::launch_learn(port=80,host='0.0.0.0')`

``` txt

FROM rocker/tidyverse:3.6.1
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN R -e 'remotes::install_cran("learnr")'
RUN R -e 'remotes::install_cran("tidyverse")'
RUN R -e 'remotes::install_cran("dplyr")'
COPY docklearn_*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 80
CMD R -e "docklearn::launch_learn(port=80,host='0.0.0.0')"
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
