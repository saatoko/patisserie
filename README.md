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
- has_many :comments


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|recipe_id|references|null: false, foreign_key: true|
|text|text|null: false|

### Association
- belongs_to :user
- belongs_to :recipe


## recipesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|name|string|null: false|
|genre_id|integer|nul: false|
|difficulty_id|integer|null: false|
|servers|string|null: false|
|cookingtime|string|null: false|
|restingtime|string|null: false|
|bakingtime|string|null: false|
|bakingtemperature|string|null: false|
|instruments|text|null: false|
|cookingpoint|text|null: false|
|method|text|null: false|


### Association
- belongs_to :user
- has_many :comments
- has_many :recipe_images
- has_one :recipe_video
- has_many :recipe_methods
- has_many :recipe_ingredients

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