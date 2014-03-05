module Supertag
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def generate_views
        copy_file "views/hashtags_controller.rb", "app/controllers/hashtags_controller.rb"
        copy_file "views/usertags_controller.rb", "app/controllers/usertags_controller.rb"
        copy_file "views/moneytags_controller.rb", "app/controllers/moneytags_controller.rb"
        copy_file "views/tags_helper.rb", "app/helpers/tags_helper.rb"
        copy_file "views/hashtags_index.html.erb", "app/views/hashtags/index.html.erb"
        copy_file "views/hashtags_show.html.erb", "app/views/hashtags/show.html.erb"
        copy_file "views/usertags_index.html.erb", "app/views/usertags/index.html.erb"
        copy_file "views/usertags_show.html.erb", "app/views/usertags/show.html.erb"
        copy_file "views/moneytags_index.html.erb", "app/views/moneytags/index.html.erb"
        copy_file "views/moneytags_show.html.erb", "app/views/moneytags/show.html.erb"

        route 'get "hashtags",            to: "hashtags#index",     as: :hashtags'
        route 'get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag'
        route 'get "usertags",            to: "usertags#index",     as: :usertags'
        route 'get "usertags/:usertag",   to: "usertags#show",      as: :usertag'
        route 'get "moneytags",            to: "moneytags#index",     as: :moneytags'
        route 'get "moneytags/:moneytag",   to: "moneytags#show",      as: :moneytag'
      end
    end
  end
end
