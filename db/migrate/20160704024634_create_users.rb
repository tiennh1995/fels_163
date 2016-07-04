class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.text :about
      t.boolean :is_admin, default: false
      t.boolean :is_activated
      t.string :avatar

      t.timestamps null: false
    end
    add_index :users, [:name], unique: true
  end
end
