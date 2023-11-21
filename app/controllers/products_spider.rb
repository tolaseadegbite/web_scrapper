require 'tanakai'
require 'mechanize'

class ProductsSpider < Tanakai::Base
  @name = 'products_spider'
  @engine = :mechanize
  # @start_urls = [url]

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    @base_uri = url
    # response = browser.current_response

    # response.css('.item.product.product-item').each do |app|

    browser.visit(@base_uri)
    app_response = browser.current_response

    item = {}
    item[:url] = @base_uri
    item[:name] = app_response.css('.page-title')&.text&.squish
    item[:reviews_count] = app_response.at_css('.action.view')&.text&.delete('^0-9').to_i
    item[:image_url] = app_response.css('.gallery-placeholder img').map{ |link| link['src'] }
    # item[:warranty_text] = app.css('.cart-care-box strong')&.text
    item[:warranty_image_url] = app_response.css('.cart-care-image img').map{ |link| link['src'] }
    item[:old_price] = app_response.css('.price')[1]&.text&.squish&.delete('^0-9').to_i
    item[:current_price] = app_response.css('.price')[0]&.text&.squish&.delete('^0-9').to_i
    item[:short_detail] = app_response.css('.product.attribute.overview .value p').map{ |element| element.inner_html }.join
    item[:long_detail] = app_response.css('.product.attribute.description .value').map{ |element| element.inner_html }.join
    # item[:image_url] = app.css('.product-image-photo').map{ |link| link['src'] }.join

    # save_to "products_url.json", item, format: :pretty_json, position: false
    Product.where(item).first_or_create
    # end

  end

  # ProductsSpider.crawl!  
end