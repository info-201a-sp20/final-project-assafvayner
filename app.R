# Must Run App before using lintr
library(shiny)

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
