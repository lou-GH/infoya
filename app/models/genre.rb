class Genre < ApplicationRecord

  # 保存される直前に実行される
  before_save :downcase_genre_name
  # genre_tagsと関連付けを行い、genre_tagsのテーブルを通しpostsテーブルと関連づけ
  #   dependent: :destroyをつけることで、タグが削除された時にタグの関連付けを削除する
  has_many :genre_tags, dependent: :destroy, foreign_key: 'genre_id'
  # postsのアソシエーション
  #   Genre.postsとすれば、タグに紐付けられたPostを取得可能になる
  has_many :posts, through: :genre_tags

  validates :genre_name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "genre_name", "id", "updated_at"]
  end

private

  # タグ名を小文字に変換
  def downcase_genre_name
    self.genre_name.downcase!
  end

end
