# This migration comes from supertag
class CreateSupertagHashtags < ActiveRecord::Migration
  def change
    create_table :supertag_hashtags do |t|
      t.string :name,             :index => true

      t.timestamps
    end
  end
end