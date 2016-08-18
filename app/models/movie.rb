class Movie < ApplicationRecord
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  protected

  def release_date_is_in_the_past
    if release_date.present? and release_date > Date.today
      errors.add(:release_date, "should be in the past")
    end
  end
end
