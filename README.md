# 概要
テックキャンプの最終課題にて作成したアプリケーションを紹介します。

# アプリケーション情報
## アプリケーション概要
5人のチームでフリーマーケットのアプリケーションを作成致しました。
### 接続先情報
* URL http://18.181.141.10
* ID/Pass
  * ID: admin78a
  * Pass: 78a12345
### テスト用アカウント等
* 購入者用
  * メールアドレス: buyer@gmail.com
  * パスワード: buyer1234
* 購入用カード情報
  * 番号： 4242424242424242
  * 期限： 12/24
  * セキュリティコード：123
* 出品者用
  * メールアドレス名: seller@gmail.com
  * パスワード: seller1234
### Githubリポジトリ
https://github.com/Koto-Lenlu/fleamarket_sample_78a

# 開発状況
## 開発環境
Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code
## 開発期間と平均作業時間
開発期間：6/30~7/21の平日(16日間)\
1日あたりの平均作業時間：9
## 開発体制
人数：5\
アジャイル型開発（スクラム）\
Trelloによるタスク管理

# 動作確認方法
Chromeの最新版を利用してアクセスしてください。\
ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続ください。\
接続先およびログイン情報については、上記の通りです。\
同時に複数の方がログインしている場合に、ログインできない可能性がございます。\
テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品\
確認後、ログアウト処理をお願いします。


# 78期 aチーム フリマアプリ DB設計

# usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|nickname|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|

### Association
- has_one :address dependent: :destroy
- has_one :credit_card dependent: :destroy
- has_many :comments dependent: :destroy
- has_many :messages, dependent: :destroy
- has_many :items, through: :likes, source: :item


# itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
|condition_id|integer|null: false|
|shipping_charge_id|integer|null: false|
|shipping_day_id|integer|null: false|
|prefecture_id|integer|null: false|
|brand|string||
|seller|references|null: false|
|buyer|references||
|category|references|null: false|
|user|references|foreign_key: true|
|likes_count|integer||

### Association
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user
- has_many :item_images, dependent: :destroy
- has_many :messages, dependent: :destroy
- belongs_to :user, optional: true
- belongs_to :category
- belongs_to :seller, class_name: "User", foreign_key: 'seller_id'
- belongs_to :buyer, class_name: "User", foreign_key: 'buyer_id'
- belongs_to_active_hash :shipping_charge
- belongs_to_active_hash :shipping_day
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :condition

# addressテーブル
|Column|Type|Options|
|------|----|-------|
|address_family_name|string|null: false|
|address_first_name|string|null: false|
|address_family_name_kana|string|null: false|
|address_first_name_kana|string|null: false|
|zipcode|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building|string||
|phone_number|string||
|user|references||
### Association
- belongs_to :user, :optional	true

# credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user

# shipping_chargesテーブル
|Column|Type|Options|
|------|----|-------|
|shipping_charge|string|null: false|
### Association
- has_many :items

# shipping_fromテーブル
|Column|Type|Options|
|------|----|-------|
|shipping_from|string|null: false|
### Association
- has_many :items

# shipping_daysテーブル
|Column|Type|Options|
|------|----|-------|
|shipping_days|string|null: false|
### Association
- has_many :items

# categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|index: true|
### Association
- has_many :items

# item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item|references|foreign_key: true|
### Association
- belongs_to :item

# messagesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|
|message|string|null: false|
|delete|integer|default: 0|
### Association
- belongs_to :user
- belongs_to :item

# sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|user|references|foreign_key: true|
### Association
- belongs_to :user, optional: true

# likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|item_id|integer||
### Association
- belongs_to :item, counter_cache: :likes_count
- belongs_to :user
