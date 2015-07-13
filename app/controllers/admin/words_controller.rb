class Admin::WordsController < Admin::AdminController

  before_action :correct_supervisor, only: [:edit, :update, :index, :show]

  def index
    @words = Word.search params[:content], params[:category_id]
    @words = @words.paginate page: params[:page], per_page: 10
  end

  def new
    @word = Word.new
    4.times do
      @answer = @word.answers.build
    end 
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = "Create a new word successfully!"
      redirect_to admin_words_path(@answer)
    else
      flash[:danger] = "Invalid word!"
      render "new"
    end
  end

  def show
    @word = Word.find params[:id]
  end

  def destroy
    @word = Word.find params[:id]
    @word.destroy
    flash[:success] = "Word deleted"
    redirect_to admin_words_url
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id, answers_attributes: [:content, :correct]
  end
end
