library(rsconnect)

# Courtesy of https://github.com/RMHogervorst/testshiny/blob/main/deploy.R
# See https://www.r-bloggers.com/2021/02/deploy-to-shinyapps-io-from-github-actions/

# Print a list of app dependencies. Libraries need to be loaded
# before publishing so deployApp() knows what is necessary.
error_on_missing_name <- function(name){
    var <- Sys.getenv(name, unset=NA)
    if(is.na(var)){
        stop(paste0("cannot find ",name),call. = FALSE)
    }
    gsub("\"", '',var)
}

# Set the account info for deployment.
setAccountInfo(name   = error_on_missing_name("SHINY_ACC_NAME"),
               token  = error_on_missing_name("TOKEN"),
               secret = error_on_missing_name("SECRET"))

# Deploy the application.
deployApp(
    appFiles = c("Global.R","ui.R","server.R", "kallisto_tpm_expression_table.txt"),
    appName = error_on_missing_name("MASTERNAME"),
    appTitle = "Zebrafish Tissue Expression",
    forceUpdate = TRUE
)
