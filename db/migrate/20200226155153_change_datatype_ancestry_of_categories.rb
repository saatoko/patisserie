class ChangeDatatypeAncestryOfCategories < ActiveRecord::Migration[5.0]
  def up 
    # 環境ごとにマイグレーションを分ける
    if Rails.env.production?
      # 本番環境はusingオプションを追加
      change_column :categories, :ancestry, 'integer USING CAST(ancestry AS integer)'
    else
      change_column :categories, :ancestry, :integer
    end
  end 

  def down 
    change_column :categories, :ancestry, :string
  end 
end
