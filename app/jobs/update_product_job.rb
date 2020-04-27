class UpdateProductJob < ApplicationJob
  queue_as :default

  def perform(product)
    url = "https://canifa.com/catalog/product/view/id/#{product.code}"
    data = Nokogiri::HTML(open(url))

    category_name = data.css(".breadcrumbs").css("ul").css("li")[1].css("a").text

    hash = Hash.new
    Category.all.each do |item|
      if item.name.upcase.delete(" ") == category_name.upcase.delete(" ")
        hash["key"] = item.id
        hash["value"] = item.name
      end
    end

    if !hash["key"].nil?
      category = Category.find(hash["key"])
    else
      category = Category.create!(name: category_name)
    end

    product_info = data.css(".product-shop-content")
    product_name = product_info.css(".product-name").css("span").text
    product_price = product_info.css(".price").text
    product_description = product_info.css(".product-detail-tabs").css("#product-detail-tab-content-1").text.gsub(/\s+/, " ")

    product.update(name: product_name) if product.name.blank?
    product.update(price: product_price) if product.price.nil?
    product.update(description: product_description) if product.description.blank?
    product.update(category_id: category.id) if product.category.nil?

    image_doc = data.css("#product-image-gallery-thumb").css(".item")
    image_doc.css(".item").each do |img|
      img_url = img.css("img").attr("src").text
      Image.create!(:remote_image_url_url => img_url, :product_id => product.id)
    end

  end
end
