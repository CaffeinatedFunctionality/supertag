module Supertag
  class Hashtagging < ActiveRecord::Base
    self.table_name = "supertag_taggings"

    belongs_to :hashtag
    belongs_to :hashtaggable, polymorphic: true
  end
end
