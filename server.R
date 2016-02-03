library(shiny)
library(datasets)


esophData <- esoph

shinyServer(function(input, output) {
    # Generate a summary of the data
    output$summary <- renderPrint({
            summary(esophData)
    })
    
    # Generate an HTML table view of the data
    output$table <- renderTable({
        data.frame(esophData)
        
    })
    # Applied regression model of the data
    output$regression <- renderPrint({
        model1 <- glm(cbind(ncases, ncontrols) ~ agegp + tobgp * alcgp,
                      data = esophData, family = binomial())
      anova(model1)  
      summary(model1)
    })
    
    # Compute the forumla text in a reactive expression since it is 
    # shared by the output$caption and output$esophPlot expressions
    formulaText_ncontrols <- reactive({
        paste("ncontrols ~",input$variable)
    })
    formulaText_ncases <- reactive({
        paste("ncases ~",input$variable)
    })
   
    # Return the formula text for printing as a caption
    output$caption_ncontrols <- renderText({
        formulaText_ncontrols()
    })
    output$caption_ncases <- renderText({
        formulaText_ncases()
    })
    
    # Generate a plot of the requested variable against esoph and only 
    # include outliers if requested
    output$esophPlot_ncontrols <- renderPlot({
        boxplot(as.formula(formulaText_ncontrols()), 
                data = esophData,
                outline = input$outliers)
       })
    output$esophPlot_ncases <- renderPlot({
        boxplot(as.formula(formulaText_ncases()), 
                data = esophData,
                outline = input$outliers)
    })
    output$esophPlot1 <- renderPlot({
        with(esophData,plot(agegp,ncontrols,main=" ncontrols(no disease) vs age group"))
    })
    output$esophPlot2 <- renderPlot({
        with(esophData,plot(agegp,ncases,main=" ncases (with disease)vs age group "))
    })
})
