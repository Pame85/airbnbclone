class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :location
      t.integer :rooms
      t.integer :capacity
      t.string :property_type
      t.decimal :price
      t.date :availability
      t.float :average_rating

      t.timestamps
    end
  end
end
