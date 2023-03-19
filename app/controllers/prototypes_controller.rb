class PrototypesController < ApplicationController


  def new
    @prototype = Prototype.new
  end
    # https://master.tech-camp.in/v2/curriculums/4217

  def create
# 
            # Memo
            # @room = Room.find(params[:room_id])  //NEST 何に対する何なのか（EXどの投稿に対するコメントなのか、どのルームに対するメッセージか）
            # @message = @room.messages.new(message_params)
# 
    @prototype = Prototype.new(prototype_params)
    #  @prototype = モデル名[今回はPrototype.rbの１番目の文章のPrototypeに該当].new(prototype_params[44行目のものに該当])
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end

#      #  redirect_toリダイレクト トゥーメソッド
      # Railsでリダイレクト処理を行う際に使用するメソッドです。
      # コントローラー等での処理が終わった後、アクションに対応するビューファイルを参照せずに、別ページへリダイレクトさせることができます。
 #        保存機能の実装
              # createクリエイトメソッド
              # モデルが使用できるActiveRecordメソッドのひとつです。

              # 保存のために、new→情報を記述→saveとしていたところが、createメソッドの引数を記述して実行するだけで保存できます。

              # 【例】
              # モデル.create(カラム名: 値)
              # パラメーター
              # リクエストに含まれてサーバーの外部から渡されるデータのことです。
              # URLに含めるパラメーターやフォームから送信されるパラメーターがあります。

              # Railsのコントローラーにたどり着くパラメーターは、paramsというハッシュのようなものに格納されて、届けられます。
              # //パラメーターとは、リクエストに含まれてサーバーの外部から渡されるデータのこと。

              #  paramsパラムス
              # 送られてきたパラメーターをハッシュのような構造で格納したものです。
              # フォームで送信されたデータもparamsの中に格納されてコントローラーで受け取られます。

              # text_fieldの後に記載されたキーでparamsに格納されています。
              # フォームで入力された情報の値は、params[:キー名]として取り出すことができます。

              # 例えば、「content」というキーで、「おはよう」というデータをフォームで送信したとします。
              # すると、paramsに{content: おはよう}といったハッシュのような構造で格納されます。
              # コントローラーでparams[:content]と記述すると、「おはよう」というデータを取り出すことができます。
              # // paramsとは、送られてきたパラメーターをハッシュのような構造で格納したもの。

              # https://master.tech-camp.in/v2/curriculums/5325
              # https://master.tech-camp.in/v2/curriculums/4223

              # ルーティングを設定しましょう
              # post 'posts' to: 'posts#create'とルーティングを設定することができた
              # form_withの情報とのつながり
              # 【例】app/views/posts/new.html.erb
              # <h1>新規投稿ページ</h1>
              # <%= form_with url: "/posts", method: :post, local: true do |form| %>
              #   <%= form.text_field :content %>
              #   <%= form.submit '投稿する' %>
              # <% end %>
              # ビューファイルを編集しましょう
              # create.html.erbは、投稿完了ページになるビューです。
              # トップページに戻るリンクも用意しておきましょう。

              # app/views/posts/create.html.erb
              # <h1>投稿が完了しました</h1>
              # <%= link_to 'トップページに戻る', '/posts' %>

              # https://master.tech-camp.in/v2/curriculums/7091

 # 
  end
  # 
            # https://master.tech-camp.in/v2/curriculums/4762

            # Memo Coding
            # def create
            #   Tweet.create(tweet_params)
            # end
          
            # private
            # def tweet_params
            #   params.require(:tweet).permit(:name, :image, :text)
            # end
# 

  def index
    @prototypes = Prototype.includes(:user)
  #
    # @prototype = Prototype.all
    # includes(:user)は.allの役割も含めて対応してくれる
    # @prototypes;app/views/postyepes/index.html.erb
    # @post = "これはコントローラーで定義したインスタンス変数を確認するための文字列です"
    # [EX]app/views/posts/index.html.erb
      # <h1>トップページ</h1>
      # <%= @post %>

    # #@messages = @room.messages.includes(:user)

    # この場合、メッセージに紐付くユーザー情報の取得に、メッセージの数と同じ回数のアクセスが必要になるので、N+1問題が発生します。
    # その場合は、includesメソッドを使用して、解消しましょう。
    # 全てのメッセージ情報に紐づくユーザー情報を、includes(:user)と記述をすることにより、ユーザー情報を1度のアクセスでまとめて取得することができます
    # https://master.tech-camp.in/v2/curriculums/4762
  end

  def show
    @prototype = Prototype.find(params[:id])
    # https://master.tech-camp.in/v2/curriculums/4220#8
      #     showアクションをコントローラーに定義しよう
      # 次は、ツイート詳細画面に必要な情報を、データベースから取得するためにshowアクションを定義しましょう。

      # tweets_controller.rbを編集しましょう
      # showアクションでは、詳細を表示したいツイートの情報をビューに受け渡すだけです。
      # def show
      #   @tweet = Tweet.find(params[:id])
      # end

      # https://master.tech-camp.in/v2/curriculums/4218
      #       tweetsコントローラーにdestroyアクションを定義します。
      # ツイートを削除する際にはモデルのdestroyメソッドを使いましょう。

      # また、どのツイートを削除するのかを特定する場合はparams[:id]を使用して、削除したいツイートの情報を取得します。
      # このときのparams[:id]は、先ほどPrefixで指定したパスであるtweet_path(tweet.id)のtweet.idにあたる数字が入ります。
      # 処理の流れとしては、以下のようになります。
      # まず、パラメータとして受け取ったparams[:id]をもとに、削除したいツイートをfindメソッドを用いて取得します。
      # 続いて、そのツイートをdestroyメソッドで削除します。

      # 削除機能の実装を行いました。以下の実装の流れを再度確認しておきましょう。

        # ツイートを削除するためのルーティングを設定する
        # 削除ボタンをビューに追加する
        # destroyアクションをコントローラーに定義する
        # 削除後のビューを追加する


  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    # params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
 #     https://master.tech-camp.in/v2/curriculums/4221
      #  devise_parameter_sanitizerデバイス パラメーター サニタイザーメソッド
          # deviseにおけるparamsのようなメソッドです。
          # deviseのUserモデルに関わる「ログイン」「新規登録」などのリクエストからパラメーターを取得できます。
          # このメソッドとpermitメソッドを組み合わせることにより、deviseに定義されているストロングパラメーターに対し、自分で新しく追加したカラムも指定して含めることができます。
          # devise_parameter_sanitizerメソッドは、これまでのストロングパラメーターと同じく、新たに定義するプライベートメソッドの中で使用します。
          # deviseの提供元では、新たに定義するメソッド名をconfigure_permitted_parametersと紹介していることから、慣習的にこのメソッド名で定義することが多いです。

          #     private
          # def configure_permitted_parameters  # メソッド名は慣習
          #   # deviseのUserモデルにパラメーターを許可
          #   devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])
          # end


          # # paramsのpermitメソッド
          # params.require(:モデル名).permit(:許可するキー)

          # # devise_parameter_sanitizerのpermitメソッド
          # devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])




  end



end
