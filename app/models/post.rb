class Post < ApplicationRecord

  belongs_to :manufacturer
  belongs_to :location

  has_one_attached :post_image

  # dependent: :destroyでPostが削除されると同時にPostとTagの関係が削除される
  has_many :genre_tags, dependent: :destroy
  # throughを利用して、tag_mapsを通してtagsとの関連付け(中間テーブル)
  #   Post.genresとすれば、Postに紐付けられたTagの取得が可能
  has_many :genres, through: :genre_tags
  has_many :comments, dependent: :destroy
  has_many :comment_manufacturers, through: :comments, source: :manufacturer
  has_many :comment_users, through: :comments, source: :user
  has_many :notifications, dependent: :destroy


  validates :post_image, presence: true
  validates :introduction, presence: true,
    length: { maximum: 200 }
  # validates :genre_name, presence: true

# postコントローラで配列化した値を引数で受け取ります
  # def save_genre(sent_genres)
  def save_genres(genre_list)
   genre_list.each do |genre|
      # 受け取った値を小文字に変換して、DBを検索して存在しない場合は
      # find_genre に nil が代入され　nil となるのでタグの作成が始まる
      unless find_genre = Genre.find_by(genre_name: genre.downcase)
        begin
          # create メソッドでタグの作成
          # create! としているのは、保存が成功しても失敗してもオブジェクト
          # を返してしまうため、例外を発生させたい
          self.genres.create!(genre_name: genre)

        # 例外が発生すると rescue 内の処理が走り nil となるので
        # 値は保存されないで次の処理に進む
        rescue
          nil
        end
      else
            # DB にタグが存在した場合、中間テーブルに投稿とタグを紐付けている
        GenreTag.create!(post_id: self.id, genre_id: find_genre.id)
      end
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

  def create_notification_by(current_manufacturer)
    current_manufacturer.users.each do |user|
      notification = current_manufacturer.active_notifications.new(
        post_id: id,
        visited_id: user.id ,
        action: 'user'
      )
      if notification.visiter_id == notification.visited_id
            notification.checked = true
      end
      notification.save if notification.valid?
    end
  end


end
