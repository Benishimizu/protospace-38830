class CommentsController < ApplicationController

  def create
   @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype.id)
      # (@comment.prototype)でも可
      # pictweet, show. htmlの　 ” @tweet.user.nickname”の書き方と同じなので参照可能

    # redirect_to "/tweets/#{comment.tweet.id}"  # コメントと結びつくツイートの詳細画面に遷移する:
        # 書き方としては悪くないが仕様が変わった時に更新が何回も必要になるため上記の{}を使わない方が簡単
        # #{}式展開：
        # redirect_toの後には、ルーティングのURLやPrefixを記述することで、そのアクションを実行できます。
        # tweetsコントローラーのshowアクションを実行するには、ツイートのidが必要です。
        # そのため、ストロングパラメーターを用いた上で変数commentに代入します。
        # リダイレクト先の指定には、アソシエーションを利用して、commentと結びつくツイートのidを記述しています。
    # 

    else
      @prototype = @comment.prototype
      # @comments = @prototype.comments
      # @prototype = @comment.prototype
        # // RENDERはviewに関連するからSHOWアクションと同じ定義をする必要がある
        # Prototypes_ControllerのSHOW を参考にすると@prototype と@commentsが定義されている
        # なので同様にここでも２つを定義する必要がある
        # レコードがほしいから@comment.prototype.idではなく@comment.prototype　になる
        # @comment.prototypeなのは　prototypeでコメントしたもののその詳細ページに戻りたいから
        # @comments = @prototype.comments
      # 
      render "prototypes/show"
      # render :showだと現段階ではCOMMENTSのSHOWが定義されていないため、prototypesのフォルダを指定して　SHOWアクションが必要になる
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
# https://master.tech-camp.in/v2/curriculums/4227#8
end
