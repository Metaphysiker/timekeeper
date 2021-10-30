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

    private

    def create_fake_user(role)
      User.create(
        email: Faker::Internet.email,
        password: "password",
        password_confirmation: "password"
      )
    end

    def create_fake_work_time
      WorkTime.create(
        task: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
        minutes: rand(1..1000),
        account_id: Account.first.id
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
