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
|patisserie_id|references|null: false, foreign_key: true|
|name|string|null: false|
|difficulty|string|null: false|
|cookingtime|string|null:false|
|bakingtime|string|null:false|
ingredients|text|null:false|
instruments|text|null:false|

### Association
- belongs_to :user
- has_many :comments
- belongs_to :patisserie
- has_many :recipe-images
- has_many :recipe-videos


## patisseriesテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|null: false|
|genre|integer|nul: false|

### Association
- has_many :recips


## recipe-imagesテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|null: false|
|image|text|

### Association
- belongs_to :recipe


## recipe-videosテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|references|null: false|
|video|text|

### Association
- belongs_to :recipe