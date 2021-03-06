class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, presence: true, unique: true, index: true
      t.string :password_digest, null: false

      t.timestamps null: false
    end
  end
end
