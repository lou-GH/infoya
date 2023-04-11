class Location < ApplicationRecord

  include JpPrefecture

  belongs_to :manufacturer

  has_many :posts

  has_one_attached :location_image

  validates :location_image, presence: true
  validates :name, presence: true
  validates :prefecture, presence: true
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
  validates :introduction, presence: true

  def get_location_image(width, height)
    unless location_image.attached?
      location_image.attach(icon('fa-regular', 'image'))
    end
      location_image.variant(resize_to_limit: [width, height]).processed
  end

end
