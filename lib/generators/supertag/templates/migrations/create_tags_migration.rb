# This migration comes from simple_usertag
class CreateSupertagtags < ActiveRecord::Migration
  def change
    create_table :supertag_usertags do |t|
      t.string :name,             :index => true

      t.timestamps
    end
  end
end
