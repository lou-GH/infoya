class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :manufacturer
  belongs_to :post

  validates :comment, presence: true, length:{maximum:160}

end
