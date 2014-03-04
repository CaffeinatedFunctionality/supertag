module Supertag
  class Tag < ActiveRecord::Base
    self.table_name = "supertag_tags"

    has_many :taggings

    validates :name, uniqueness: true

    # TODO Beef up the regex (ie.:what if content is HTML)
    # this is how Twitter does it:
    # https://github.com/twitter/twitter-text-rb/blob/master/lib/twitter-text/regex.rb
    USERTAG_REGEX = /(?:\s|^)(@(?!(?:\d+|\w+?_|_\w+?)(?:\s|$))([a-z0-9\-_]+))/i
    HASHTAG_REGEX = /(?:\s|^)(#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$))([a-z0-9\-_]+))/i
    MONEYTAG_REGEX = /(?:\s|^)($(?!(?:\d+|\w+?_|_\w+?)(?:\s|$))([a-z0-9\-_]+))/i
    ATTRIBUTETAG_REGEX = /(?:\s|^)((?!(?:\d+|\w+?_|_\w+?)(?:\s|$))%([a-z0-9\-_]+))/i

    def self.find_by_name(name)
      Tag.where("lower(name) =?", name.downcase).first
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

    def taggables
      self.taggings.includes(:taggable).collect { |h| h.taggable }
    end

    def tagged_types
      self.taggings.pluck(:taggable_type).uniq
    end

    def tagged_ids_by_types
      tagged_ids ||= {}
      self.taggings.each do |h|
        tagged_ids[h.taggable_type] ||= Array.new
        tagged_ids[h.taggable_type] << h.taggable_id
      end
      tagged_ids
    end

    def tagged_ids_for_type(type)
      tagged_ids_by_types[type]
    end

    def to_s
      name
    end

    def self.clean_orphans # From DB
      # TODO Make this method call a single SQL query
      orphans = self.all.select { |h| h.taggables.size == 0 }
      orphans.map(&:destroy)
    end

  end
end
