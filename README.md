
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

FROM rocker/r-ver:3.5.1
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN Rscript -e 'remotes::install_version("tidyverse", version = "1.2.1")'
RUN Rscript -e 'remotes::install_version("dplyr", version = "0.8.3")'
RUN Rscript -e 'remotes::install_github("rstudio/learnr@f10154a16b0e864d72c230cc765b50f636850c7c")'
RUN Rscript -e 'remotes::install_github("hadley/ggplot2@115c3960d0fd068f1ca4cfe4650c0e0474aabba5")'
RUN Rscript -e 'remotes::install_github("rstudio/rstudioapi@6e340b4aee92a061ac837f6af3d5fb7d445e0e58")'
COPY docklearn_*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 3838
CMD  ["R", "-e", "docklearn::launch_learn(port=3838,host='0.0.0.0')"]
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
