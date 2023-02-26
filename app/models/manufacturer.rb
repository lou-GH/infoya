class Manufacturer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
        # :recoverable,

  include JpPrefecture

  has_one_attached :manufacturer_icon
  has_one_attached :location_image

end
