class Api::BlockUsersController < ApplicationController
  before_action :authenticate, only: %i[create destroy]
  def create
    BlockUser.create!(block_user_id: current_user.id, blocked_id: target_params[:id])
    # debugger
    
  end

  def destroy
    block_user = BlockUser.find_by( block_user_id: current_user.id, blocked_id: params[:blocked_id] )
    block_user.destroy!
    # debugger
  end

  private

  def target_params
    params.require(:target).permit(:id)
  end

end
