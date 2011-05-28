class CreateResposta < ActiveRecord::Migration
  def self.up
    create_table :resposta do |t|
      t.string :enuciado

      t.timestamps
    end
  end

  def self.down
    drop_table :resposta
  end
end
