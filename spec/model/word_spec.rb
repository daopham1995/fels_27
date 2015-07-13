require "rails_helper"

RSpec.describe Word, type: :model do
  describe "test associations" do
    let(:word) {FactoryGirl.build :word}
    context "#has many" do
      it {expect(word).to have_many(:lesson_words)}
      it {expect(word).to have_many(:lessons).through(:lesson_words)}
      it {expect(word).to have_many(:answers)}
    end

    context "#belong to" do
      it {expect(word).to belong_to(:category)}
    end
  end

  describe "test validate" do
    subject {FactoryGirl.create :word}
    before {subject.content = nil}
    it {is_expected.to have(1).error_on(:content)}
  end
end
