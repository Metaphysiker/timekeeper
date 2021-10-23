class TestController < ApplicationController
  if Rails.env.development?

    def generate_json_of_translation
      locale = YAML.load_file('config/locales/de.yml')
      File.write("cypress/fixtures/locales/de.json", locale.to_json)
      head :ok
    end

    def create_users
      10.times do
        create_fake_user("no_role")
      end

      File.write("cypress/fixtures/users.json", User.all.to_json)
      head :ok
    end

    def destroy_all_users
      User.all.each do |user|
        sign_out user
      end
      
      User.destroy_all
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


  end
end
