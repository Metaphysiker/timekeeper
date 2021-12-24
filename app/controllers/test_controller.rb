class TestController < ApplicationController
  if Rails.env.development?

    def generate_json_of_translation
      locale = YAML.load_file('config/locales/de.yml')
      File.write("cypress/fixtures/locales/de.json", locale.to_json)

      locale = YAML.load_file('config/locales/models.de.yml')
      File.write("cypress/fixtures/locales/models.de.json", locale.to_json)

      head :ok
    end

    def create_users
      10.times do
        create_fake_user("no_role")
      end

      #File.delete("cypress/fixtures/users.json")
      File.write("cypress/fixtures/users.json", User.all.to_json)
      head :ok
    end

    def create_accounts
      10.times do
        create_fake_accounts
      end

      File.write("cypress/fixtures/accounts.json", Account.all.to_json)
      head :ok
    end

    def create_work_times
      10.times do
        create_fake_work_time
      end

      File.write("cypress/fixtures/work_times.json", WorkTime.all.to_json)
      head :ok
    end

    def create_categories
      10.times do
        create_fake_categories
      end

      File.write("cypress/fixtures/categories.json",Category.all.to_json)
      head :ok
    end

    def create_work_times_only_json

      name_of_file = "work_times_json"
      if params["name_of_file"].present?
        name_of_file = params[:name_of_file]
      end

      work_times_json = []
      10.times do
        work_time = OpenStruct.new(
          task: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
          minutes: rand(1..60),
          datetime: Faker::Time.between(from: DateTime.now - 100.days, to: DateTime.now),
          categories: {I18n.t("project") => Faker::Lorem.word }
          #account_id: Account.first.id
        )
        work_times_json.push(work_time.to_h)
      end

      File.write("cypress/fixtures/#{name_of_file}.json", work_times_json.to_json)
      head :ok
    end

    def create_categories_only_json

      name_of_file = "categories_json"
      if params["name_of_file"].present?
        name_of_file = params[:name_of_file]
      end

      categories_json = []
      10.times do
        categories = OpenStruct.new(
          name: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
          #account_id: Account.first.id
        )
        categories_json.push(categories.to_h)
      end

      File.write("cypress/fixtures/#{name_of_file}.json", categories_json.to_json)
      head :ok
    end

    def create_users_only_json

      name_of_file = "users_only_json"
      if params["name_of_file"].present?
        name_of_file = params[:name_of_file]
      end

      user_json = []
      10.times do
        user = OpenStruct.new(
          email: Faker::Internet.unique.email,
          password: "password",
          password_confirmation: "password"
        )
        user_json.push(user.to_h)
      end

      File.write("cypress/fixtures/#{name_of_file}.json", user_json.to_json)
      head :ok
    end

    def destroy_all_users
      User.all.each do |user|
        sign_out user
      end

      User.destroy_all
      head :ok
    end

    def destroy_all_accounts
      Account.destroy_all
      head :ok
    end

    def destroy_all_work_times
      WorkTime.destroy_all
      head :ok
    end

    def destroy_all_categories
      Category.destroy_all
      head :ok
    end

    private

    def create_fake_user(role)
      User.create(
        email: Faker::Internet.unique.email,
        password: "password",
        password_confirmation: "password"
      )
    end

    def create_fake_work_time
      WorkTime.create(
        task: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
        minutes: rand(1..1000),
        datetime: Faker::Time.between(from: DateTime.now - 100.days, to: DateTime.now),
        account_id: Account.first.id,
        categories: {I18n.t("project") => Faker::Lorem.word }
      )
    end

    def create_fake_category
      Category.create(
        name: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
        account_id: Account.first.id,
      )
    end

    def create_fake_accounts
      Account.create(
        name: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
        user_id: User.first.id
      )
    end


  end
end
