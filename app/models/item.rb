class Item < ApplicationRecord
    has_many :comments
    has_one_attached :picture
end
