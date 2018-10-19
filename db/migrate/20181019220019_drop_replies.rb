class DropReplies < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :replies, :integer
  end
end
