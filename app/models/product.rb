class Product < ApplicationRecord
    has_many :categories, through: :product_categories
    has_many :product_categories
    has_many :orders
end
