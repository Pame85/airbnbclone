class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.text :comment
      t.integer :rating
      t.string :reviewable_type
      t.integer :reviewable_id

      t.timestamps
    end
  end
end
