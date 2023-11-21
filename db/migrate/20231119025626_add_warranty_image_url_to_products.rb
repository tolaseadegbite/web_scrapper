class AddWarrantyImageUrlToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :warranty_image_url, :string
  end
end
