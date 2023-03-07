class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
        # :recoverable, :rememberable, :validatable

  include JpPrefecture

  has_one_attached :user_icon

  has_many :comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :manufacturers, dependent: :destroy

end
