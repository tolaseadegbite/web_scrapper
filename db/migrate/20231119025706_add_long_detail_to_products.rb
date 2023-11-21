class AddLongDetailToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :long_detail, :text
  end
end
