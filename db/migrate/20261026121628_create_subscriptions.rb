class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.string :email, null: false

      t.boolean :personal_data_consent,
        null: false,
        default: false

      t.boolean :notifications_consent,
        null: false,
        default: false

      t.timestamps
    end

    add_index :subscriptions, :email, unique: true
  end
end