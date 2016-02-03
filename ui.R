library(shiny)

shinyUI(navbarPage("Smoking, Alcohol and (O)esophageal Cancer",    
  
mainPanel(
        tabsetPanel(
 
            tabPanel("Visualization",
                 
                                          sidebarPanel(
                                              selectInput("variable", "Variable:",
                                                          list("Alcohol consumption" = "alcgp", 
                                                               "Tobacco consumption" = "tobgp")),
                                              
                                              checkboxInput("outliers", "Show outliers", FALSE),
#                                               sliderInput("n", 
#                                                           "Number of observations:", 
#                                                           value = 50,
#                                                           min = 1, 
#                                                           max = 88),
                                              dateInput("date", "Date:")   
                                          ),
                     # Show the caption and plot of the requested variable against esoph
                     mainPanel(
                     h3(textOutput("caption_ncontrols")),
                     plotOutput("esophPlot_ncontrols"),
                     h3(textOutput("caption_ncases")),
                     plotOutput("esophPlot_ncases"),
                     plotOutput("esophPlot1"),
                     plotOutput("esophPlot2")
                       )
            ),  #tabPanel   
            tabPanel("Summary", verbatimTextOutput("summary")), 
            tabPanel("Table", tableOutput("table")),
            tabPanel("Regression", 
                     h3('Effects of alcohol, tobacco and interaction, age-adjusted'),
                     verbatimTextOutput("regression")
             
            ),# tabPanel
            
            tabPanel("About",  
                            includeMarkdown("about_project.md")
            )# tabPanel
            
            
        )#tabsetPanel
    )#mainPanel
 
))