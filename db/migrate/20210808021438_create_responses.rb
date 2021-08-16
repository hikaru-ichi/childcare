class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.references :user, null: false, foreign_key: { to_table: :users}
      t.references :post, null: false, foreign_key: { to_table: :posts}
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
