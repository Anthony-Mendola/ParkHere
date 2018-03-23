class AddLengthToListingTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :listing_types, :length, :integer
  end
end
