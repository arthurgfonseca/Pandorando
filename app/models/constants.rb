class Constants
  
  # Constants to calculate the soa algorithm
  NEURONS_HEIGHT = 20
  NEURONS_WIDTH = 20
  
  NEIGHBOURHOOD_RADIUS = (NEURONS_HEIGHT / 7).to_f #Deve ser aproximadamente 3
  LEARNING_RATE = 0.5
  INTERATIONS = 20
  
  
  # Domain of the input and weights values
  DOMAIN = [[0.0, 1.0], [0.0, 1.0], [0.0, 1.0], [0.0, 1.0], [0.0, 1.0]]
  
  TRAIN_MODE = true
  
end