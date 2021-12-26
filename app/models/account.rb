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

  def donut_chart_data(start_date: nil, end_date: nil, category: nil)

    #{a: 9, b: 20, c:30, d:8, e:12, f:3, g:7, h:14}

    #return [{a: 9, b: 20, c:30, d:8, e:12, f:3, g:7, h:14}]

    return [{leer: 100}] if self.work_times.empty?

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
    hash_with_values_for_donut_chart = {}


      #distinct_values = create_array_with_distinct_values_of_a_category(category.name, self.work_times.where("(categories->'#{category.name}') is not null").where(datetime: start_date..end_date))
      distinct_values = create_array_with_distinct_values_of_a_category(category, self.work_times.where(datetime: start_date..end_date))

      distinct_values.uniq!

      total_minutes = self.work_times.where(datetime: start_date..end_date).sum(:minutes)

      distinct_values.each do |value|

        if value.blank?
          null_minutes = self.work_times.where.not("(categories->'#{category}') is not null").where(datetime: start_date..end_date).sum(:minutes)
          empty_minutes = self.work_times.where('categories @> ?', {"#{category}": ""}.to_json).where(datetime: start_date..end_date).sum(:minutes)
          minutes = null_minutes + empty_minutes
          hash_with_values_for_donut_chart["#{I18n.t("empty")} - #{calculate_percentage(total_minutes, minutes)}%"] = minutes
        else
          minutes = self.work_times.where('categories @> ?', {"#{category}": "#{value}"}.to_json).where(datetime: start_date..end_date).sum(:minutes)
          hash_with_values_for_donut_chart["#{value} - #{calculate_percentage(total_minutes, minutes)}%"] = minutes
        end
      end

    #WorkTime.all.select("categories -> 'Projekt'")
    #UserActivity.pluck("raw_data->'activity'->'type'")
    [hash_with_values_for_donut_chart]
  end

  after_create :add_category_project_to_account

  private

  def calculate_percentage(total_value, part_value)
    percentage = (part_value.to_f/total_value.to_f)*100

    (percentage).round(1)
  end

  def add_category_project_to_account
    category = Category.create(account_id: self.id, name: I18n.t("area"))
    SelectOption.create(name: I18n.t("project1"), category_id: category.id)
    SelectOption.create(name: I18n.t("project2"), category_id: category.id)
    SelectOption.create(name: I18n.t("project3"), category_id: category.id)
    SelectOption.create(name: I18n.t("customer_care"), category_id: category.id)
    SelectOption.create(name: I18n.t("administration"), category_id: category.id)
    SelectOption.create(name: I18n.t("social_media"), category_id: category.id)
    SelectOption.create(name: I18n.t("workshops"), category_id: category.id)
    SelectOption.create(name: I18n.t("miscellaneous"), category_id: category.id)
  end

  def create_hash_with_distinct_values_of_a_category(category, records)
    distinct_values = {}

    records.each do |record|
      distinct_values[category] = record["categories"][category]
    end
    distinct_values
  end

  def create_array_with_distinct_values_of_a_category(category, records)
    distinct_values = []

    records.each do |record|
      distinct_values.push(record["categories"][category])
    end
    distinct_values
  end

end
