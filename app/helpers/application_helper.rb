module ApplicationHelper
    include NavigationHelper
    include PostsHelper    
    def active_class(path)
        if request.path == path
          return 'active'
        else
          return ''
        end
      end
end
