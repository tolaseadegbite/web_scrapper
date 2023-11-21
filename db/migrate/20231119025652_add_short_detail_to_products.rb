class AddShortDetailToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :short_detail, :text
  end
end
