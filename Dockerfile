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
