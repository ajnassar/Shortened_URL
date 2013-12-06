class User < ActiveRecord::Base
  attr_accessible :email

  validates :email, :presence => true, :uniqueness => true

  has_many(
    :shortened_urls,
    :primary_key => :id,
    :foreign_key => :submitter_id,
    :class_name => "ShortenedUrl"
  )

  has_many(
    :visits,
    :primary_key => :id,
    :foreign_key => :visitor_id,
    :class_name => "Visit"
  )

  has_many(
    :visit_urls,
    :through => :visits,
    :source => :visited_url,
    :uniq => true
  )
end