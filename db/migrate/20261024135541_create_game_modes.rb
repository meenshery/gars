class CreateGameModes < ActiveRecord::Migration[8.1]
  def change
    create_table :game_modes do |t|
      t.references :game, null: false, foreign_key: true
      t.references :mode, null: false, foreign_key: true

      t.timestamps
    end

    add_index :game_modes, [:game_id, :mode_id], unique: true
  end
end