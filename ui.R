shinyUI(fluidPage(
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
        p(" - Svetlana's RNA-Seq, WT brain (fus project, 4 replicates, paired end, 2x100, stranded)"),
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


  
  
