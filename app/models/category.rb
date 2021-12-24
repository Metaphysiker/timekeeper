class Category < ApplicationRecord
  belongs_to :account
  has_many :select_options
end
