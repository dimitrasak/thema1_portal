class CreatePostsFeeds < ActiveRecord::Migration[7.1]
  def change
    create_table :posts_feeds do |t|
      t.text :title
      t.text :body
      t.text :author
      t.text :media

      t.timestamps
    end
  end
end
