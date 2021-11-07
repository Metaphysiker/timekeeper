class Account < ApplicationRecord
  belongs_to :user
  has_many :work_times

  def work_time_data(start_date = nil, end_date = nil, interval = nil)

    return [{date: Date.today.to_s, minutes: 0}] if self.work_times.empty?

    interval = 1.day if interval.nil?
    start_date = self.work_times.order(:datetime).limit(1).first.datetime.to_date if start_date.nil?
    end_date = self.work_times.order(:datetime).reverse_order.limit(1).first.datetime.to_date if end_date.nil?

    data_array = []

    while (start_date === end_date) || (start_date.before?(end_date))

    sum_of_minutes = self.work_times.where(datetime: start_date..start_date + interval - 1.day).sum(:minutes)
    data_array.push(
      {
        date: start_date.to_date.to_s,
        minutes: sum_of_minutes,
        interval: "<strong>#{start_date.to_s} - #{(start_date + interval - 1.day).to_s}</strong>"
      }
    )

    start_date = start_date + interval

    # while loop ends here
    end


    #self.work_times.each do |work_time|
    #  data_array.push({date: work_time.datetime.to_date.to_s, minutes: work_time.minutes})
    #end

    data_array

    #data_array.as_json.to_json

    #self.work_times.group_by_week(:datetime).sum(:minutes).to_jsonself.work_times.group_by_week(:datetime).sum(:minutes).to_json unless self.work_times.empty? || self.work_times.count == 1
    #[{"date": "01-01-2021", "minutes": 200}, {"date": "2019-02-03", "minutes": 100}].to_json
  end

end
