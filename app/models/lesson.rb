class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words
  
  accepts_nested_attributes_for :lesson_words, allow_destroy: true

end
