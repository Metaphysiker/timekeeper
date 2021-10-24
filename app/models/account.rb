class Account < ApplicationRecord
  belongs_to :user
  has_many :work_times
end
