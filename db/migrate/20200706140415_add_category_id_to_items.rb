class AddCategoryIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :category, foreign_key: true, null: false
  end
end
