class Api::Me::AccountsController < ApplicationController
  before_action :authenticate, only: %i[update destroy]

  def update
    current_user.update(user_params)
    render json: current_user, serializer: UserSerializer
  end

  def destroy # アバター画像を剥がす
    current_user.avatar.detach # attached?の紐付けを切る
    render json: current_user, serializer: UserSerializer
    ActiveStorage::Blob.unattached.find_each(&:purge) # attached?で紐付いていないデータを削除
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar_name, :introduction, avatar: :data)
  end
end
