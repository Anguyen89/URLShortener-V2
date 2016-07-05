class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true
  validates :user_id, :long_url, :short_url, presence: true

  belongs_to :submitter,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"

  has_many :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "Visit"

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor


  def num_clicks
    visits.count
  end

  def num_uniques
    visits.select("user_id").distinct.count
  end

  def num_recent_uniques
    visits
      .select("user_id")
      .where("created_at > ?", 10.minutes.ago)
      .distinct
      .count
  end

  def self.random_code
    random = SecureRandom::urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom::urlsafe_base64(16)
    end
    random
  end


  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
    user_id: user.id,
    long_url: long_url,
    short_url: ShortenedUrl.random_code
    )
  end


end
