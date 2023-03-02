class Genre < ApplicationRecord

  has_many :genre_tags, dependent: :destroy, foreign_key: 'genre_id'
  has_many :posts, through: :genre_tags

end
