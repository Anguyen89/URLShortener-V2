class Visit < ActiveRecord::Base
  validates :visitor_id, :shortened_url_id, presence: true

  belongs_to :shortened_url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"

  belongs_to :visitor,
    foreign_key: :visitor_id,
    primary_key: :id,
    class_name: "User"



  def self.record_visit!(user, short_url)
    Visit.create!(visitor_id: user.id, shortened_url_id: short_url.id)
  end
end
