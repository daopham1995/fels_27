require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  before do
    @admin = FactoryGirl.create :user, admin: true
    subject.send :log_in, @admin
    @category = FactoryGirl.create :category
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
      before {post :create, category: FactoryGirl.attributes_for(Category)}
      it {expect(response).to redirect_to admin_categories_path}
      it {expect(flash[:success]).to be_present}
      it {expect{post :create, category: FactoryGirl.attributes_for(Category)}.to change(Category, :count).by(1)}
    end

    context "fail with invalid attributes" do
      before {post :create, category: {cate_name: ""}}
      it {expect(response).to render_template :new}
      it {expect(flash[:danger]).to be_present}
    end
  end

  describe "PUT #update" do
    context "success with valid attributes" do
      before {put :update, id: @category, category: FactoryGirl.attributes_for(:category)}
      it {expect(response).to redirect_to admin_categories_url}
      it {expect(flash[:success]).to be_present}
    end

    context "fail with invalid attributes" do
      before {put :update, id: @category, category: {cat_name: ""}}
      it {expect(response).to render_template :edit}
    end
  end
end
