class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.boolean :is_correct
      t.references :word, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :answers, [:title, :is_correct, :word_id], unique: true
  end
end
