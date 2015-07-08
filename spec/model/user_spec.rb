require "rails_helper"

RSpec.describe User, type: :model do
  describe "test associations" do
    let(:user) {FactoryGirl.build :user}
    context "#has_many" do
      it {expect(user).to have_many(:lessons)}
    end
  end

  before do
    @user = FactoryGirl.build :user, admin: "true"
  end

  context "User" do
    it "should be valid" do
      expect(@user).to be_valid
    end

    it "when user is an admin" do
      expect(@user.admin).to eql(true)
    end
  end

  context "Username" do
    subject {FactoryGirl.create :user}
    before {subject.username = nil}
    it {is_expected.to have(1).error_on(:username)}
  end

  context "Email" do
    it "would be invalid when empty" do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it "would be invalid when wrong format" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end      
    end

    it "should be uniqueness" do
      @user.email = "example@gmail.com"
      @user.save
      other = FactoryGirl.build :user, email: "example@gmail.com"
      expect(other).not_to be_valid
    end
  end

  context "Password" do
    it "would be invalid when empty" do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).not_to be_valid
    end

    it "would be invalid when password is different from password_confirmation" do
      @user.password = "12345678"
      @user.password_confirmation = "abcdef"
      expect(@user).not_to be_valid
    end
  end
end
