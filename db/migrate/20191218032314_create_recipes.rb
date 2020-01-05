class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.references :user,              null:false, foreign_key: true
      t.string     :name,              null: false
      t.integer    :genre_id,          null: false
      t.integer    :difficulty_id,     null: false
      t.string     :servers,           null: false
      t.string     :cookingtime,       null: false
      t.string     :restingtime,       null: false
      t.string     :bakingtime,        null: false
      t.string     :bakingtemperature, null: false
      t.text       :instruments,       null: false
      t.text       :cookingpoint,      null: false
      t.text       :method,            null: false
      t.timestamps
    end
  end
end
