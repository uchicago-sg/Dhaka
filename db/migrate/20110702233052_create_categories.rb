class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :description, :null => false
      t.text :details, :null => false
      t.timestamps
    end
  end
end
