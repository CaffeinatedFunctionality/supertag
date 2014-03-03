module SimpleUsertag
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def generate_views
        copy_file "views/usertags_controller.rb", "app/controllers/usertags_controller.rb"
        copy_file "views/usertags_helper.rb", "app/helpers/usertags_helper.rb"
        copy_file "views/usertags_index.html.erb", "app/views/usertags/index.html.erb"
        copy_file "views/usertags_show.html.erb", "app/views/usertags/show.html.erb"

        route 'get "usertags",            to: "usertags#index",     as: :usertags'
        route 'get "usertags/:usertag",   to: "usertags#show",      as: :usertag'
      end
    end
  end
end
