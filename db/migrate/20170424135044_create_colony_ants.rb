class CreateColonyAnts < ActiveRecord::Migration[5.0]
  def change
    create_table :colony_ants do |t|
      t.string :set
      t.integer :max_it
      t.integer :num_ants
      t.float :decay
      t.float :c_heur
      t.float :c_local_phero
      t.float :c_greed

      t.timestamps
    end
  end
end
