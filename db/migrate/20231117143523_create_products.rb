class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.string :image_url
      t.integer :old_price
      t.integer :current_price
      t.integer :reviews_count

      t.timestamps
    end
  end
end
