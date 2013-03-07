require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record/migration'

module Hound
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    desc 'Generates a migration to add a hound_actions table.'
    def create_migration_file
      migration_template 'create_hound_actions.rb', 'db/migrate/create_hound_actions.rb'
    end
  end
end