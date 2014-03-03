require 'rails/generators/active_record'

module SimpleUsertag
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      def self.next_migration_number(path)
        ActiveRecord::Generators::Base.next_migration_number(path)
      end

      def generate_migration
          migration_template "migrations/create_usertags_migration.rb", "db/migrate/create_simple_usertag_usertags.rb"
          migration_template "migrations/create_usertaggings_migration.rb", "db/migrate/create_simple_usertag_usertaggings.rb"
      end
    end
  end
end
