# server.R

source("Global.R")

#load data once:

m <- read.table(file = "data/kallisto_tpm_expression_table.txt")

shinyServer(function(input, output) {
  
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
    p <- plot_ly(m1, x = "variable", y = "tpm", color = "id", type = "bar", colors = "Spectral")
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
    
