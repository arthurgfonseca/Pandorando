class CreatePergunta < ActiveRecord::Migration
  def self.up
    create_table :pergunta do |t|
      t.string :enuciado

      t.timestamps
    end
  end

  def self.down
    drop_table :pergunta
  end
end
