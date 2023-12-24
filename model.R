# Import des librairies utiles
#install.packages("randomForest")
#install.packages("shiny")
library(dplyr)
library(ggplot2)
library(caret)
library(randomForest)
library(shiny)

# Import des données
df = read.csv("C:/Users/hp/Desktop/Master SID/Méthodes de classification/Spss/drug1n.csv")

# Préparation des données 
df$Drug = factor(df$Drug)

# Partition train/test
set.seed(123)
index = createDataPartition(df$Drug, p = 0.8, list = FALSE) 
train = df[index,]
test = df[-index,]

# Entrainement model
model <- randomForest(Drug ~ ., data = train, ntree = 100) 

# Évaluation
pred <- predict(model, test)
accuracy <- mean(pred == test$Drug) 
print(paste("Accuracy:", accuracy))

# Sauvegarde model
saveRDS(model, "model.rds")

