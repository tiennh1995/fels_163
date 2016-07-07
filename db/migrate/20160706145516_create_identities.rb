class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :accesstoken
      t.string :refresh_token
      t.string :image
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
