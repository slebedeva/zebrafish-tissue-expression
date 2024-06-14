# This is a shiny application to show expression levels of genes in zebrafish tissues.
# Author Svetlana Lebedeva
# License GPL-3.0

library(shiny)
library(plotly)
library(reshape2)

# Set a port (rocker imag uses 3838)
options(shiny.port = 3838)

# User interface which draws a histogram

#shinyUI(fluidPage...
ui <- (fluidPage(
  titlePanel("Expression of mRNAs in adult zebrafish tissues\n
             estimated by kallisto tool in trascripts per million (tpm)"),
  
  sidebarLayout(
    sidebarPanel(
        p("Public RNA-Seq data from adult zebrafish tissues that were processed by ", a("kallisto", href="https://pachterlab.github.io/kallisto/"), "."),
        p("Ensembl annotation was used."),
        p("Studies where the data came from are:"),
        p(" - Ensembl RNA-Seq ", a("Collins 2012", href=""), "(ERR00427-29, 3 ovary samples, paired end, 2x36,not stranded),"),
        p(" - ", a("Kelkar 2014", href="http://www.ncbi.nlm.nih.gov/pubmed/25060758"), " (SRR15625.., paired end, 2x76, not stranded),"),
        p("- ", a("PhyloFish", href="https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-016-2709-z"), "(SRR15242.., paired end, 2x100, not stranded),"),
        p(" - ", a("Lebedeva 2017", href="https://doi.org/10.1080/15476286.2016.1256532"), "(GSE85554, paired end 2x100, stranded)"),
        br(),
        div("Note of caution:", style = "color:red"),
        p("Transcript abundance estimates are not normalized and cannot directly be compared across tissues."),
        p("However, ", a("TPM ", href="https://haroldpimentel.wordpress.com/2014/05/08/what-the-fpkm-a-review-rna-seq-expression-units/"),
                         "give a good approximation of the transcript abundance within the tissue."),
        
        
      textInput("gene", label = "Type gene symbol exactly as in Ensembl (piwil1) or Ensembl ID (ENSDARG...)", 
                value = "piwil1"),
      
      submitButton("Submit"),
    
      downloadButton('downloadData', 'Download Transcript counts')
      # downloadButton('downloadPlot', 'Download Plot')
                ),
    

      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Plot", plotlyOutput("plot")),
                    tabPanel("Table", tableOutput("table"))
                    )
                )
    
    
    ) #sidebarlayout
  ) #fluidpage
) #shinyui


  
  
# Server part that loads the data 


#load data once:

m <- read.table(file = "kallisto_tpm_expression_table.txt")

#shinyServer(function(....
server <- (function(input, output) {
  
  geneInput <- renderText(input$gene)

  output$plot <- renderPlotly({
    goi <- geneInput()
    validate(
      need(goi %in% m$ensembl_gene_id | goi %in% m$external_gene_name, "Gene not found!")
    )
    if (substr(goi,1,7) == "ENSDARG") {
      expr <- m[m$ensembl_gene_id==goi,grep("tpm",colnames(m))]
    }
    else {
      expr <- m[m$external_gene_name==goi,grep("tpm",colnames(m))]
    }
    expr$id <- rownames(expr)
    m1 <- melt(expr, id.vars = "id", value.name="tpm")
    p <- plot_ly(m1, x = ~variable, y = ~tpm, type = "bar")
    layout(p, title = goi, margin = list(b = 160), xaxis = list(title = "Tissue", tickangle = 45)) #should be list() to work!
    })
  
  output$table <- renderTable(
    data.frame(m[m$external_gene_name==geneInput() | m$ensembl_gene_id==geneInput() ,])
  )
  
  #download
  output$downloadData <- downloadHandler(
    filename = function() { paste(geneInput(), '.csv', sep='') },
    content = function(file) {
      x = data.frame(m[m$external_gene_name==geneInput() | m$ensembl_gene_id==geneInput() ,])
      write.csv(x, file)
    }
  )
  

})  
   

# Run the application 
shinyApp(ui = ui, server = server)
 
