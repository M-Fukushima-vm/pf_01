class Api::MemosController < ApplicationController
	before_action :authenticate, only: %i[create update destroy]

	PAGINATES_PAR = 8

	def index
		# debugger
		search_memos_form = SearchMemosForm.new(search_params)
		memos = search_memos_form.search( current_user.id ).order(updated_at: :desc)
		memos = memos.page(params[:page]).per(PAGINATES_PAR)
		render json: memos, each_serializer: MemoSerializer,
                        meta: {
                          total_pages: memos.total_pages,
                          total_count: memos.total_count,
                          current_page: memos.current_page
                        }
	end

	def create
		# debugger
		memo =	Memo.create!(
							title: target_params[:title],
							intro: target_params[:intro],
							user_id: current_user.id,
							content: target_params[:content],
							# note_shortId: target_params[:note_shortId],
							# note_title: target_params[:note_title],
							# note_content: target_params[:note_content]
						)
		render json: memo, serializer: MemoSerializer
		# debugger
	end

	def update
		# debugger
		memo = current_user.memos.find(params[:id])
		memo.update(target_params)
		render json: memo, serializer: MemoSerializer
		# debugger
	end


	def destroy
		# debugger
		memo = current_user.memos.find(params[:id])
		memo.destroy!
		# render json: memo, serializer: MemoSerializer
		# debugger
	end

	private

	def target_params
		params.require(:memo).permit(:id, :title, :intro, :content)
	end

	def search_params
    # 送るパラメーターをqハッシュでまとめ
    # params[:q] が nil だったら、nil。あれば、以降を実行
    params[:q]&.permit(:title)
  end

end
