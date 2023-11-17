json.extract! product, :id, :name, :price, :old_price, :discount, :express_shipping, :created_at, :updated_at
json.url product_url(product, format: :json)
