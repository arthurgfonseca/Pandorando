class ResultController < ApplicationController
  
  def self.generateResult(resultVector)
    
    puts 'entrei result'
    
    nodes = Network.find(:all)
    # Network was alredy created
    if(nodes.size == 0)
      network = ResultController.createNetwork()
    else
      network = ResultController.getNetwork(nodes)
    end
    puts 'NETWORK INICIAL'
    puts network
    
    # Start Kohonen Network
    ResultController.start(network, resultVector)
    puts network
    return network
    
  end
  
  
  def self.start(network, resultVector)
    puts 'entrei start'
    # Init Constants
    interations = Constants::INTERATIONS
    l_rate = Constants::LEARNING_RATE
    neigh_size = Constants::NEIGHBOURHOOD_RADIUS
    input = resultVector
    
    puts'################################################################'
    puts ''
    puts 'INPUT DATA'
    puts input
    puts ''
    puts'################################################################'
    puts ''
    puts ''
    
    # TODO: USE INPUT FROM resultVector
    # input = [0.35, 0.56]
    puts '################################################################'
    puts '################################################################'
    puts '################################################################'
    puts '################################################################'
    puts 'ENTROU ALGORITMO'
    puts ''
    puts ''
    SomController.execute(network, input, interations, l_rate, neigh_size)
    puts ''
    puts ''
    puts 'SAIU DO ALGORITMO'
    puts '################################################################'
    puts '################################################################'
    puts '################################################################'
    puts '################################################################'
    puts ''
    puts ''
    puts ''
    puts 'NETWORK FINAL'
    
    ResultController.updateNetworkDatabase(network)
    
  end
  
  def self.getNetwork(nodes)
    network = Array.new
    
    nodes.each{|networkNode|
      puts networkNode.weights
      node = {}
      arrWeight = Array.new
      (networkNode.weights.split(',')).each{|weight|
        arrWeight << Float(weight)
      }
      # node[:vector] = networkNode.weights.split(',')
      node[:vector] = arrWeight
      node[:coord] = [networkNode.positionx, networkNode.positiony] 
      network << node
    }
    
    return network
    
  end
  
  # Create e initialize the network
  
  def self.createNetwork
    
    # Init constants
    width = Constants::NEURONS_WIDTH
    height = Constants::NEURONS_HEIGHT
    domain = Constants::DOMAIN

    network = ResultController.initialize_vectors(domain, width, height)
    network.each{|networkItem|
      node = Network.new
      node.positionx = networkItem[:coord][0].to_i
      node.positiony = networkItem[:coord][1].to_i
      node.weights = (networkItem[:vector][0].to_s + ", " + networkItem[:vector][1].to_s)
      node.save
      
    }
    
    return network
    
  end
  
  #Create vector of weight for the map
  def self.random_vector(minmax)
    return Array.new(minmax.size) do |i|
      minmax[i][0] + ((minmax[i][1] - minmax[i][0]) * rand())
    end
  end

  def self.initialize_vectors(domain, width, height)
    codebook_vectors = []
    width.times do |x|
      height.times do |y|
        codebook = {}
        codebook[:vector] = ResultController.random_vector(domain)
        codebook[:coord] = [x,y]
        codebook_vectors << codebook
      end
    end
    return codebook_vectors
  end
  
  def self.updateNetworkDatabase(network)
    
    # Remove previous network
    Network.destroy_all()
    nodes = Network.find(:all)
    puts nodes.size
    
    # Insert the new network
    network.each{|networkItem|
      node = Network.new
      node.positionx = networkItem[:coord][0].to_i
      node.positiony = networkItem[:coord][1].to_i
      node.weights = (networkItem[:vector][0].to_s + ", " + networkItem[:vector][1].to_s)
      node.save
      
    }
    
  end
  
  
  
end