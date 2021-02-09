# テーブル設計

## users テーブル

| Column                | Type       | Options     |
| --------------------- | ---------- | ----------- |
| nickname              | string     | null: false |
| email                 | string     | null: false |
| password              | string     | null: false |
| family_name           | string     | null: false |
| first_name            | string     | null: false |
| furigana_family_name  | string     | null: false |
| furigana_first_name   | string     | null: false |
| birthday              | integer    | null: false |
| prefectures           | string     | null: false |
| municipality          | string     | null: false |
| street                | string     | null: false |
| building              | string     |             |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item_name | string     | null: false                    |
| category  | string     | null: false                    |
| price     | integer    | null: false                    |
| user      | references | null: false, foreign_key: true |

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
- has_many :shippings
- has_one :item

## shippings テーブル

| Column                 | Type       | Options     |
| ---------------------- | ---------- | ----------- |
| delivery_prefectures   | string     | null: false |
| delivery_municipality  | string     | null: false |
| delivery_street        | string     | null: false |
| delivery_building      | string     |             |

### Association

- belongs_to :purchase