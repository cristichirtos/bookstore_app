class AddFieldsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :publisher, :string
    add_column :books, :description, :text
    add_column :books, :image_url, :string
  end
end
