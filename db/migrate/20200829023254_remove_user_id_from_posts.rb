class RemoveUserIdFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :string
  end
end
