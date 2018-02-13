class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :author_id
      t.integer :post_id

      t.timestamps
    end
  end
end
