class Ship < ActiveRecord::Base
  has_many :crew_members
  validates :name, presence: true, on: :create
  validates :ship_class, presence: true, on: :create
  validates :location, presence: true, on: :create
end
