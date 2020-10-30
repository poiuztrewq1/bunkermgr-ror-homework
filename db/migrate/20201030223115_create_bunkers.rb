class CreateBunkers < ActiveRecord::Migration[6.0]
  def change
    create_table :bunkers do |t|
      t.string :name
      t.string :address
      t.integer :capacity

      t.timestamps
    end
  end
end
