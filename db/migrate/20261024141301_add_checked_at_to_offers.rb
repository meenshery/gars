class AddCheckedAtToOffers < ActiveRecord::Migration[8.1]
  def change
    add_column :offers, :checked_at, :datetime
  end
end