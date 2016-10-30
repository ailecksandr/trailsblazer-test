class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :weight
      t.references :thing, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
