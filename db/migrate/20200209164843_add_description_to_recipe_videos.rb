class AddDescriptionToRecipeVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :recipe_videos, :description, :text
  end
end
