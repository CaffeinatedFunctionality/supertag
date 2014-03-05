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

        route 'get "tags",            to: "tags#index",     as: :tags'
        route 'get "tags/:tag",   to: "tags#show",      as: :tag'
      end
    end
  end
end
