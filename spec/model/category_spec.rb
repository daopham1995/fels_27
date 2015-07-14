require "rails_helper"

RSpec.describe Category, type: :model do
  context "#has many" do
    let(:category) {FactoryGirl.create :category}
    it {expect(category).to have_many(:lessons)}
    it {expect(category).to have_many(:words)}
  end

  context "#category name" do
    before do
      @category = FactoryGirl.create :category
    end

    it "should be invalid when empty" do
      @category.cat_name = nil
      expect(@category).not_to be_valid
    end

    it "should be uniqueness" do
      @category.cat_name = "N3"
      @category.save
      other = FactoryGirl.build :category, cat_name: "N3"
      expect(other).not_to be_valid
    end
  end
end
