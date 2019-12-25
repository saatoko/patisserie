class CreateRecipeMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_methods do |t|
      t.references :recipe, null: false, foreign_key: true
      t.text       :method, null:false
      t.timestamps
    end
  end
end
