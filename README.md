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
