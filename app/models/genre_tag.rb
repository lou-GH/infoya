class GenreTag < ApplicationRecord

  # genre_tagsテーブルは、postsテーブルとgenresテーブルに属している
  belongs_to :post
  belongs_to :genre

  validates :post_id, presence: true
  validates :genre_id, presence: true

  delegate :persisted?, to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end


  def save(genre_list)
    post = Post.create(name: name)
    genre_list.each do |new_genre|
      post_genre = Genre.find_or_create_by(genrename: new_genre)
      post.genres << post_genre
    end

    GenreTag.create(post_id: post.id, genre_id: genre_id)
  end

  def update(genre_list)
    ActiveRecord::Base.transaction do
      # @post = Post.where(id: post_id)
      @post.update(name: name)
      current_genres = @post.genres.pluck(:genrename) unless @post.genres.nil?
      old_genres = current_genres - genre_list
      new_genres = genre_list - current_genres

      old_genres.each do |old_name|
        @post.genres.delete Genre.find_by(tagname: old_name)
      end

      new_genres.each do |new_name|
        post_genre = Genre.find_or_create_by(tagname: new_name)
        @post.genres << post_genre
        genre_tag = GenreTag.where(post_id: @post.id, genre_id: post_genre.id).first_or_initialize
        genre_tag.update(post_id: @post.id, genre_id: post_genre.id)
      end
    end
  end

  def destroy
    form = Post.where(id: post_id)
    form.destroy
  end

  private

  attr_reader :post, :genre
  def default_attributes
    {
      name: post.name,
      genrename: post.genres.pluck(:genrename).join(',')
    }
  end

end
