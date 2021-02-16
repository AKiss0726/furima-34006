class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :allocation
  belongs_to :from
  belongs_to :to_ship

  with_options presence: true do
    validates :item_name
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :category_id
    validates :condition_id
    validates :allocation_id
    validates :from_id
    validates :to_ship_id
    validates :description
    validates :image
  end

  with_options numericality { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :allocation_id
    validates :from_id
    validates :to_ship_id
  end

  validates :price, format: { with: /\A[0-9]+\z/ }
  
end
