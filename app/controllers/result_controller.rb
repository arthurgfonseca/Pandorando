class ResultController < ApplicationController
  
  def self.generateResult(resultVector)
    
    puts 'entrei result'
    if(Constants::TRAIN_MODE == true)
      nodes = Network.all
      # Network was alredy created
      if(nodes.size == 0)
        puts 'GEREI NETWORK'
        network = ResultController.createNetwork()
        puts 'NETWORK GERADA'
      end
    
      network = Network.all
      puts 'NETWORK INICIAL'
      network.each{|node|
        puts 'NOOOOOOODEEEEEEEE'
        puts node.weight0
        puts node.weight1
        puts node.weight2
        puts node.weight3
        puts node.weight4
      
      }
        # Train Kohonen Network
        ResultController.start(network, resultVector)
        return network
    else
      # Get info from Kohonen Network
      arrPerfil = Array.new
      arrPerfil = ResultController.getBmuFromNetwork(resultVector)
      return arrPerfil
    end
    
    
    
  end
  
  def self.getBmuFromNetwork(resultVector)
    
    arrBmu = Array.new
    arrPerfil = Array.new
    
    network = Network.all
    
    SomController.best_unit(arrBmu, network, resultVector)
    
    
    
    while arrBmu.size > 0
    
      index = nil
      cont = 0
      dist = 1000 # Max value
    
      arrBmu.each{|hashBmu|
        if(dist > hashBmu[:dist])
          dist = hashBmu[:dist]
          index = cont
        end
        
        cont = cont.next
      
      }
      
      
      arrPerfil << arrBmu[index][:name]
      arrBmu.delete_at(index)
    end
    
    
    
    
    return arrPerfil
    
  end
  
  def self.start(network, resultVector)
    puts 'entrei start'
    # Init Constants
    interations = Constants::INTERATIONS
    l_rate = Constants::LEARNING_RATE
    neigh_size = Constants::NEIGHBOURHOOD_RADIUS
    input = resultVector
    bmu = nil
    
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
    bmuResult = SomController.execute(network, input, interations, l_rate, neigh_size, bmu)
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
    puts 'BMU'
    puts bmuResult
    puts 'BMU FIM'
    characteristics = Characteristic.get_characteristics
    bmuRecord = Perfil.new
    bmuRecord.positionx = bmuResult.positionx
    bmuRecord.positiony = bmuResult.positiony
    bmuRecord.title = "Comum"
    bmuRecord.save
    
    
    
    network.each{|node|
      puts 'NOOOOOOODEEEEEEEE FINAL nodex=' + (node.positionx).to_s + 'nodey=' + (node.positiony).to_s
      puts node.weight0
      puts node.weight1
      puts node.weight2
      puts node.weight3
      puts node.weight4
      
    }
    
    # ResultController.updateNetworkDatabase(network)
    
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
      # Fazer de forma iterativa
      puts 'VETOOOOORRRRRRRRRRRR'
      puts networkItem[:vector]
      node.weight0 = networkItem[:vector][0].to_f
      node.weight1 = networkItem[:vector][1].to_f
      node.weight2 = networkItem[:vector][2].to_f
      node.weight3 = networkItem[:vector][3].to_f
      node.weight4 = networkItem[:vector][4].to_f
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
