class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.belongs_to :user, foreign_key: true
      t.string :token

      t.timestamps
    end

    add_index :api_keys, :token, unique: true
  end
end
