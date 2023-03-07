class Manufacturer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
        # :recoverable,

  include JpPrefecture

  has_one_attached :manufacturer_icon
  has_one_attached :location_image

  has_many :posts, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :users, dependent: :destroy

end
