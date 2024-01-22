    # app/controllers/post_controller.rb
    class PostsFeedController < ApplicationController
      def index
        @posts_feed = PostsFeed.all.order("created_at DESC")
      end

      def create
      end
    
      def store
        # upload image to cloudinary
        @image = Cloudinary::Uploader.upload(params[:media])
        # create a new post object and save to db
        @post = PostsFeed.new({:title => params[:title], :body => params[:body], :author => params[:author],  :media => @image['secure_url']})
       
        if @post.save
          # broadcasting posts using pusher
          Pusher.trigger('posts-channel','new-post', {
            id: @post.id,
            title: @post.title,
            media: @post.media,
            body: @post.body
          })
        end 
        
        redirect_to posts_feed_index_path
      end
    end
