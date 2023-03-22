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
    # 
        #  @prototype = モデル名[今回はPrototype.rbの１番目の文章のPrototypeに該当].new(prototype_params[一番下のものに該当])
        # (prototype_params)がないと空データのままの保存になってしまうため、　(prototype_params)を引数にする必要がある
        # Prototype.new(prototype_params)と書いているのは、SAVE METHODに引数を受け取れないから
        # SAVE METHODO: 保存できたらTRUE、できなかったらFALSEを返してくれるからIF文が使えることができるー＞条件分岐をつけたい時ーなので@prototype.saveを使う
          #　補足： CREATE METHODO : TRUE false を返してくれない＝＞条件分岐がなくて、保存したい時だけ→@prototype.create/　NOT NEEDED


    # 

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

  def update
    @prototype = Prototype.find(params[:id])
    # 解説
      # @prototype.update
      # PROTO TYPEモデルにFINDメソッドを使ってデータを探す
      # 出てきたものを@prototypeに代入
    # 

    # Original Answer
      # if @prototype.update(prototype_params)
      #   redirect_to root_path(@prototype)
      # else
      #   render :edit
      # end

    if @prototype.update(prototype_params)
      # 解説
        # if 
        # @prototype.update：＠ptorotypeを更新します
        # (prototype_params)：この情報をもとに　・・PRIVATE METHODのした（つまりこのファイルの下にある、”def prototype_params〜”）を元に作成
        # UPDATEMETHODだけ引数を受け取レルから　＆
        # UPDATE METHODは保存できたらTRUE、できなかったらFALSEを返してくれるからIF文が使えることができる
      # 
      redirect_to prototype_path(@prototype)
          # redirect_to root_path(@prototype)
      # 
        # redirect_to ; どこの部屋に行きたいか示さないといけないから引数をつける
        #  root_path：トップページ：
        # ->redirect_to root_path だと引数を指定してあげなくてもOK

        # ただし、/prototypes/:id(.:format)のように　:idと書いてあるものは引数が必要
          # ※上記の@prototype.update(prototype_params)の引数とは全く無関係：保存の時の引数
          # 今回は　 redirect_to　：はROOTING
          # 判断基準としては、今回RAILS ROUTESをしたときに　”/prototypes/:id(.:format)”と書いてあったので、引数の（@prototype)が必要
            # [1] validates :name, presence: trueの書き方について
                  # https://master.tech-camp.in/v2/curriculums/4847
                  # のカリキュラムを見ています。
                  # 解説で下記のように書かれています。
                  # ーーーーーーーーー
                  # Userモデルに、validates :name, presence: trueを追記します。
                  # 「name」カラムに、presence: trueを設けることで、空の場合はDBに保存しないというバリデーションを設定しています。
                  # つまり、ユーザー登録時に「name」を空欄にして登録しようとすると、エラーが発生します。
                  # ーーーーーーー
                  # https://master.tech-camp.in/v2/curriculums/4223
                  # を見ていると『「空ではないか」というpresence: trueのバリデーションを設ける必要はありません。』
                  # と書いてある文があり具体的に必要な時と必要でない時はどのように見極めたら良いでしょうか？


                  # また、https://master.tech-camp.in/v2/curriculums/5291#7
                  # のコーディングをしているのですが、作業チェックの１つで
                  # 「 バリデーションによって更新ができず編集ページへ戻ってきた場合でも、入力済みの項目（画像以外）は消えないことを確認した」
                  # とあり、特にエラーは起きていないのですが、PRECENSE： TRUEのTRUEを取手しまうとエラーが出てしまいました。
                  # そのため、今回の時も関係あるか伺いたいです。
            # Answer
              # [1]validates :name, presence: trueの書き方について
              # 『「空ではないか」というpresence: trueのバリデーションを設ける必要はありません。』と書いてある文があり具体的に必要な時と必要でない時はどのように見極めたら良いでしょうか？

              # 基本的に「空では保存したくないカラム」はpresence: trueをつけていただけたらと存じます。
              # ただし、RailsやGemなどで、空では保存できないように既になっているものもあります。
              # 例えば、アソシエーションを組んでいる場合の外部キーカラム（Railsがチェックしてくれています）や、deviseを使用したときのemailカラム・passwordカラムなどです。（deviseがemailカラム・passwordカラムが入力されていないと保存できないようにしてくれています）
              # このように、既に他のコードがpresence: trueを実現している場合は、こちらでpresence: trueを記述する必要はありません。


              # また、エラーに関しましては、上記内容とは異なる原因かと存じます。
              # エラー内容をご確認いただき、修正いただけたらと存じます。

            

            # [2]
            # 現在、下記の
            # https://master.tech-camp.in/v2/curriculums/5291#7
            # 『updateアクションにデータを更新する記述をし、更新されたときはそのプロトタイプの詳細ページに戻るような記述をした
            # updateアクションに、データが更新されなかったときは、編集ページに戻るようにrenderを用いて記述した』
            # に取り組んでいます。
                #     @prototype = Prototype.find(params[:id])
                #     if @prototype.update
                #       redirect_to root_path
                #     else
                #       render :edit
                #     end
            # 今上記のコーディングを
            # [ https://master.tech-camp.in/v2/curriculums/4219 ]を元にしたのですが、エラーが起きています。
            # そのため、[ https://master.tech-camp.in/v2/curriculums/4220]を元に　(prototype_params)を付け加えたのですが、これが必要な時とそうでないときの違いとはどのようなものになりますでしょうか？
                #     @prototype = Prototype.find(params[:id])

                #     if @prototype.update(prototype_params)
                #       redirect_to root_path
                #     else
                #       render :edit
                #     end

            # [2]Answer
                  # (prototype_params)を付け加えたのですが、これが必要な時とそうでないときの違いとはどのようなものになりますでしょうか？
                  # prototype_paramsは、ストロングパラメータのメソッドかと存じます。
                  # ストロングパラメータは、クライアントから送られてきているデータであるparamsから、保存に必要な処理を取得する処理をおこなっています。
                  # よって保存に必要な処理を取得し、そのデータを保存したり更新したりする場合に必要になってきます。
                  # @prototype.update(prototype_params)
                  # ↑こちらのコードは、「@prototypeのデータを、prototype_paramsで取得したデータで更新する」といった記述となります。
            # [3] [2]の続きになります
              # 上記のコードでまだエラーが起きたので、
              # https://master.tech-camp.in/v2/curriculums/4862
              # を参考にしてredirect_to root_path(@prototype) と修正しました。
                    #  @prototype = Prototype.find(params[:id])
                    #     if @prototype.update(prototype_params)
                    #       redirect_to root_path(@prototype)
                    #     else
                    #       render :edit
                    #     end
                # ただ、https://master.tech-camp.in/v2/curriculums/4862　の中のコーディングについて教えてほしいです。
                    #   if @message.save
                    #       redirect_to room_messages_path(@room)
                    #     else
                    #       render :index
                    #     end
                    # redirect_to room_messages_path(@room)　とredirect_to oom_messages_pathの違いはどのようになりますでしょうか？
                  # 一応https://master.tech-camp.in/v2/curriculums/4711　とかは見てみたのですが、解説がなくすみませんが教えていただけると助かります

            # [3]Answer
                  # redirect_to room_messages_path(@room)　とredirect_to oom_messages_pathの違いはどのようになりますでしょうか？
                  # 〇〇_pathの後ろに、(@room)をつける場合とつけない場合があり、この違いについて知りたい、ということでよろしかったでしょうか。
                  # rails routesでルーティングを確認したとき、URI Patternに「:id」や「:room_id」など、id値を含む場合に記述が必要となります。
                  # （ただし、遷移前のURLと遷移後のURLに同じid値が当てはまる場合は、バスの後ろの引数の記述は省略することが可能です）
          # 
    else
      render :edit
    end

    # Answer
        # if @prototype.update(prototype_params)
        #   redirect_to prototype_path(@prototype)
        # else
        #   render :edit
        # end


    # https://master.tech-camp.in/v2/curriculums/4219
      # tweet = Tweet.find(params[:id])
      # tweet.update(tweet_params)

  end

  def edit
    @prototype = Prototype.find(params[:id])
    # https://master.tech-camp.in/v2/curriculums/4219
    # editアクションをコントローラーに定義しよう
      # tweetsコントローラーにeditアクションを定義しましょう。

      # 現在実装している「編集して更新（edit→update）」という処理の流れは、「入力して新規投稿（new→create）」という流れと似ています。

      # 新規投稿時と異なる点は、編集→更新の場合はすでに存在しているレコードを選択して中身を書き換えるという点です。
      # そのため、editアクションでは編集したいレコードを@tweetに代入し、ビューに受け渡すことで編集画面で利用できるようにします。

      # つまり、以下のようにform_withで使用する@tweetを中身が入った状態にしておくということです。
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
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
