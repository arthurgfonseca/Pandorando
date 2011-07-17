class CreateCharacteristics < ActiveRecord::Migration
  def self.up
    create_table :characteristics do |t|
      t.string :title
      t.integer :load
      
      t.references :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :characteristics
  end
end
