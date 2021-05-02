class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.date :publishing_date
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
