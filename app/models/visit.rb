class Visit < ActiveRecord::Base
  attr_accessible :visitor_id, :shortened_url_id

  validates :visitor_id, :shortened_url_id, :presence => true

  def self.record_visit!(user, shortened_url)
    Visit.new({
      :visitor_id => user.id,
      :shortened_url_id => shortened_url.id
    }).save!
  end

  belongs_to(
    :visitor,
    :primary_key => :id,
    :foreign_key => :visitor_id,
    :class_name => "User"
  )

  belongs_to(
    :visited_url,
    :primary_key => :id,
    :foreign_key => :shortened_url_id,
    :class_name => "ShortenedUrl"
  )
end