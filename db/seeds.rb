# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'

url = "https://canifa.com/"
data = Nokogiri::HTML(open(url))
Category.delete_all
Product.delete_all
Image.delete_all
data.css(".ms-level0").take(2).each do |category|

  category_link = category.css("a").first.attr("href")
  category_name = category.css("a").first.text.gsub(/\s+/, " ")
  category = Category.create!(:name => category_name)
  category_doc = Nokogiri::HTML(open(category_link))

  category_doc.css(".product-item").take(10).each do |product|

    product_link = product.css(".product-info").css(".product-img").css("a").first.attr("href")
    product_code = product.css(".product-info").css(".product-img").attr("value").text
    product_html = Net::HTTP.get URI(product_link)
    product_doc = Nokogiri::HTML product_html
    product_info = product_doc.css(".product-shop-content")
    product_name = product_info.css(".product-name").css("span").text
    product_price = product_info.css(".price").text
    product_description = product_info.css(".product-detail-tabs").css("#product-detail-tab-content-1").text.gsub(/\s+/, " ")
    product = Product.create!(:name => product_name, :price => product_price,
                              :code => product_code, :description => product_description, :category_id => category.id)

    image_doc = product_doc.css("#product-image-gallery-thumb").css(".item")
    image_doc.css(".item").each do |img|
      img_url = img.css("img").attr("src").text
      Image.create!(:remote_image_url_url => img_url, :product_id => product.id)
    end

  end

end
