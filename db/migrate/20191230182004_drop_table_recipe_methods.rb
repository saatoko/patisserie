class DropTableRecipeMethods < ActiveRecord::Migration[5.0]
  def change
    drop_table :recipe_methods
  end
end
