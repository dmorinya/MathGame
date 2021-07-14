#ui.R#
library(shiny)
    shinyServer(function(input, output) {
        first_number <- sample(1:10, 1)
        second_number <- sample(3:(first_number-1),1)
        get_random_question <- reactive({
            input$update
            isolate({
                first_number <- sample(10:50, 1)
                operation <- sample(1:3, 1, prob = c(0.5,0.2,0.3))
                operation_symb <- c("-", "+", "x")
                if(operation == 1){
                    #1 is subtraction
                    second_number <- sample(3:(first_number-1),1)
                    true_answer <- first_number - second_number
                }
                if(operation == 2){
                    #2 is addition
                    second_number <- sample(5:50,1)
                    true_answer <- first_number + second_number
                }
                if(operation==3){
                    #3 is multiplication
                    second_number <- sample(1:3,1, prob = c(0.1,0.45,0.45))
                    true_answer <- first_number * second_number
                }
                question_out <- list(
                    "formula" = paste(first_number,
                                      operation_symb[operation],
                                      second_number,
                                      "= ?"),
                    "true_answer" = true_answer
                )
                question_out
            })
        })
        output$illustration <- renderText({
            get_random_question()$formula
        })
        verdict <- reactive({
            input$submit_answer
            isolate({
                if(input$players_answer == get_random_question()$true_answer){
                    happyimagelist <- c("GIF/24e.png")
                    image2show <- sample(happyimagelist,1)
                }else{
                    image2show <- sample(c("GIF/mew_enfadat.gif"),1)
                }
                image2show
            })})
        verdict_text <- reactive({
            input$submit_answer
            isolate({
                if(input$players_answer == get_random_question()$true_answer){
                    text2show <- "Correcte!"
                }else{
                    text2show <- "Torna a provar!"
                }
                text2show
            })})
        observeEvent(
            input$submit_answer,{
                output$check_answer <- renderImage({
                    list(src="GIF/waiting2.gif", alt = "waiting")}, deleteFile = FALSE)
                output$check_answer_text <- renderText("hm...")
                delay(2500, 
                      {output$check_answer <- renderImage({list(src=verdict(), alt="verdict")}, 
                                                          deleteFile = FALSE)
                      output$check_answer_text <- renderText(verdict_text())})}
        )
        output$duck_image <- renderImage({
            list(src="pokemon.png", alt = "PsyDuck")
        }, deleteFile = FALSE)
    })