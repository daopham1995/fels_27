require "rails_helper"

RSpec.describe Admin::WordsController, type: :controller do
  before do
    @admin = FactoryGirl.create :user, admin: true
    subject.send :log_in, @admin
    @word = FactoryGirl.create :word
  end

  describe "GET #index" do
    before {get :index}
    it {expect(response).to render_template :index}
  end

  describe "GET #new" do
    before {get :new}
    it {expect(response).to render_template :new}
  end

  describe "POST #create" do
    context "success with valid attributes" do
      before {post :create, word: FactoryGirl.attributes_for(Word)}
      it {expect(response).to redirect_to admin_words_path}
      it {expect(flash[:success]).to be_present}
      it {expect{post :create, word: FactoryGirl.attributes_for(Word)}.to change(Word, :count).by(1)}
    end

    context "fail with invalid attributes" do
      before {post :create, word: {content: ""}}
      it {expect(response).to render_template :new}
      it {expect(flash[:danger]).to be_present}
    end
  end

  describe "GET #show" do
    before {get :show, id: @word.id}
    it {expect(response).to render_template :show}
  end

  describe "DELETE #destroy" do
    it "should response index page after delete word" do
      delete :destroy, id: @word.id
      expect(response).to redirect_to admin_words_url
    end
  end
end
