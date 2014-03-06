module Supertag
  class Usertag < ActiveRecord::Base
    self.table_name = "supertag_usertags"

    has_many :usertaggings
    belongs_to :user

    validates :name, uniqueness: true

    # TODO Beef up the regex (ie.:what if content is HTML)
    # this is how Twitter does it:
    # https://github.com/twitter/twitter-text-rb/blob/master/lib/twitter-text/regex.rb
    USERTAG_REGEX = /(?:\s|^)(@(?!(?:\d+|\w+?_|_\w+?)(?:\s|$))([a-z0-9\-_]+))/i

    def self.find_by_name(name)
      Usertag.where("lower(name) =?", name.downcase).first
    end

    def self.find_or_create_by_name(name, &block)
      find_by_name(name) || create(name: name, &block)
    end


    def name=(val)
      write_attribute(:name, val.downcase)
    end

    def name
      read_attribute(:name).downcase
    end

    def usertaggables
      self.usertaggings.includes(:usertaggable).collect { |h| h.usertaggable }
    end

    def usertagged_types
      self.usertaggings.pluck(:usertaggable_type).uniq
    end

    def usertagged_ids_by_types
      usertagged_ids ||= {}
      self.usertaggings.each do |h|
        usertagged_ids[h.usertaggable_type] ||= Array.new
        usertagged_ids[h.usertaggable_type] << h.usertaggable_id
      end
      usertagged_ids
    end

    def usertagged_ids_for_type(type)
      usertagged_ids_by_types[type]
    end

    def to_s
      name
    end

    def self.clean_orphans # From DB
      # TODO Make this method call a single SQL query
      orphans = self.all.select { |h| h.usertaggables.size == 0 }
      orphans.map(&:destroy)
    end

  end
end
