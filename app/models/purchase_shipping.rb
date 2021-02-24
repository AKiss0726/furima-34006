class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :zip, :from_id, :delivery_municipality, :delivery_street, :delivery_building, :tel, :item_id, :user_id, :token

  with_options presence: true do
    validates :zip, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :delivery_municipality, format: { with: /\A[ぁ-んァ-ヶ一-龥々]/, message: "is invalid. Input full-width characters." }
    validates :delivery_street
    validates :tel, format: { with: /\A\d{10}\z|\A\d{11}\z/ , message: "is invalid." }
    validates :token
  end

    validates :from_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shipping.create(zip: zip, from_id: from_id, delivery_municipality: delivery_municipality, delivery_street: delivery_street, delivery_building: delivery_building, tel: tel, purchase_id: purchase.id)
  end
end