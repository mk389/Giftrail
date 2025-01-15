class CreateRatings < ActiveRecord::Migration[7.2]
  def change
    create_table :ratings do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :rating_value, precision: 2, scale: 1, null: false
      t.timestamps
    end
  end
end
