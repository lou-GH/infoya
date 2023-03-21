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

  # def save_genre(sent_genres)
  def save_genres(genre_list)
    # タグをスペース区切りで分割し配列にする
    #   連続した空白も対応するので、最後の“+”がポイント
    # genre_list = genres.split(/[[:blank:]]+/)
    # genre_list = genres.split(nil)
    # genre_list = params[:post][:genre_name].split(nil)
    # 自分自身に関連づいたタグを取得する
    current_genres = self.genres.pluck(:genre_name) unless self.genres.nil?
    # (1) 元々自分に紐付いていたタグと投稿されたタグの差分を抽出
    #   -- 記事更新時に削除されたタグ
    old_genres = current_genres - genre_list
    # (2) 投稿されたタグと元々自分に紐付いていたタグの差分を抽出
    #   -- 新規に追加されたタグ
    new_genres = genre_list - current_genres

    p current_genres

    # genre_tagsテーブルから、(1)のタグを削除
    #   genresテーブルから該当のタグを探し出して削除する
    old_genres.each do |old|
      # genre_tagsテーブルにあるpost_idとgenre_idを削除
      #   後続のfind_byでgenre_idを検索
      self.genres.delete Genre.find_by(genre_name: old)
    end

    # genresテーブルから(2)のタグを探して、genre_tagsテーブルにgenre_idを追加する
    new_genres.each do |new|
      # 条件のレコードを初めの1件を取得し1件もなければ作成する
      # find_or_create_by : https://railsdoc.com/page/find_or_create_by
      new_post_genre = Genre.find_or_create_by(genre_name: new)
      # genre_tagsテーブルにpost_idとgenre_idを保存
      #   配列追加のようにレコードを渡すことで新規レコード作成が可能
      self.genres << new_post_genre
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
