class Account < ApplicationRecord
  belongs_to :user
  has_many :work_times

  def work_time_data
    #data_array = []
    #self.work_times.group_by_week(:datetime).each do |week|
    #  data_array.push({date: work_time.created_at.to_date, minutes: work_time.minutes})
    #end

    #data_array.to_json
    self.work_times.group_by_week(:datetime).sum(:minutes).to_json unless self.work_times.empty? || self.work_times.count == 1
  end

end
