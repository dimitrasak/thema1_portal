class CreateLikes < ActiveRecord::Migration[7.1]
    def change
      create_table :likes do |t|
        t.integer :like_count, default: 0 # add the default: 0 part.
        t.references :post, foreign_key: true
        t.timestamps
      end      
    end
end
      
  

