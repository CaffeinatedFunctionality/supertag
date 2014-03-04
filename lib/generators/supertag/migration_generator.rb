require 'rails/generators/active_record'

module Supertag
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      def self.next_migration_number(path)
        ActiveRecord::Generators::Base.next_migration_number(path)
      end

      def generate_migration
          migration_template "migrations/create_tags_migration.rb", "db/migrate/create_supertag_tags.rb"
          migration_template "migrations/create_taggings_migration.rb", "db/migrate/create_supertag_taggings.rb"
      end
    end
  end
end
