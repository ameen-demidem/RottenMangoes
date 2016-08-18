class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user, :movie, :text,
    presence: true

  validates :rating_out_of_ten,
    numericality: {
      only_integer: true, greater_than_or_equal: 1, less_than_or_equal: 10
    }

end
