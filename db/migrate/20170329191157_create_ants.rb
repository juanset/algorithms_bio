class CreateAnts < ActiveRecord::Migration[5.0]
  def change
    create_table :ants do |t|
      t.string :set
      t.integer :max_it
      t.integer :num_ants
      t.float :decay_factor
      t.float :c_heur
      t.float :c_hist

      t.timestamps
    end
  end
end
