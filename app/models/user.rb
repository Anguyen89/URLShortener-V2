class User < ActiveRecord::Base
  validates :email, presence: true

  has_many :submitted_urls,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "ShortenedUrl"


end
