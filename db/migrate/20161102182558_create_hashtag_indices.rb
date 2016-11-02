class CreateHashtagIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :hashtag_indices do |t|
      t.integer :post_id
      t.string :hashtag

      t.timestamps
    end
    add_index :hashtag_indices, :hashtag
  end
end
