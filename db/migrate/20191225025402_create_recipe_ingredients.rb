class CreateRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe,      null: false, foreign_key: true
      t.string     :ingredients, null:false
      t.string     :quantity,    null:false
      t.timestamps
    end
  end
end
