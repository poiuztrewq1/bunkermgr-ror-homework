class CreateJoinTableBunkerUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :bunkers, :users do |t|
      # t.index [:bunker_id, :user_id]
      # t.index [:user_id, :bunker_id]
    end
  end
end
