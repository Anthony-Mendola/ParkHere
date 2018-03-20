class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string :name
      t.integer :listing_id
      t.timestamps
    end
  end
end
