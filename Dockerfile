FROM rocker/shiny:4.3.0
RUN install2.r rsconnect reshape2 plotly 

# This part is to deploy to shinyapps.io 
WORKDIR /home/shinyusr
COPY Global.R Global.R
COPY ui.R ui.R
COPY server.R server.R
COPY data/kallisto_tpm_expression_table.txt kallisto_tpm_expression_table.txt
COPY deploy.R deploy.R
CMD Rscript deploy.R


