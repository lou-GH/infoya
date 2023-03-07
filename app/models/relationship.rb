class Relationship < ApplicationRecord

  belongs_to :manufacturer
  belongs_to :user

end
