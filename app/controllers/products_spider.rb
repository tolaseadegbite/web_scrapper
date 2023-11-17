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
    response = browser.current_response

    response.css('.item.product.product-item').each do |app|

      browser.visit(@base_uri)
      app_response = browser.current_response

      item = {}
      item[:url] = app.css('.product-item-link').map{ |link| link['href'] }.join
      item[:name] = app.css('.product-item-link')&.text&.squish
      item[:image_url] = app.css('.product-image-photo').map{ |link| link['src'] }.join
      item[:old_price] = app.css('.price')[1]&.text&.squish&.delete('^0-9').to_i
      item[:current_price] = app.css('.price')[0]&.text&.squish&.delete('^0-9').to_i
      item[:reviews_count] = app.at_css('.action.view')&.text&.delete('^0-9').to_i

      # save_to "products_url.json", item, format: :pretty_json, position: false
      Product.where(item).first_or_create
    end

  end

  # ProductsSpider.crawl!  
end