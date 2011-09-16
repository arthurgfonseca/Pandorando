class NetworkVisualizerController < ApplicationController

  def index
    @matrizDaRedeNeural = Network.all
    puts "========== TAMANHO DA REDE ========="
    puts @matrizDaRedeNeural.length
  end
end