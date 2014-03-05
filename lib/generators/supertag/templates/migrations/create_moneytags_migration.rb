# This migration comes from supertag
class CreateSupertagMoneytags < ActiveRecord::Migration
  def change
    create_table :supertag_moneytags do |t|
      t.string :name,             :index => true

      t.timestamps
    end
  end
end