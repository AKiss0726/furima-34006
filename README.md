# テーブル設計

## users テーブル

| Column                | Type       | Options                   |
| --------------------- | ---------- | ------------------------- |
| nickname              | string     | null: false               |
| email                 | string     | null: false, unique: true |
| encrypted_password    | string     | null: false               |
| family_name           | string     | null: false               |
| first_name            | string     | null: false               |
| furigana_family_name  | string     | null: false               |
| furigana_first_name   | string     | null: false               |
| birthday              | date       | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| item_name     | string     | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| allocation_id | integer    | null: false                    |
| from_id       | integer    | null: false                    |
| to_ship_id    | integer    | null: false                    |                
| description   | text       | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping

## shippings テーブル

| Column                  | Type       | Options                        |
| ----------------------- | ---------- | ------------------------------ |
| zip                     | string     | null: false                    |
| delivery_prefectures_id | integer    | null: false                    |
| delivery_municipality   | string     | null: false                    |
| delivery_street         | string     | null: false                    |
| delivery_building       | string     |                                |
| tel                     | string     | null: false                    |
| user                    | references | null: false, foreign_key: true |
| item                    | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase