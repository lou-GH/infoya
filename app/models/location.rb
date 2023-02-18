class Location < ApplicationRecord

  include JpPrefecture

  belongs_to :manufacturer

  has_one_attached :location_image

end
