class UpdateProductJob < ApplicationJob
  queue_as :default

  def perform(product)
    url = "https://canifa.com/catalog/product/view/id/#{product.code}"
    data = Nokogiri::HTML(open(url))
    product_info = data.css(".product-shop-content")
    product_name = product_info.css(".product-name").css("span").text
    product_price = product_info.css(".price").text
    product_description = product_info.css(".product-detail-tabs").css("#product-detail-tab-content-1").text.gsub(/\s+/, " ")

    product.update(name: product_name, price: product_price, description: product_description)
  end
end
