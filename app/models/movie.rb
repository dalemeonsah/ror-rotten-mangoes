class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title,
      presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  mount_uploader :image, ImageUploader

  scope :search_title, ->(title) {where("title like ?", "%#{title}%")}
  scope :search_director, ->(director) {where("director like ?", "%#{director}%")}
  scope :search_runtime, ->(runtime) {
    case runtime
    when "Under 90 minutes"
      where("runtime_in_minutes < ?", 90) 
    when "Between 90 and 120 minutes"
      where("runtime_in_minutes BETWEEN ? AND ?", 90, 120) 
    when "Over 120 minutes"
      where("runtime_in_minutes > ?", 120) 
    end
  }


  def review_average
    reviews.size == 0 ? @errors = "unavailable" : reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
