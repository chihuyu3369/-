class Public::PostController < ApplicationController

    #ユーザーのログイン状態を確かめる。indexはログインしてなくても閲覧可能にしてます。
    before_action :authenticate_user!, only: [:show, :create]

    def new
        @post = current_user.posts.new
    end

    def index
        @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    end

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
        @comment = current_user.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
        @post_tags = @post.tags
    end

    def create
        @post = current_user.posts.new(post_params)
        @post.user_id=current_user.id
         # 受け取った値を,で区切って配列にする
           tag_list=params[:post_content][:name].split(',')
      if @post.save
         @post.save_tag(tag_list)
        redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
      else
        redirect_back(fallback_location: root_path)  #同上
      end
    end

    private
  def post_params
      params.require(:post).permit(:post_photo, :post_content, :title)
  end

end
