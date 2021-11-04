class Account < ApplicationRecord
  belongs_to :user
  has_many :work_times

  def work_time_data
    data_array = []
    self.work_times.each do |work_time|
      data_array.push({date: work_time.created_at.to_date, minutes: work_time.minutes})
    end

    data_array.to_json
  end

end
