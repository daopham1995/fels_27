class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  validates :cat_name, uniqueness: {case_sensitive: false}
end
