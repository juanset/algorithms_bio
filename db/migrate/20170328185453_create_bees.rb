class CreateBees < ActiveRecord::Migration[5.0]
  def change
    create_table :bees do |t|
      t.integer :problem_size
      t.string :search_space
      t.integer :max_gens
      t.integer :num_bees
      t.integer :num_sites
      t.integer :elite_sites
      t.integer :patch_size
      t.integer :e_bees
      t.integer :o_bees

      t.timestamps
    end
  end
end
