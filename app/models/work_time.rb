class WorkTime < ApplicationRecord
  belongs_to :account

  validates :task, presence: true
  validates :minutes, numericality: true, presence: true

  def self.in_hours(minutes)
    "#{(minutes/60).to_i} h #{(minutes % 60).round(0)} min"
  end
end
