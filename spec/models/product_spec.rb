require 'rails_helper'

RSpec.describe Product, type: :model do
  context "associations" do
    it { should belong_to(:category) }
    it { should have_many(:images) }
    it { should have_many(:order_items) }
  end

  context "validates" do
    it { should validate_presence_of(:code) }
  end

  context "accep_nested" do
    it { should accept_nested_attributes_for(:images) }
  end

end
