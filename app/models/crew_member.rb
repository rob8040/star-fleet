class CrewMember < ActiveRecord::Base
  belongs_to :ship
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :specialty_division, presence: true, on: :create
end
