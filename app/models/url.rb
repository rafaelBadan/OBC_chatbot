require "pg_search"
include PgSearch

class Url < ActiveRecord::Base
  validates_presence_of :pathurl

  has_many :url_hashtags
  has_many :hashtags, through: :url_hashtags
  belongs_to :company

  # include PgSearch
  pg_search_scope :search, :against => [:pathurl]
end
