class AddRepliedToColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :replies, :integer
  end
end
