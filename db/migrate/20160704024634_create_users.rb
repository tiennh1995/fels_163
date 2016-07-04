class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.text :about
      t.string :email
      t.string :password
      t.boolean :is_admin
      t.boolean :is_activated
      t.string :avatar

      t.timestamps null: false
    end
    add_index :users, [:name, :email], unique: true
  end
end
