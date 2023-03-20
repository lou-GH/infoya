class Comment < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :manufacturer, optional: true
  belongs_to :post

  validates :comment, presence: true, length:{maximum:160}

end
