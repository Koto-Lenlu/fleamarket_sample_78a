class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :user_id, :name, :introduction, :condition, :price, :shipping_charges, :shipping_from, :shipping_day, presence: true
  validates :image, presence: true
  validates :price, :numericality => { :greater_than => 299 }
  validates :price, :numericality => { :less_than => 9999999 }

  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
  
  belongs_to :user
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
end
