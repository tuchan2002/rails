class RemoveAuthorFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :author, :string
  end
end
