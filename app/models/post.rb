class Post < ApplicationRecord

  belongs_to :manufacturer

  has_one_attached :post_image

  has_many :genre_tags, dependent: :destroy
  has_many :genres, through: :genre_tags
  has_many :comments, dependent: :destroy

  validates :post_image, presence: true
  validates :introduction, presence: true,
    length: { maximum: 200 }

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

  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    post_image
  end

  def get_manufacturer_icon(width, height)
    unless manufacturer_icon.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      manufacturer_icon.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      manufacturer_icon.variant(resize_to_limit: [width, height]).processed
  end

end
