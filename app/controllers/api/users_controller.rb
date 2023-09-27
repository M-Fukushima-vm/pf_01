class Api::UsersController < ApplicationController
  before_action :authenticate, only: %i[index followings followers mates muting_users blocking_users]

  PAGINATES_PAR = 8

  def create
    user = User.new(user_params)
    user.save!
    render json: user, serializer: UserSerializer
  end

  def index
    # users = User.where.not(id: [ 1..4, current_user.id ]).order(name: :asc)
    search_users_form = SearchUsersForm.new(search_params)
    users = search_users_form.search( current_user.id )
                              .where.not(id: [ 1..4, current_user&.id ]).order(name: :asc)
    # users = users.page(params[:page]).per(PAGINATES_PAR)
    users = users.page(params[:page]).per(PAGINATES_PAR)
    # debugger
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
  end

  def followings
    user = User.with_attached_avatar.includes(:followings).find(params[:id])
    users = user.followings
    render json: users, each_serializer: FollowingSerializer
  end

  def followers
    search_followers_form = SearchFollowersForm.new(search_params)
    users = search_followers_form.search(params[:id]).order(name: :asc)
    # debugger
    users = users.page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
  end

  def mates
    search_mates_form = SearchMatesForm.new(search_params)
    users = search_mates_form.search(params[:id]).order(name: :asc)
    # debugger
    users = users.page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
  end

  def muting_users
    search_muting_users_form = SearchMutingUsersForm.new(search_params)
    muting_users = search_muting_users_form.search(params[:id]).order(name: :asc)
    # debugger
    users = muting_users.page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
    # debugger
  end

  def blocking_users
    search_blocking_users_form = SearchBlockingUsersForm.new(search_params)
    blocking_users = search_blocking_users_form.search(params[:id]).order(name: :asc)
    # debugger
    users = blocking_users.page(params[:page]).per(PAGINATES_PAR)
    render json: users, each_serializer: OtherUserSerializer,
                        meta: {
                          total_pages: users.total_pages,
                          total_count: users.total_count,
                          current_page: users.current_page
                        }
    # debugger
  end

  def seen_followers
    user = User.includes(:seen_followers).find(params[:id])
    users = user.seen_followers
    render json: users, each_serializer: FollowingSerializer
    # debugger
  end

	def hackmd_account
		# debugger
		hackmd_account = HackmdAccount.find_by(user_id: current_user.id)
		if hackmd_account.present?
			render json: hackmd_account, serializer: HackmdAccountSerializer
		else
			render json: { error: { messages: ['apiキーは登録されていません'] } },
      status: 404
		end
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
