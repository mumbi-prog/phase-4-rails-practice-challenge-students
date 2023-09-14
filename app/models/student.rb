class Student < ApplicationRecord
  belongs_to :Instructor

  validates :name, presence: true
  validates :major, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 18 }
  validates :instructor_id, presence: true
end
