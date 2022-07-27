class Api::UsersController < ApplicationController
  PAGINATES_PAR = 8

  def create
    user = User.new(user_params)
    user.save!
    render json: user, serializer: UserSerializer
  end

  def index
    # users = User.where.not(id: [ 1, 2, current_user.id ]).order(name: :asc)
    search_users_form = SearchUsersForm.new(search_params)
    users = search_users_form.search
                              .where.not(id: [ 1, 2, current_user&.id ]).order(name: :asc)
    users = users.page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: UserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def search_params
    # 送るパラメーターをqハッシュでまとめ
    # params[:q] が nil だったら、nil。あれば、以降を実行
    params[:q]&.permit(:name)
  end
end
