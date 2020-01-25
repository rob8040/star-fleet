class Song < ActiveRecord::Base
  validates :year, numericality: true, length: { minimum: 2, maximum: 4 }
end
