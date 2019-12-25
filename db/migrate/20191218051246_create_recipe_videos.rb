class CreateRecipeVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_videos do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string     :video
      t.timestamps
    end
  end
end
