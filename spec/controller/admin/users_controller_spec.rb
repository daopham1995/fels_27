require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  before do
    @admin = FactoryGirl.create :user, admin: true
    @member = FactoryGirl.create :user, admin: false
    subject.send :log_in, @admin
  end

  describe "GET #index" do
    context "admin render template index success" do
      before {get :index}
      it {expect(response).to render_template :index}
    end

    context "member access to template index of admin" do
      before do
        subject.send :log_out
        subject.send :log_in, @member
        get :index
      end
      it {expect(response).to redirect_to :root}
      it {expect(flash[:danger]).to eq "U dont have permission to access this page."}
    end
  end

  describe "GET #show" do
    before {get :show, id: @admin.id}
    it {expect(response).to render_template :show}
  end

  describe "GET #edit" do
    before {get :edit, id: @admin.id}
    it {expect(response).to render_template :edit}
  end

  describe "PUT #update" do
    context "success with valid attributes" do
      before {put :update, id: @admin, user: FactoryGirl.attributes_for(:user)}
      it {expect(response).to redirect_to admin_user_url(@admin.id)}
      it {expect(flash[:success]).to be_present}
    end

    context "fail with invalid attributes" do
      before {put :update, id: @admin, user: {username: ""}}
      it {expect(response).to render_template :edit}
    end
  end

  describe "DELETE #destroy" do
    it "should response index page after delete user" do
      delete :destroy, id: @member.id
      expect(response).to redirect_to admin_users_url
    end
  end
end
