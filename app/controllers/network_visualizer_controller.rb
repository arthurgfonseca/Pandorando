class NetworkVisualizerController < ApplicationController

  def index
    @matrizDaRedeNeural = Network.all
    puts "========== TAMANHO DA REDE ========="
    puts @matrizDaRedeNeural.length

    @listaDePerfis = Perfil.all
    @index = "network"

  end
  
  def full
    @matrizDaRedeNeural = Network.all
    puts "========== TAMANHO DA REDE ========="
    puts @matrizDaRedeNeural.length

    @listaDePerfis = Perfil.all
    @index = "network"
    
    render :layout => "network_full"
  end
  
end