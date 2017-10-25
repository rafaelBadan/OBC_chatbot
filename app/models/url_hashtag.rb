class UrlHashtag < ActiveRecord::Base
  validates_presence_of :url_id, :hashtag_id

  belongs_to :url
  belongs_to :hashtag
end
