class Post < ApplicationRecord

  belongs_to :manufacturer

  has_one_attached :post_image

end
