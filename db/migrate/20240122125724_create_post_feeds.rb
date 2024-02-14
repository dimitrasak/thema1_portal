class CreatePostFeeds < ActiveRecord::Migration[7.1]
  def change
    create_table :post_feeds do |t|

      t.timestamps
    end
  end
end
