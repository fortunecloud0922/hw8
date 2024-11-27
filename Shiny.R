library(shiny)
library(ggplot2)
library(dplyr)

states <- map_data("state")
midwest <- as.data.frame(midwest)


ui <- fluidPage(
  titlePanel("Data in Midwest Counties"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "var",
        label = "Choose a variable to summarize",
        choices = c(
          "Population White" = "popwhite",
          "Population Black" = "popblack",
          "Population Asian" = "popasian",
          "Population Other" = "popother",
          "Total Population" = "poptotal",
          "Poverty Population" ="poppovertyknown"
        ),
        selected = "popwhite"
      )
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Table",dataTableOutput("tableOutput")),
                  tabPanel("Summary", verbatimTextOutput("summaryOutput")))
    )
  )
)


server <- function(input, output, session) {

  output$summaryOutput <- renderPrint({
    summary_data <- midwest %>% select(all_of(input$var))
    summary(summary_data)
  })
  output$tableOutput <- renderDataTable({ggplot2::midwest})
}


shinyApp(ui = ui, server = server)
