class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true
  validates :user_id, :long_url, :short_url, presence: true

  belongs_to :submitter,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"

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
