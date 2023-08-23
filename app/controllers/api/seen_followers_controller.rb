class Api::SeenFollowersController < ApplicationController


  def create
    SeenFollower.create!(looked_user_id: current_user.id, seen_follower_id: target_params[:id])
    # debugger
  end

  private

  def target_params
    params.require(:target).permit(:id)
  end

end
