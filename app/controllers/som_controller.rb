class SomController < ApplicationController
  
  
  def self.execute(network, input, iterations, l_rate, neigh_size)
    
    # SomController.summarize_vectors(network)
    SomController.train_network(network, input, iterations, l_rate, neigh_size)
    # puts changedNodes
    # SomController.test_network(network, input)
    # SomController.summarize_vectors(network)
  end
  
  private
  

  def self.euclidean_distance(c1, c2)
    sum = 0.0
    c1.each_index {|i| sum += (c1[i]-c2[i])**2.0}
    return Math.sqrt(sum)
  end

  def self.get_best_matching_unit(codebook_vectors, pattern)
    best, b_dist = nil, nil
    codebook_vectors.each do |codebook|
      vector = [codebook.weight0, codebook.weight1, codebook.weight2, codebook.weight3, codebook.weight4]
      dist = SomController.euclidean_distance(vector, pattern)
      best,b_dist = codebook,dist if b_dist.nil? or dist<b_dist
    end
    return [best, b_dist]
  end

  def self.get_vectors_in_neighborhood(bmu, codebook_vectors, neigh_size)
    neighborhood = []
    bmuCord = [bmu.positionx, bmu.positiony]
    codebook_vectors.each do |other|
      otherCord = [other.positionx, other.positiony]
      if SomController.euclidean_distance(bmuCord, otherCord) <= neigh_size
        neighborhood << other
      end
    end
    return neighborhood
  end

  def self.update_codebook_vector(codebook, pattern, lrate, timestamp, timestampTotal, neigh_size, bmu)
    
    bmuCord = [bmu.positionx, bmu.positiony]
    otherCord = [codebook.positionx, codebook.positiony]
    bmuDist = SomController.euclidean_distance(bmuCord, otherCord)
    
    distanceRateModifier = Math.exp(-1*((bmuDist.to_f)*(bmuDist.to_f))/(4*(neigh_size.to_f)*(neigh_size.to_f)))
    
    learningRateModifier = Math.exp((-1*timestamp).to_f/(timestampTotal).to_f)
    # puts codebook
    cont = 0
    while(cont < 5)
      
      error = pattern[cont] - eval("codebook.weight" + cont.to_s)
      value = eval("codebook.weight" + cont.to_s)
      
      if(cont == 0)
        codebook.weight0 = value + (distanceRateModifier * learningRateModifier * lrate * error)
      elsif(cont == 1)
        codebook.weight1 = value + (distanceRateModifier * learningRateModifier * lrate * error)
      elsif(cont == 2)
        codebook.weight2 = value + (distanceRateModifier * learningRateModifier * lrate * error)
      elsif(cont == 3)
        codebook.weight3 = value + (distanceRateModifier * learningRateModifier * lrate * error)
      elsif(cont == 4)
        codebook.weight4 = value + (distanceRateModifier * learningRateModifier * lrate * error)
      else
        raise 'error'
      end
      
      cont = cont.next
    end
    # Save changes
    codebook.save
  end

  def self.train_network(network, input, iterations, l_rate, neighborhood_size)
    iterations.times do |iter|
      # pattern = random_vector(shape)
      pattern = input
      lrate = l_rate * (1.0-(iter.to_f/iterations.to_f))
      neigh_size = neighborhood_size * (1.0-(iter.to_f/iterations.to_f))
      bmu,dist = SomController.get_best_matching_unit(network, pattern)
      neighbors = SomController.get_vectors_in_neighborhood(bmu, network, neigh_size)
      neighbors.each do |node|
       SomController.update_codebook_vector(node, pattern, lrate, iter, iterations, neigh_size, bmu)
      end
      puts ">training: neighbors=#{neighbors.size}, bmu_dist=#{dist}, bmux=#{bmu.positionx}, bmuy=#{bmu.positiony}"
    end
  end


  def self.test_network(codebook_vectors, input, num_trials=100)
    error = 0.0
    num_trials.times do
      # pattern = random_vector(shape)
      pattern = input
      bmu,dist = SomController.get_best_matching_unit(codebook_vectors, pattern)
      error += dist
    end
    error /= num_trials.to_f
    puts "Finished, average error=#{error}"
    return error
  end

  
end
