json.extract! @post, :id, :username, :post, :created_at
json.url post_url(@post, format: :json)
json.likes @post.likes[0].like_count
