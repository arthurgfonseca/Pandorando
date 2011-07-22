class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks do |t|
      t.string :weights
      t.integer :positionx
      t.integer :positiony 

      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end
