# アプリ名
  BonBon♡SWEETS

## このアプリの説明
- お菓子好きのためのレシピの投稿、閲覧アプリを作成しました。

### ユーザー機能
- 新規登録, ログイン(レシピを投稿したテストユーザーからログインができます。), ログアウト機能

### レシピ機能
- ログイン後、レシピの投稿、投稿したレシピの編集と削除機能

### カテゴリー機能
- カテゴリーからのレシピ検索、レシピ閲覧機能

### いいね機能
- ログイン後、レシピにいいねを行えるようになります。
- 未ログイン時は、いいね数の閲覧機能



# 開発環境
|言語|バージョン|
|----|----------|
|Ruby on Rails|Rails 5.0.7.2|
|Ruby|ruby 2.5.7|
|jQuery||
|HTML|Haml記法|
|CSS|SCSS記法|

## データベース
- 開発環境、本番環境とも、mysql2を使用

### 使用したGem
- gem 'devise'
- gem 'haml-rails'
- gem 'sassc-rails'
- gem 'pry-rails'
- gem 'font-awesome-rails'
- gem 'carrierwave'
- gem 'mini_magick'
- gem 'fog-aws'
- gem 'active_hash'
- gem 'seed-fu'
- gem 'owlcarousel-rails'
- gem 'jquery-rails'
- gem 'nested_form_fields'
- gem 'ancestry'
- gem 'kaminari'
- gem 'dotenv-rails'
- gem 'mysql2'



# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|gender_id|integer|null: false|
|profession_id|integer|null: false|
|password|string|null: false|
|profile|text|null: false|

### Association
- has_many :recipes
- has_many :votes


## recipesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|name|string|null: false|
|difficulty_id|integer|null: false|
|servers|string|null: false|
|cookingtime|string|null: false|
|restingtime|string|null: false|
|bakingtime|string|null: false|
|bakingtemperature|string|null: false|
|instruments|text|null: false|
|cookingpoint|text|null: false|
|method|text|null: false|
|votes_count|integer|null: false|default: 0|

### Association
- belongs_to :user
- belongs_to :category
- has_many :recipe_images
- has_one :recipe_video
- has_many :recipe_methods
- has_many :recipe_ingredients
- has_many :votes


## recipe_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|null: false, foreign_key: true|
|image|string|null: false|

### Association
- belongs_to :recipe


## recipe_videosテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|foreign_key: true|
|video|string|
|description|text|

### Association
- belongs_to :recipe


## recipe_ingredientsテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|null: false, foreign_key: true|
|ingredients|string|null: false|
|quantity|string|null: false|

### Association
- belongs_to :recipe


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|

### Association
- has_many :recipes
- belongs_to :parent, class_name: :Category
- has_many :children, class_name: :Category, foreign_key: :ancestry


## votesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|recipe_id|references|null: false, foreign_key: true|

### Association
- belongs_to :recipe, counter_cache: :votes_count
- belongs_to :user
add_index :votes, [:user_id, :recipe_id], unique: true
