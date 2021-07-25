class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.references :user, null: false, foreign_key: true
      t.date :child_birth
      t.string :child_gender

      t.timestamps
    end
  end
end
