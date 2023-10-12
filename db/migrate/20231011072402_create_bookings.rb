class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      t.integer :duration
      t.boolean :confirmed, default: true
      t.decimal :total_price, precision: 10, scale: 5

      t.timestamps
    end
  end
end
