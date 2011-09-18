class NetworkVisualizerController < ApplicationController

  def index

    @matrizDaRedeNeural = Network.all
    puts "========== TAMANHO DA REDE ========="
    puts @matrizDaRedeNeural.length

    @index = "network"

  end
end