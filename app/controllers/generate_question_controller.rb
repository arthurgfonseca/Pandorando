class GenerateQuestionController < ApplicationController
  layout 'home'
  
  
  def nextQuestion
    
    @questions = GenerateQuestionController.getQuestions()
    numberOfQuestions = @questions.size
    arrPesos = session[:arrPesos]
    @lastQuestion = false
    @questionNumber = (params[:questionNumber]).to_i
    
    #TODO
    opcao = params[:answer]
    @acceptResult = true
    
    
    answers = @questions[@questionNumber.to_i].answers
    puts answers
      
      for answer in answers
        puts 'haaa'
        puts answer
        puts answer.id
        if(answer.enunciation == opcao.to_s)
      
          answerWithChar = Answer.find(answer.id)
          char = answerWithChar.AnswerCharacteristicWeight
          
          puts 'WEIGHT'
          puts char[0].weight
          puts arrPesos.class
          
          
          arrPesos[0] = arrPesos[0].to_f + (char[0].weight).to_f
          arrPesos[1] = arrPesos[1].to_f + (char[1].weight).to_f
          arrPesos[2] = arrPesos[2].to_f + (char[2].weight).to_f
          arrPesos[3] = arrPesos[3].to_f + (char[3].weight).to_f
          arrPesos[4] = arrPesos[4].to_f + (char[4].weight).to_f
          arrPesos[5] = arrPesos[5].to_f + (char[5].weight).to_f
          arrPesos[6] = arrPesos[6].to_f + (char[6].weight).to_f
          arrPesos[7] = arrPesos[7].to_f + (char[7].weight).to_f
          arrPesos[8] = arrPesos[8].to_f + (char[8].weight).to_f
      
        end
      end
    
    session[:arrPesos] = arrPesos
    
    # Declaracao de variaveis globais usadas no _result
    @allGifts = Array.new
    @arrGiftsPrincipais = Array.new
    @countPrincipal = 0
    @countSecundario = 0
    @countTerceario = 0
    @presenteSecundario = nil
    @ultimaPagina = false
    @pagina = 1
    @presenteTerceario = nil
    #Fim da declaração
    
    #Check if it is the last question
    if(@questions.size <= @questionNumber + 1)
      @lastQuestion = true
      @trainMode = Constants::TRAIN_MODE
      
      # Add new weights following the char quantity
      if(Constants::TRAIN_MODE == true)
        history = History.new
        history.weight0 = arrPesos[0]
        history.weight1 = arrPesos[1]
        history.weight2 = arrPesos[2]
        history.weight3 = arrPesos[3]
        history.weight4 = arrPesos[4]
        history.weight1 = arrPesos[5]
        history.weight2 = arrPesos[6]
        history.weight3 = arrPesos[7]
        history.weight4 = arrPesos[8]
        history.user_mail = session[:user].to_s
        session[:user] = nil
        history.save
        
        @perfil = getResult(numberOfQuestions)

        puts "SAI DO GER RESULT"
        if(@perfil == nil)
          puts "ENTREI AKI NO @PERFIL == NIL"
          @acceptResult = false
        end
        
        # 
        # Obtem todos os presentes e faz a paginação
        # 

        @allGifts = (Gift.limit((Constants::PAGINA).to_i)).asc(:name)
        @pagina = 1
        @ultimaPagina = false
        # Limpa a session e depois inicia
        session[:giftsAdicionados] = nil
        session[:giftsAdicionados] = Array.new
        
        
        # 
        # FIM PAGINAÇÃO
        # 
        
        # Remover, usado apenas para teste
        # @perfil = Perfil.last
      else
        
        arrPerfis = getPerfisList()
        
        cont = 0
        
        # Adiciona até dois presentes contidos no perfil principal encontrado pelo sitema
        while(cont < 2)
          
          adicionado = false
          
          perfil = Perfil.where(:title => arrPerfis[0]).first
          puts perfil.title
          gifts = perfil.gifts
          if(gifts.size == 0)
            puts "ENTREI NO CASO SEM PRESENTES"
            gifts = Gift.all
          end
          
          numeroRandomico = Random.new
          
          gift = gifts[numeroRandomico.rand(0...gifts.size)]
          
          @arrGiftsPrincipais.each{|item|
            if(item == gift.name)
              adicionado = true
            end
          }
          
          if !adicionado
            @arrGiftsPrincipais << gift.name
            cont = cont.next
            contTentativas = 0
          else
            if @arrGiftsPrincipais.size == gifts.size
              cont = cont.next
            end
          end
          
        end
        
        @countPrincipal = @arrGiftsPrincipais.size
        cont = 0
        contVerificador = 0
        
        # Adiciona um presente do perfil secundario
        while(cont < 1)
          
          adicionado = false
          
          perfil = Perfil.where(:title => arrPerfis[1]).first
          puts perfil.title
          gifts = perfil.gifts
          if(gifts.size == 0)
            puts "ENTREI NO CASO SEM PRESENTES"
            gifts = Gift.all
          end
          
          numeroRandomico = Random.new
          
          gift = gifts[numeroRandomico.rand(0...gifts.size)]
          
          @arrGiftsPrincipais.each{|item|
            if(item == gift.name)
              adicionado = true
            end
          }
          
          if !adicionado
            @presenteSecundario = gift.name
            cont = cont.next
            @countSecundario = true
          else
            contVerificador = contVerificador.next
            if contVerificador > 100
              cont = cont.next
              @countSecundario = false
            end
          end
          
        end
        
        cont = 0
        contVerificador = 0
        
        #Adiciona presente do terceiro perfil mais próximo
        while(cont < 1)
          
          adicionado = false
          
          perfil = Perfil.where(:title => arrPerfis[2]).first
          puts perfil.title
          gifts = perfil.gifts
          if(gifts.size == 0)
            puts "ENTREI NO CASO SEM PRESENTES"
            gifts = Gift.all
          end
          
          numeroRandomico = Random.new
          
          gift = gifts[numeroRandomico.rand(0...gifts.size)]
          
          @arrGiftsPrincipais.each{|item|
            if(item == gift.name || gift.name == @presenteSecundario)
              adicionado = true
            end
          }
          
          if !adicionado
            @presenteTerceario = gift.name
            cont = cont.next
            @countTerceario = true
          else
            contVerificador = contVerificador.next
            if contVerificador > 100
              cont = cont.next
              @countTerceario = false
            end
          end
          
        end
        
      end
      
      
    else
      @questionNumber = @questionNumber.next
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.js # Ajax CRUD
    end
    
  end
  
  private
  
  def self.getQuestions
    
    # return Question.find(:all, :include => :answers)
    return Question.all
    
  end
  
  def getResult(numberOfQuestions)
    
    puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    arrPesos = []
    cont = 0
    session[:arrPesos].each{|result|
      
      characteristics = Characteristic.get_characteristic_by_id(cont)
      puts "nome da caracteristica"
      puts characteristics.name
      puts characteristics.referencias
      puts Float(result.to_f/(characteristics.referencias).to_f)
      
      arrPesos << Float(result.to_f/(characteristics.referencias).to_f)
      
      
      cont = cont.next
    }
    
    
    puts 'passei aki'
    network = ResultController.generateResult(arrPesos)
    return network
    
  end
  
  def getPerfisList()
    
    puts 'passei aki no getPerfis'
    arrPesos = []
    cont = 0
    session[:arrPesos].each{|result|
      
      characteristics = Characteristic.get_characteristic_by_id(cont)
      
      arrPesos << Float(result.to_f/(characteristics.referencias).to_f)
      puts Float(result.to_f/(characteristics.referencias).to_f)
      
      cont = cont.next
    }
    
    
    return ResultController.generateResult(arrPesos)
    
  end
  
  def manageGift
    
    puts '===== ENTREI NO MANAGEGIFT ======'
    puts ''
    puts ''

     idGift = params[:gift]
     idPerfil = params[:perfil]
     @acao = params[:acao]
     
     
     
     
     puts idGift
     puts idPerfil
     puts @acao
     
     if @acao == "Adicionar"
       
       
       
       puts 'ENTREI ADICIONAR'
       
       gift = Gift.find(idGift);
       session[:giftsAdicionados] << gift.name
       perfil = Perfil.find(idPerfil)
       gift.perfils.concat([perfil])
       gift.save
       
     else
     #   todo: fazer a forma de remover o a ligação rescem criada
       # puts 'ENTREI REMOVER'
       #      
       #     gift = Gift.find(idGift);
       #     perfil = Perfil.find(idPerfil)
       #     gift.perfils.where(:title => perfil.title).delete_all 
       
     end
     

     respond_to do |format|
           format.js
      end

   end
   
   def paginacaoGift
     
     gifts = (Gift.all).asc(:name)
     @pagina = params[:pagina].to_i
     @tipo = params[:id]
     idPerfil = params[:perfil]
     @perfil = Perfil.find(idPerfil)
     @giftsAdicionados = session[:giftsAdicionados]
     
     puts "INICIO PUTS paginacaoGift"
     puts @giftsAdicionados.size
     puts @pagina
     puts @tipo
     puts idPerfil
     puts "FIM PAGINACAO"
     
     if @tipo == "proxima"
       if((@pagina + 1)*((Constants::PAGINA).to_i) >= gifts.size)
         @ultimaPagina = true
         @allGifts = (Gift.all).asc(:name)
         giftsVistos = (Gift.limit(((Constants::PAGINA).to_i)*@pagina)).asc(:name)
         @allGifts = @allGifts - giftsVistos
       else
         @ultimaPagina = false
         @allGifts = (Gift.limit(((Constants::PAGINA).to_i)*(@pagina + 1))).asc(:name)
         giftsVistos = (Gift.limit(((Constants::PAGINA).to_i)*@pagina)).asc(:name)
         @allGifts = @allGifts - giftsVistos
         
       end
       
       @pagina = @pagina.next
       
     else
      
       if(@pagina == 2)
          @allGifts = (Gift.limit(((Constants::PAGINA).to_i))).asc(:name)
        else
          
          @allGifts = (Gift.limit(((Constants::PAGINA).to_i)*(@pagina - 1))).asc(:name)
          giftsVistos = (Gift.limit(((Constants::PAGINA).to_i)*(@pagina - 2))).asc(:name)
          @allGifts = @allGifts - giftsVistos
        end
       
       @ultimaPagina = false
       @pagina = @pagina.pred
       
     end
     
     
     respond_to do |format|
            format.js
       end
     
   end
  
  
  
  
end
