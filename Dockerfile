FROM rocker/r-ver:3.5.1
RUN apt-get update && apt-get install -y  git-core make pandoc pandoc-citeproc
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN Rscript -e 'remotes::install_version("magrittr", version = "1.5")'
RUN Rscript -e 'remotes::install_version("purrr", version = "0.3.3")'
RUN Rscript -e 'remotes::install_version("rmarkdown", version = "1.16")'
RUN Rscript -e 'remotes::install_version("stringr", version = "1.4.0")'
RUN Rscript -e 'remotes::install_version("ggplot2", version = "3.2.1")'
RUN Rscript -e 'remotes::install_version("dplyr", version = "0.8.3")'
RUN Rscript -e 'remotes::install_version("knitr", version = "1.25")'
RUN Rscript -e 'remotes::install_version("readr", version = "1.3.1")'
RUN Rscript -e 'remotes::install_github("rstudio/learnr@f10154a16b0e864d72c230cc765b50f636850c7c")'
RUN Rscript -e 'remotes::install_github("rstudio/parsons@dddb877bc7501655741608af680c0230e2e150df")'
COPY docklearn_*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 3838
CMD  ["R", "-e", "docklearn::launch_learn(port=3838,host='0.0.0.0')"]
