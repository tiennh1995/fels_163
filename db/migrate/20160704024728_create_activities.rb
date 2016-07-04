class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :action_id
      t.integer :activity_type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :activities, [:user_id, :created_at], unique: true
  end
end
