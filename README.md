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

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| item_name    | string     | null: false                    |
| category     | string     | null: false                    |
| condition    | string     | null: false                    |
| allocation   | string     | null: false                    |
| from         | string     | null: false                    |
| to_ship      | string     | null: false                    |                
| description  | text       | null: false                    |
| price        | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

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
- has_many :shippings

## shippings テーブル

| Column                 | Type       | Options     |
| ---------------------- | ---------- | ----------- |
| delivery_prefectures   | string     | null: false |
| delivery_municipality  | string     | null: false |
| delivery_street        | string     | null: false |
| delivery_building      | string     |             |

### Association

- belongs_to :purchase