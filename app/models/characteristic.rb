class Characteristic
  
  attr_accessor :name
  attr_accessor :id
  attr_accessor :referencias

  def initialize(id, nome, referencias)
    @name = nome
    @id = id
    @referencias = referencias
  end
  
  def Characteristic.get_characteristics
    array = Array.new
    array.push(Characteristic.new(0,'Sexo', 1))
    array.push(Characteristic.new(1,'Innovator', 3)) 
    array.push(Characteristic.new(2,'Thinker', 2)) 
    array.push(Characteristic.new(3,'Achiever', 2)) 
    array.push(Characteristic.new(4,'Experiencer', 2))
    array.push(Characteristic.new(5,'Beliver', 2)) 
    array.push(Characteristic.new(6,'Striever', 2)) 
    array.push(Characteristic.new(7,'Maker', 2)) 
    array.push(Characteristic.new(8,'Survivor', 11))
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
  
  def Characteristic.get_characteristic_by_id(searching_characteristic_id)
    characteristics_array = Characteristic.get_characteristics
    characteristics_array.each { |characteristic|
      if characteristic.id == searching_characteristic_id then
        return characteristic
      end
    }
    
    puts '=============== ERRO ================'
    puts "Chamada do metodo Characteristic.get_characteristic_by_id - ERRO - Caracteristica nao encontrada"
    puts '=============== ERRO ================'
    
    return nil
  end
  
  def == (other_characteristic)
     @id == other_characteristic.id
  end
  
end
