class Genre < ApplicationRecord

  # genre_tagsと関連付けを行い、genre_tagsのテーブルを通しpostsテーブルと関連づけ
  #   dependent: :destroyをつけることで、タグが削除された時にタグの関連付けを削除する
  has_many :genre_tags, dependent: :destroy, foreign_key: 'genre_id'
  # postsのアソシエーション
  #   Genre.postsとすれば、タグに紐付けられたPostを取得可能になる
  has_many :posts, through: :genre_tags

  validates :name, uniqueness: true


end
