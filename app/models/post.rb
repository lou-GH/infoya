class Post < ApplicationRecord

  belongs_to :manufacturer

  has_one_attached :post_image

  has_many :genre_tags, dependent: :destroy
  has_many :genres, through: :genre_tags

  def save_genre(sent_genres)
    current_genres = self.genres.pluck(:genre_name) unless self.genres.nil?
    old_genres = current_genres - sent_genres
    new_genres = sent_genres - current_genres

    old_genres.each do |old|
      self.post_genres.delete PostGenre.find_by(genre_name: old)
    end

    new_genres.each do |new|
      new_post_genre = PostGenre.find_or_create_by(genre_name: new)
      self.post_genres << new_post_genre
    end
  end


end
