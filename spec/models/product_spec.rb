require 'rails_helper'

RSpec.describe Product, type: :model do
  context "associations" do
    it { should belong_to(:category) }
    it { should have_many(:images) }
    it { should have_many(:order_items) }
  end

end
