# Import des librairies utiles
#install.packages("randomForest")
#install.packages("shiny")
library(dplyr)
library(ggplot2)
library(caret)
#library(randomForest)
library(MASS)
library(shiny)

# Import des données
df = read.csv("drug.csv")

# Préparation des données 
df$Drug = factor(df$Drug)

# Partition train/test
set.seed(123)
index = sample(1:nrow(df), 0.8*nrow(df))
train = df[index, ]
test = df[-index, ]

# Apprentissage du modèle
model = lda(Drug ~ ., data = train)

# Prédictions sur le testset  
predictions = predict(model, test)$class

# Matrice de confusion
confusionMatrix(predictions, test$Drug)

# Accuracy
accuracy = mean(predictions == test$Drug)

# Sensibilité et spécificité par classe
sensitivity = confusionMatrix(predictions, test$Drug)$byClass[,"Sensitivity"]
specificity = confusionMatrix(predictions, test$Drug)$byClass[,"Specificity"]

print(paste("Accuracy:", accuracy))
print(paste("Sensibilité:", sensitivity)) 
print(paste("Spécificité:", specificity))

# Sauvegarde model
saveRDS(model, "model.rds")

