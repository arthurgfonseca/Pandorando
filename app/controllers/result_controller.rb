class ResultController < ApplicationController
  
  def self.generateResult(resultVector)
    
    if(Constants::TRAIN_MODE == true)
      nodes = Network.all
      # Network was alredy created
      if(nodes.size == 0)
        puts 'GEREI NETWORK'
        network = ResultController.createNetwork()
        puts 'NETWORK GERADA'
      end
    
      network = Network.all
      # puts 'NETWORK INICIAL'
      #       network.each{|node|
      #         puts 'NOOOOOOODEEEEEEEE'
      #         puts node.weight0
      #         puts node.weight1
      #         puts node.weight2
      #         puts node.weight3
      #         puts node.weight4
      #         puts node.match_count
      #       
      #       }
      
      # Verifca se o usuário já respondeu, em caso positivo se a resposta está consistente com a anterior
      if(ResultController.checkConsistency(resultVector))
        # Train Kohonen Network
        perfil = ResultController.start(network, resultVector)
        
        puts "SAI DO START"
        
        return perfil
      else
        return nil
      end
        
    else
      # Get info from Kohonen Network
      arrPerfil = Array.new
      arrPerfil = ResultController.getBmuFromNetwork(resultVector)
      return arrPerfil
    end
    
  end
  
  def self.checkConsistency(resultVector)
    acceptResult = true
    puts "HAHAHSDKASHJFDAHJKFHJKLAH"
    mail = (History.last).user_mail
    perfil = Perfil.where(:title => mail).first
    puts "sdasdakhjs"
    puts perfil
    
    if(perfil)
      network = Network.all
      puts "entrei aki"
      bmu,bmuDist = SomController.get_best_matching_unit(network, resultVector)
      
      puts bmu.positionx
      puts bmu.positiony
      
      puts "PERFIL"
      puts perfil.positionx
      puts perfil.positiony
      
      bmuCord = [bmu.positionx, bmu.positiony]
      otherCord = [perfil.positionx, perfil.positiony]
      distance =  SomController.euclidean_distance(bmuCord, otherCord)
      # Resultado inconsistente (Descartado)
      if(distance > perfil.radius)
        acceptResult = false
      end
    end
    
    return acceptResult
    
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
    
    createPerfil = ResultController.checkIfShoudCreatePerfil(bmuResult)
    
    mail = (History.last).user_mail
    # Verifica se é necessario criar um novo perfil
    if(createPerfil)
      bmuRecord = Perfil.new
      bmuRecord.positionx = bmuResult.positionx
      bmuRecord.positiony = bmuResult.positiony
      # Perfil inicia com o tamanho padrão
      bmuRecord.radius = (Constants::NEIGHBOURHOOD_RADIUS / 2).to_f
      # Perfil é associado ao email do usuario, ja que ele é único
      bmuRecord.title = mail
      bmuRecord.save
    end
    
    # network.each{|node|
    #       puts 'NOOOOOOODEEEEEEEE FINAL nodex=' + (node.positionx).to_s + 'nodey=' + (node.positiony).to_s
    #       puts node.weight0
    #       puts node.weight1
    #       puts node.weight2
    #       puts node.weight3
    #       puts node.weight4
    #       puts node.match_count
    #       
    #     }
    
    perfil = Perfil.where(:title => mail)
    
    
    return perfil
    
  end
  
  def self.checkIfShoudCreatePerfil(bmuResult)
    
    createPerfil = true
    
    # Caso não precise criar perfil, encontrar centro de massa mais proximo do bmuResult
    bestDistance = 1000
    bestBmu = nil
    
    allPerfil = Perfil.all
    
    for selectedPerfil in allPerfil
      
      bmuCord = [selectedPerfil.positionx, selectedPerfil.positiony]
      otherCord = [bmuResult.positionx, bmuResult.positiony]
      distance =  SomController.euclidean_distance(bmuCord, otherCord)
      
      # Se a distancia é maior do que o raio do perfil está fora do alcance do perfil e precisa criar um novo
      if (distance > selectedPerfil.radius && createPerfil)
        createPerfil = true
      else
        # Se alguma vez o perfil caiu nesse caso é porque ele esta contido em algum perfil ja existente
        createPerfil = false
        # IF necessario para se ter certeza de que o perfil mais próximo seja mantido
        if(bestDistance > distance && distance < selectedPerfil.radius)
          bestDistance = distance
          bestBmu = selectedPerfil
        end
      end
      
    end
    
    # Importante observar que de qualquer forma que ser abordado o neuronio mais próximo do input tem que ter seu match_count alterado
    
    # Caso seja TRUE cria um perfil, no contrario é absorvido por um perfil já criado
    if(createPerfil)
      bmuResult.match_count = bmuResult.match_count + 1
      bmuResult.save
    else
      # 
      # TODO: verificar a condição em que o centro de massa se desloca
      # 
      
      # Verifica se precisa mudar a posicao do centro de massa
      # Centro de massa sofre mudança se algum neuronio da sua vizanhança tiver um contador maior do que o dele
      # bestBmu é o neuronio que representa o perfil mais proximo do vetor de entrada
      if(bestBmu.match_count < bmuResult.match_count + 1)
        bmuResult.match_count = bmuResult.match_count + 1
        bmuResult.save
        # Muda o centro de massa do perfil
        bestBmu.positionx = bmuResult.positionx
        bestBmu.positiony = bmuResult.positiony
        # TODO: Verificar a necissidade de incrementar esse contador
        bestBmu.match_count = bestBmu.match_count + 1
        bestBmu.save
        
        ResultController.adjustPerfilRadius(bestBmu)
        
      else
        # Não precisa mudar o centro de massa, e reforça o peso do centro de massa existente
        bmuResult.match_count = bmuResult.match_count + 1
        bmuResult.save
        bestBmu.match_count = bestBmu.match_count + 1
        bestBmu.save
        
        ResultController.adjustPerfilRadius(bestBmu)
      end
    end
    
    return createPerfil
  end
  
  def self.adjustPerfilRadius(perfil)
    if(perfil.match_count > 1 && perfil.match_count <= 10)
      
      newRadius = perfil.radius + perfil.radius*Math.exp(-1*((10.to_f - (perfil.match_count).to_f)/(10).to_f).to_f)
      perfil.radius = newRadius
      perfil.save
    end
    
    puts "TAMANHO PADRAO"
    puts (Constants::NEIGHBOURHOOD_RADIUS / 2)
    puts "TAMANHO NOVO RAIO"
    puts perfil.radius
    
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
  
  
  
end
