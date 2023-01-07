class AddAuthorToBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :author
  end
end
