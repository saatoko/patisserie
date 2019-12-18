# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|gender|integer|null: false|
|profession|integer|null: false|
|password|string|null: false|


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
|bakingtime|string|null: false|
|bakingtemperature|string|null: false|
|ingredients|text|null: false|
|instruments|text|null: false|
|method|text|null: false|


### Association
- belongs_to :user
- has_many :comments
- has_many :recipe-images
- has_many :recipe-videos


## recipe_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|null: false|
|image|string|

### Association
- belongs_to :recipe


## recipe_videosテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|null: false|
|video|text|

### Association
- belongs_to :recipe