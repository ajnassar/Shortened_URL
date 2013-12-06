class ShortenedUrl < ActiveRecord::Base
  attr_accessible :long_url, :short_url, :submitter_id

  validates :long_url, :presence => true
  validates :short_url, :presence => true
  validates :submitter_id, :presence => true

  def self.random_code
    loop do
      random_code = SecureRandom::urlsafe_base64[0...16]
      if ShortenedUrl.find_by_short_url(random_code).nil?
        return random_code
      end
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.new({
      :long_url => long_url,
      :short_url => ShortenedUrl.random_code,
      :submitter_id => user.id
      }).save!
  end

  belongs_to(
    :submitter,
    :primary_key => :id,
    :foreign_key => :submitter_id,
    :class_name => "User"
  )

  has_many(
    :visits,
    :primary_key => :id,
    :foreign_key => :shortened_url_id,
    :class_name => "Visit"
  )

  has_many(
    :visitors,
    :through => :visits,
    :source => :visitor,
    :uniq => true
  )

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    num_of_visits = []
    self.visits.each do |visit|
       if (Time.now.utc - visit.created_at) < 601 &&
         !num_of_visits.include?(visit.visitor_id)
         num_of_visits << visit.visitor_id
       end
    end
    num_of_visits.count
  end
end