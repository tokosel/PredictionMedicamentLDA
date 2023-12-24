# Fonction générique de prédiction 
predict_drug <- function(model, patient_data){
  
  # Prédiction 
  prediction <- predict(model, patient_data)  
  
  # Retour prédiction
  return(prediction) 
}
