class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.text :about
      t.boolean :is_admin, default: false
      t.string :image

      t.timestamps null: false
    end
  end
end
