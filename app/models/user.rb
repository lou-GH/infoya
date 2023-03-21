class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
        # :recoverable, :rememberable, :validatable

  include JpPrefecture

  has_one_attached :user_icon

  has_many :comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :manufacturers, through: :relationships
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # フォローをした、されたの関係
  # has_many :relationships, class_name: "Relationship", foreign_key: "manufacturer_id", dependent: :destroy

  # 一覧画面で使う
  # has_many :followings, through: :relationships, source: :manufacturer

  # フォローしたときの処理
  def follow(manufacturer_id)
    relationships.create(manufacturer_id: manufacturer_id)
  end
  # フォローを外すときの処理
  def unfollow(manufacturer_id)
    relationships.find_by(manufacturer_id: manufacturer_id).destroy
  end

  # フォローしているか判定
  def following?(manufacturer)
    # followings.include?(manufacturer)
    # [1,2].include?(1)
    relationships.pluck(:manufacturer_id).include?(manufacturer.id)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["account_name", "created_at", "email", "encrypted_password", "id", "introduction", "is_deleted", "prefecture", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end


end
