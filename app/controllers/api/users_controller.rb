class Api::UsersController < ApplicationController
  before_action :authenticate, only: %i[index followings followers mates applicants muting_users]

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
    # users = users.page(params[:page]).per(PAGINATES_PAR)
    users = users.includes(:followings, :followers)
                  .page(params[:page]).per(PAGINATES_PAR)
    # debugger
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
  end

  def followings
    user = User.find(params[:id])
    user_followings = user.followings
    render json: user_followings, each_serializer: FollowingSerializer
  end

  def followers
    user = User.find(params[:id])
    user_followers = user.followers
    render json: user_followers, each_serializer: FollowingSerializer
  end

  def mates
    search_mates_form = SearchMatesForm.new(search_params)
    users = search_mates_form.search(params[:id]).order(name: :asc)
    # debugger
    users = users.includes(:followings, :followers)
                  .page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
  end

  def applicants
    search_applicants_form = SearchApplicantsForm.new(search_params)
    applicants = search_applicants_form.search(params[:id]).order(name: :asc)
    # debugger
    users = applicants.includes(:followings, :followers)
                            .page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
    # debugger
  end

  def muting_users
    search_muting_users_form = SearchMutingUsersForm.new(search_params)
    muting_users = search_muting_users_form.search(params[:id]).order(name: :asc)
    # debugger
    users = muting_users.includes(:followings, :followers)
                            .page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
    # debugger
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
