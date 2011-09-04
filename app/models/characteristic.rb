class Characteristic
  
  attr_accessor :name
  attr_accessor :id

  def initialize(id, nome)
    @name = nome
    @id = id
  end
  
  def Characteristic.get_characteristics
    array = Array.new
    array.push(Characteristic.new(0,'teste'))
    array.push(Characteristic.new(10,'teste1'))
    array.push(Characteristic.new(2,'teste2'))
    array.push(Characteristic.new(3,'teste3'))
    return array
  end
  
  def Characteristic.get_characteristic_by_name(searching_characteristic_name)
    characteristics_array = Characteristic.get_characteristics
    characteristics_array.each { |characteristic|
      if characteristic.name.casecmp(searching_characteristic_name)  == 0 then
        puts characteristic.name
        return characteristic
      end
    }
    
    puts '=============== ERRO ================'
    puts "Chamada do metodo Characteristic.get_characteristic_by_name - ERRO - Caracteristica nao encontrada"
    puts '=============== ERRO ================'
    
    return nil
  end
  
  def == (other_characteristic)
     @id == other_characteristic.id
  end
  
end
