class WorkTime < ApplicationRecord
  belongs_to :account

  validates :task, presence: true
  validates :minutes, numericality: true, presence: true

  def self.in_hours(minutes)
    "#{minutes/60} #{I18n.t("hours")} #{minutes % 60} #{I18n.t("minutes")}"
  end
end
