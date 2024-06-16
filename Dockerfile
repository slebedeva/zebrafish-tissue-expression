FROM rocker/shiny:4.3.0
RUN install2.r rsconnect reshape2 plotly 

# This part is to deploy to shinyapps.io (currently not working - timed out)
#RUN R -e "install.packages('askpass')"
#RUN R -e "install.packages('packrat')"
WORKDIR /home/shinyusr
COPY Global.R Global.R
COPY ui.R ui.R
COPY server.R server.R
COPY data/kallisto_tpm_expression_table.txt kallisto_tpm_expression_table.txt
COPY deploy.R deploy.R
#CMD Rscript -e "shiny::runApp()"
CMD Rscript deploy.R

# This part is to have a local container running in browser with shiny-server
# https://www.r-bloggers.com/2021/06/running-shiny-server-in-docker/
#COPY ui.R server.R Global.R data/kallisto_tpm_expression_table.txt /srv/shiny-server/
#USER shiny
#CMD ["/usr/bin/shiny-server"]

