class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :contact
      t.decimal :cost
      t.binary :image
      t.float :latitude
      t.float :longitude
      t.string :address
      t.integer :user_id
      t.attachment :image
      t.timestamps
    end
  end
end
