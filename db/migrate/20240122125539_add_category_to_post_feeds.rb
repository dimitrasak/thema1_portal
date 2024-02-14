class AddCategoryToPostFeeds < ActiveRecord::Migration[7.1]
  def change
    add_column :posts_feeds, :category, :string
  end
end
