class AddTokenToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :token, :string
    add_index :posts, :token
  end
end
