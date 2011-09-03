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
      dist = SomController.euclidean_distance(codebook[:vector], pattern)
      best,b_dist = codebook,dist if b_dist.nil? or dist<b_dist
    end
    return [best, b_dist]
  end

  def self.get_vectors_in_neighborhood(bmu, codebook_vectors, neigh_size)
    neighborhood = []
    codebook_vectors.each do |other|
      if SomController.euclidean_distance(bmu[:coord], other[:coord]) <= neigh_size
        neighborhood << other
      end
    end
    return neighborhood
  end

  def self.update_codebook_vector(codebook, pattern, lrate)
    puts 'UPDATE CODEBOOK'
    # puts codebook
    codebook[:vector].each_with_index do |v,i|
      # TODO: ADD DISTANCE OF BMU PARAMTER
      error = pattern[i]-codebook[:vector][i]
      codebook[:vector][i] += lrate * error
    end
  end

  def self.train_network(vectors, input, iterations, l_rate, neighborhood_size)
    iterations.times do |iter|
      # pattern = random_vector(shape)
      pattern = input
      lrate = l_rate * (1.0-(iter.to_f/iterations.to_f))
      neigh_size = neighborhood_size * (1.0-(iter.to_f/iterations.to_f))
      bmu,dist = SomController.get_best_matching_unit(vectors, pattern)
      neighbors = SomController.get_vectors_in_neighborhood(bmu, vectors, neigh_size)
      neighbors.each do |node|
       SomController.update_codebook_vector(node, pattern, lrate)
      end
      puts ">training: neighbors=#{neighbors.size}, bmu_dist=#{dist}, bmu=#{bmu}"
    end
  end

  # def self.summarize_vectors(vectors)
  #   minmax = Array.new(vectors.first[:vector].size){[1,0]}
  #   vectors.each do |c|
  #     c[:vector].each_with_index do |v,i|
  #       minmax[i][0] = v if v<minmax[i][0]
  #       minmax[i][1] = v if v>minmax[i][1]
  #     end
  #   end
  #   s = ""
  #   minmax.each_with_index {|bounds,i| s << "#{i}=#{bounds.inspect} "}
  #   puts "Vector details: #{s}"
  #   return minmax
  # end

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
