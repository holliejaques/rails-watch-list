class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks, dependent: :destroy
  validates :name, uniqueness: true, presence: true
  has_one_attached :photo
end
