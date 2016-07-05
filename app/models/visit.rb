class Visit < ActiveRecord::Base
  validates :visitor_id, :shortened_url_id, presence: true


  def self.record_visit!(user, short_url)
    Visit.create!(visitor_id: user.id, shortened_url_id: short_url.id)
  end
end
