class AddPermalinkToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :permalink, :string
  end
end
