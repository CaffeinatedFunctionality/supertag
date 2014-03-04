module Supertag
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def generate_views
        copy_file "views/tags_controller.rb", "app/controllers/tags_controller.rb"
        copy_file "views/tags_helper.rb", "app/helpers/tags_helper.rb"
        copy_file "views/tags_index.html.erb", "app/views/tags/index.html.erb"
        copy_file "views/tags_show.html.erb", "app/views/tags/show.html.erb"

        route 'get "tags",            to: "tags#index",     as: :tags'
        route 'get "tags/:tag",   to: "tags#show",      as: :tag'
      end
    end
  end
end
