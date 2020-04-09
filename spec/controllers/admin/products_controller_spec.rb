require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do

  context "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_success
    end
  end

  context 'GET #edit' do
    it 'returns a success response' do
      category = Category.create!(name: "Nu")
      product = Product.create!(name: 'Ao dai', price: 120, code: "123456", description: "hihi", category_id: category.id)
      get :edit, params: { id: product.to_param }
      expect(response).to be_success
    end
  end

end
