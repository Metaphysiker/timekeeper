class Account < ApplicationRecord
  belongs_to :user
  has_many :work_times
  has_many :categories

  def area_chart_data(start_date: nil, end_date: nil, interval: nil)

    return [{date: Date.today.to_s, minutes: 0}] if self.work_times.empty?

    if interval.blank?
      interval = 1.day
    else
      interval = ActiveSupport::Duration.parse(interval)
    end

    if start_date.nil?
      start_date = self.work_times.order(:datetime).limit(1).first.datetime.to_date
    else
      start_date = DateTime.parse(start_date)
    end

    if end_date.nil?
      end_date = self.work_times.order(:datetime).reverse_order.limit(1).first.datetime.to_date
    else
      end_date = DateTime.parse(end_date)
    end


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

  def donut_chart_data(start_date: nil, end_date: nil)

    #{a: 9, b: 20, c:30, d:8, e:12, f:3, g:7, h:14}

    #return [{a: 9, b: 20, c:30, d:8, e:12, f:3, g:7, h:14}]

    #return [{date: Date.today.to_s, minutes: 0}] if self.work_times.empty?

    if start_date.nil?
      start_date = self.work_times.order(:datetime).limit(1).first.datetime.to_date
    else
      start_date = DateTime.parse(start_date)
    end

    if end_date.nil?
      end_date = self.work_times.order(:datetime).reverse_order.limit(1).first.datetime.to_date
    else
      end_date = DateTime.parse(end_date)
    end


    data_array = []

    categories.each do |category|
      work_times_with_category = self.work_times.where("(categories->'#{category.name}') is not null").where(datetime: start_date..end_date)
    end

    self.work_times.select("categories -> Projekt").distinct

    byebug

    data_array
  end

  after_create :add_category_project_to_account

  private

  def add_category_project_to_account
    category = Category.create(account_id: self.id, name: I18n.t("project"))
  end

end
