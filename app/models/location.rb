class Location < ApplicationRecord

  include JpPrefecture

  has_one_attached :location_id

end
