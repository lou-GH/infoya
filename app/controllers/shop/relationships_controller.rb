class Shop::RelationshipsController < ApplicationController

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
