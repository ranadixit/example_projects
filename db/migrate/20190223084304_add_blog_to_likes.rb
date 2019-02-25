class AddBlogToLikes < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :blog, foreign_key: true
  end
end
