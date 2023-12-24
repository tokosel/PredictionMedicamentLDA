# Fonction générique de prédiction 
predict_drug <- function(model, patient_data){
  
  # Prediction avec lda 
  prediction <- predict(model, patient_data)$class
  
  return(prediction)
}

