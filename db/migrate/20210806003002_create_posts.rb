class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: { to_table: :users}
      t.references :category, null: false, foreign_key: { to_table: :categories}
      t.string :title
      t.string :content
      t.string :image

      t.timestamps
    end
  end
end
