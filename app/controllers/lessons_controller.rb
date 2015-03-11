class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def show
    @words = Word.search_words_by_category_id params[:id]
    @lesson = Lesson.new user_id: current_user.id, mark: 0, category_id: params[:id]
    @lesson.words << @words
    @lesson.save
  end
end
