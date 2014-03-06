module Supertag
  class Moneytag < ActiveRecord::Base
    self.table_name = "supertag_moneytags"

    has_many :moneytaggings

    validates :name, uniqueness: true

    # TODO Beef up the regex (ie.:what if content is HTML)
    # this is how Twitter does it:
    # https://github.com/twitter/twitter-text-rb/blob/master/lib/twitter-text/regex.rb
    MONEYTAG_REGEX = /(?:\s|^)(\$(?!(?:\d+|\w+?_|_\w+?)(?:\s|$))([a-z0-9\-_]+))/i

    def self.find_by_name(name)
      Moneytag.where("lower(name) =?", name.downcase).first
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

    def moneytaggables
      self.moneytaggings.includes(:moneytaggable).collect { |h| h.moneytaggable }
    end

    def moneytagged_types
      self.moneytaggings.pluck(:moneytaggable_type).uniq
    end

    def moneytagged_ids_by_types
      moneytagged_ids ||= {}
      self.moneytaggings.each do |h|
        moneytagged_ids[h.moneytaggable_type] ||= Array.new
        moneytagged_ids[h.moneytaggable_type] << h.moneytaggable_id
      end
      moneytagged_ids
    end

    def moneytagged_ids_for_type(type)
      moneytagged_ids_by_types[type]
    end

    def to_s
      name
    end

    def self.clean_orphans # From DB
      # TODO Make this method call a single SQL query
      orphans = self.all.select { |h| h.moneytaggables.size == 0 }
      orphans.map(&:destroy)
    end

  end
end