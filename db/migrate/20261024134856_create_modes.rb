class CreateModes < ActiveRecord::Migration[8.1]
  def change
    create_table :modes do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :modes, :name, unique: true
  end
end