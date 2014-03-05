# This migration comes from supertag
class CreateSupertagUsertaggings < ActiveRecord::Migration
  def change
    create_table :supertag_usertaggings do |t|
      t.references :usertag,      :index => true
      t.references :usertaggable, :polymorphic => true
    end
    add_index :supertag_usertaggings, ["usertaggable_id", "usertaggable_type"],
              :name => 'index_usertaggings_usertaggable_id_usertaggable_type'
  end
end