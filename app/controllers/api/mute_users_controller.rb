class Api::MuteUsersController < ApplicationController
  before_action :authenticate, only: %i[create destroy]
  def create
    MuteUser.create!(mute_user_id: current_user.id, muted_id: target_params[:id])
    # debugger
  end

  def destroy
    mute_user = MuteUser.find_by( mute_user_id: current_user.id, muted_id: params[:muted_id] )
    mute_user.destroy!
    # debugger
  end

  private

  def target_params
    params.require(:target).permit(:id)
  end

end
