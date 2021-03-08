class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners do |t|
      t.string :name, null: false, default: ""
      t.string :auth_token

      t.timestamps
    end
    add_index :partners, :auth_token, unique: true
  end
end
