    # app/controllers/post_controller.rb
    class PostsFeedController < ApplicationController
      def show
        @post = PostsFeed.find(params[:id])
        # Additional logic if needed

        redirect_to posts_feed_index_path
      end

      def index
        @posts_feed = PostsFeed.all.order("created_at DESC")
      end

      def destroy
        @post = PostsFeed.find(params[:id])
               

        if @post
          puts "Deleting post with ID: #{@post.id}"
          @post.destroy
          redirect_to posts_feed_index_path, notice: 'Post was successfully deleted.'
        else
          redirect_to posts_feed_index_path, alert: 'Post not found.'
        end
      end
      
      def create
      end
    
      def store
        #puts "Category: #{params[:category]}"
        #@image = params[:media] ? Cloudinary::Uploader.upload(params[:media]) : Cloudinary::Uploader.upload(default_media_url(params[:category]))
        #puts "Cloudinary Upload Response: #{@image}"
        # upload image to cloudinary
        #@image = Cloudinary::Uploader.upload(params[:media])
        
        # create a new post object and save to db
        #@post = PostsFeed.new({:title => params[:title], :body => params[:body], :author => params[:author], :category => params[:category],  :media => @image['secure_url']})

        # Check if the category is "Social" and if a file is present
        if params[:category] == "Social Input" && params[:media].present?
          # Handle file upload for "Social" category
          uploaded_file = params[:media]
          cloudinary_response = Cloudinary::Uploader.upload(uploaded_file)

          # Create a new post object and save to db
          @post = PostsFeed.new({
            title: params[:title],
            body: params[:body],
            author: params[:author],
            category: params[:category],
            media: cloudinary_response['secure_url']
          })
        else
          # For other categories or when no file is provided
          @post = PostsFeed.new({
            title: params[:title],
            body: params[:body],
            author: params[:author],
            category: params[:category],
            media: default_media_url(params[:category])
          })
        end
       
        if @post.save
          # broadcasting posts using pusher
          Pusher.trigger('posts-channel','new-post', {
            id: @post.id,
            title: @post.title,
            media: @post.media,
            body: @post.body,
            category: @post.category
          })
        end 
        
        redirect_to posts_feed_index_path
      end

      
      #app/assets/images/question_mark.png
      #Helper method to get default media URL based on category
      def default_media_url(category)
        case category
          when "Questions"
            "https://res.cloudinary.com/dhgdirwff/image/upload/v1705937228/question_mark_hogwlx.png"
          when "Announcements"
            "https://res.cloudinary.com/dhgdirwff/image/upload/v1705937228/announcement_rzazi4.png"
        end
      end
    end
