class Picture < ActiveRecord::Base
  include SimpleUsertag::Usertaggable
  usertaggable_attribute :caption
end
