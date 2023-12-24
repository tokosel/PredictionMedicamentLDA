# Chargement des librairies
library(shiny)
library(randomForest)
source("prediction.R")
# Charger le modèle
model <- readRDS("model.rds")

# Définition de l'interface utilisateur
ui <- fluidPage(
  
  titlePanel("Prédiction Médicament"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age",value = 50, min = 1, max = 100),
      selectInput("sex", "Sexe", 
                  choices = c("Féminin" = "F", "Masculin" = "M")),
      selectInput("bp", "Pression sanguine",
                  choices = c("Elevée" = "HIGH", "Basse" = "LOW", "Normale" = "NORMAL")),
      selectInput("cholesterol", "Cholestérol",
                  choices = c("Elevé" = "HIGH", "Normal" = "NORMAL")),
      numericInput("na", "Sodium sérique", value = 0.5, min = 0.2, max = 1),
      numericInput("k", "Potassium sérique", value = 0.04, min = 0.01, max = 0.1),
      
      actionButton("predict", "Prédire")            
    ),
    
    mainPanel(
      textOutput("prediction")
    )
  )
)

# Définition du serveur
server <- function(input, output) {
  
  patient_data <- reactive({
    data.frame(
      Age = input$age,
      Sex = input$sex, 
      BP = input$bp, 
      Cholesterol = input$cholesterol,
      Na = input$na,
      K = input$k 
    )
  })
  
  # Prediction 
  predict <- eventReactive(input$predict, {    
    
    data <- patient_data()        
    prediction <- predict_drug(model, data)
    paste("Médicament prédit:", prediction)
    
  })
  output$prediction <- renderText({
    predict()
  })
  
}

shinyApp(ui, server)