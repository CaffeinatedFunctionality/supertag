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
          migration_template "migrations/create_hashtags_migration.rb", "db/migrate/create_supertag_hashtags.rb"
          migration_template "migrations/create_hashtaggings_migration.rb", "db/migrate/create_supertag_hashtaggings.rb"
          migration_template "migrations/create_usertags_migration.rb", "db/migrate/create_supertag_usertags.rb"
          migration_template "migrations/create_usertaggings_migration.rb", "db/migrate/create_supertag_usertaggings.rb"
          migration_template "migrations/create_moneytags_migration.rb", "db/migrate/create_supertag_moneytags.rb"
          migration_template "migrations/create_moneytaggings_migration.rb", "db/migrate/create_supertag_moneytaggings.rb"
      end
    end
  end
end
