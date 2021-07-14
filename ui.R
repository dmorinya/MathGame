library(shiny)
library(shinyjs)
shinyUI(fluidPage(
  useShinyjs(),
  tags$style("#players_answer {font-size:30px;height:30px;}"),
  titlePanel("Pokemon Maths Challenge!"),
  fluidRow(
    HTML("
                         "),
    imageOutput("duck_image"),
    HTML("
                         ")
  ),
  fluidRow(
    sidebarLayout(
      sidebarPanel(
        numericInput('players_answer', 'Resposta', value = 0),
        actionButton('submit_answer','Envia'),
        hr(),
        actionButton('update', 'Propera pregunta')
      ),
      mainPanel(
        span(textOutput("illustration"), style = "font-size: 36px"),
        imageOutput("check_answer"),
        span(textOutput("check_answer_text"), style = "font-size: 20px")
      )
    )
  )
))
