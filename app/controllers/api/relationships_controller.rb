class Api::RelationshipsController < ApplicationController
  before_action :authenticate, only: %i[create destroy]
  def create
    Relationship.create!(follower_id: current_user.id, followed_id: target_params[:id])
  end
  
  def destroy
    # debugger
    relationship = Relationship.find_by( follower_id: current_user.id, followed_id: params[:followed_id] )
    relationship.destroy!
  end

  private

  def target_params
    params.require(:target).permit(:id)
  end


end
