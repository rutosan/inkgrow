class AddImageToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :image, :integer
  end
end
