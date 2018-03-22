class CreateListingTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :listing_types do |t|
      t.belongs_to :listing
      t.belongs_to :type
      t.timestamps
    end
  end
end
