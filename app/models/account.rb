class Account < ApplicationRecord
  belongs_to :user
  has_many :work_times

  def work_time_data
    data_array = []

    self.work_times.each do |work_time|
      data_array.push({date: work_time.datetime.to_date.to_s, minutes: work_time.minutes})
    end

    data_array

    #data_array.as_json.to_json

    #self.work_times.group_by_week(:datetime).sum(:minutes).to_jsonself.work_times.group_by_week(:datetime).sum(:minutes).to_json unless self.work_times.empty? || self.work_times.count == 1
    #[{"date": "01-01-2021", "minutes": 200}, {"date": "2019-02-03", "minutes": 100}].to_json
  end

end
