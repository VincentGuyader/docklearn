FROM rocker/r-ver:3.6.1
RUN apt-get update && apt-get install -y  git-core pandoc pandoc-citeproc make libxml2-dev
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN Rscript -e 'remotes::install_version("learnr", version = "0.9.2.1")'
RUN Rscript -e 'remotes::install_version("tidyverse", version = "1.2.1")'
RUN Rscript -e 'remotes::install_version("dplyr", version = "0.8.3")'
COPY docklearn_*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');docklearn::run_app()"
