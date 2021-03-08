class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.references :owner, null: false, foreign_key: true
      t.string :name, null: false, default: "", length: 45
      t.string :description, null: false , default: "", length: 255
      t.string :status, null: false, default: "", length: 9
      t.decimal :rental_price, null: false, precision: 11, scale: 2, default: 0

      t.timestamps
    end
  end
end
