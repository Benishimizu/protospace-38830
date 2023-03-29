class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

  end
  # ユーザーに関するshowアクションをコントローラーに定義しよう
      # users_controller.rbを作成し、そこへshowアクションを定義します。

      # コマンドを実行してコントローラーを作成しましょう
      # users_controller.rbを作成します。

      # ターミナル
      # # users_controllerと関連するファイルを作成
      # % rails g controller users
      # users_controller.rbを編集しましょう
      # showアクションで表示するのは、ログイン中ユーザーのマイページとなるため、
      # 必要な情報は「ニックネーム」と「ログイン中のユーザーのツイート投稿」の2つです。

      # それぞれを@nicknameと@tweetsというインスタンス変数に代入します。
      # usersコントローラーのshowアクションにインスタンス変数@userを定義した。
      # @user=
      # 且つ、Pathパラメータで送信されるID値で、Userモデルの特定のオブジェクトを取得するように記述し、それを@userに代入した
      #  = Tweet.find(params[:tweet_id])
        #form_withでビューファイルからコントローラーに値を送信する準備はできました。
          # 次は、コントローラー側で、送られてきた値（パラメーター）を受け取り、保存する処理を実装します。
          # has_manyのアソシエーションを組んでいる場合、親モデルのレコードに紐づく子モデルのインスタンスを生成することができます。
          # PicTweetを例にメソッドを使用しました。以下のコードの5行目に注目してください。

          # 【例】
            # def create
            #   # tweet_idから、特定のレコードを取得
            #   @tweet = Tweet.find(params[:tweet_id])
            #   # 特定のツイートに紐づくインスタンスを生成し、属性値を指定
            #   @comment = @tweet.comments.new(tweet_params)
            #   # インスタンスを保存
            #   @comment.save
            # end
          # @tweet.comments.new(tweet_params)では、直前で取得した@tweetに紐づくCommentモデルのインスタンスを生成しています。has_manyのアソシエーションを組んでいれば、親モデルのインスタンス.子モデルの複数形（小文字）.newという記述方法で、親モデルのインスタンスに紐づく子モデルのインスタンスを生成できます。

          # 以上をふまえて、フォームから送信された値をDBに保存する処理を記述
          # https://master.tech-camp.in/v2/curriculums/4762
          # users_controller.rbを編集しましょう
                # クリックされたユーザーのidから情報を取得して、ビューに受け渡します。
                # app/controllers/users_controller.rb
                  # class UsersController < ApplicationController
                  #   def show
                  #     user = User.find(params[:id])
                  #     @nickname = user.nickname
                  #     @tweets = user.tweets
                  #   end
                  # end
                # ツイートの右下に表示されるユーザー名をクリックすることで、送られたidをparamsで取得し、そのユーザーのレコードを変数userに代入しています。
                # この変数を利用して、各インスタンス変数ではcurrent_userを変数userに変えました。
                
                # その上で、@nicknameでは、ユーザーのnicknameを取り出しています。
                
                # アソシエーションを利用しuser.tweetsとすることで、そのユーザーが投稿したツイートを取得して、@tweetsに代入しています。
          # https://master.tech-camp.in/v2/curriculums/4223#22
      #     # 

end
