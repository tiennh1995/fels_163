class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :title
      t.string :picture
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :words, [:title, :category_id], unique: true
  end
end
