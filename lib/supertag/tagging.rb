module Supertag
  class Tagging < ActiveRecord::Base
    self.table_name = "supertag_taggings"

    belongs_to :tag
    belongs_to :taggable, polymorphic: true
  end
end
