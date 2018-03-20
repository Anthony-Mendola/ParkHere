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
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end
end
