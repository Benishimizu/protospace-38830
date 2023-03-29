class PrototypesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  # 解説
    # コントローラーの先頭に、before_action :authenticate_user!と記述します。
    # この記述により、ログインしていないユーザーをログインページの画面に促すことができます。
    # https://master.tech-camp.in/v2/curriculums/4839


    # authenticate_user!オウセンティケイト ユーザーメソッド
    # ログイン状態によって表示するページを切り替えるdeviseのメソッドです。
    # authenticate_user!メソッドは、処理が呼ばれた段階で、ユーザーがログインしていなければ、そのユーザーをログイン画面に遷移させます。
    
    # この仕組みを利用し、before_actionで呼び出すことで、アクションを実行する前にログインしていなければログイン画面に遷移させられます。
      # before_action :authenticate_user!にonlyとexceptを記載する方法。


      # ■onlyの場合

      # onlyで指定されたアクションにリクエストが送られた場合のみメソッドが発動します。
      # 【例】
      # before_action :authenticate_user!, only: [:new]
      # 上記の場合は、controllerにnewアクションにリクエストがあったときのみauthenticate_user!メソッドが発動します。


      # ■exceptの場合

      # exceptで指定されたアクション"以外"にリクエストが送られた場合のみメソッドが発動します。
      # 【例】
      # before_action :authenticate_user!, except: [:index,:show]
      # 上記の場合、index、showアクション以外のアクションにリクエストがあったときのみauthenticate_user!メソッドが発動します。
      # つまり、記載されたコントローラーに7つのアクションが定義されているとすると、new,create,edit,update,destroyの⑤つのアクションの際にauthenticate_user!が動くということになります。

      # 今回は未ログインユーザを別のパスへ転送するため、未ログインユーザを判別する必要があります。この判別には、user_signed_in?とunlessを用います。

        #  unlessアンレス
        #   ifと同様に、条件式の返り値で条件分岐して処理を実行するRubyの構文です。
        #   ifは返り値がtrueのときにelseまでの処理が実行されますが、
        #   unlessはfalseのときにelseまでの処理が実行されます。
          
        #   【例】unless
        #   unless 条件式
        #     # 条件式がfalseのときに実行する処理
        #   end 
        #   このunlessを用いて「ログインしているユーザーでない」ときの処理に、リダイレクトを設定しましょう。
          
        #   Railsではリダイレクト処理に、redirect_toメソッドを使用します。
          
        #    redirect_toリダイレクト トゥーメソッド
        #   Railsでリダイレクト処理を行う際に使用するメソッドです。
        #   コントローラー等での処理が終わった後、アクションに対応するビューファイルを参照せずに、別ページへリダイレクトさせることができます。
          
        #   書き方は以下の通りです。
          
        #   【例】redirect_to
        #   redirect_to action: :リダイレクト先となるアクション名
        #   さっそく、リダイレクト処理を実装したいところですが、もう1つ学んでおきましょう。
        #   今回はリダイレクト処理を定義して、before_actionで実行させますが、一部のアクションについては処理を実行させたくないため、exceptオプションを使用し指定する必要があります。
          
        #    exceptエクセプトオプション
        #   before_actionで使用できるオプションです。exceptは「除外する」という意味があります。
        #   こちらの後に指定したアクションに対しては、事前処理は実行されません。
          
        #    リダイレクト処理を用意しましょう
        #   tweets_controller.rbを編集します。
          
        #   app/controllers/tweets_controller.rb
        #   class TweetsController < ApplicationController
        #     before_action :set_tweet, only: [:edit, :show]
        #     before_action :move_to_index, except: [:index, :show]
          
        #     def index
        #       @tweets = Tweet.all
        #     end
          
        #     def new
        #       @tweet = Tweet.new
        #     end
          
        #     def create
        #       Tweet.create(tweet_params)
        #     end
          
        #     def destroy
        #       tweet = Tweet.find(params[:id])
        #       tweet.destroy
        #     end
          
        #     def edit
        #     end
          
        #     def update
        #       tweet = Tweet.find(params[:id])
        #       tweet.update(tweet_params)
        #     end
          
        #     def show
        #     end
          
        #     private
        #     def tweet_params
        #       params.require(:tweet).permit(:name, :image, :text)
        #     end
          
        #     def set_tweet
        #       @tweet = Tweet.find(params[:id])
        #     end
          
        #     def move_to_index
        #       unless user_signed_in?
        #         redirect_to action: :index
        #       end
        #     end
        #   end
          
          
        #   これでもし、ログインしていない状態で新規投稿画面へ直接アクセスしようとしても、before_actionによりmove_to_indexメソッドが先に実行され、indexアクションのindex.html.erbページにリダイレクトしてくれます。
          
        #   3 行目
        #   indexアクションにアクセスした場合、indexアクションへのリダイレクトを繰り返してしまい、無限ループが起こります。この対策として、except: :indexを付け加えています。
          
        #   また、ログインしていなくても、詳細ページに遷移できる仕様にするためにexcept: [:index, :show]としています。
          
        #   42~46 行目
        #   unlessでuser_signed_in?を判定して、その返り値がfalseだった場合にredirect_toが実行されます。
        #   すなわち、ユーザーがログインしていない場合にはindexアクションが実行されます。
          
        #    ブラウザで新規投稿ページにアクセスしましょう
        #   それでは、もう一度直接URLを入力して新規投稿ページへアクセスし、投稿ページではなくindexアクションの投稿一覧ページに戻るか確認しましょう。
          
        #   http://localhost:3000/tweets/new
        #   ログインしていない状態であれば、新規投稿ページではなくトップページが表示されるはずです。
          
        #   補足情報
        #   deviseによるユーザー管理機能の実装は、この後のカリキュラムでも頻繁に登場します。以下の補足カリキュラムでdeviseの詳細について解説しています。もしこの段階でも興味があればご覧ください。なお、以下の補足カリキュラムは、今後のカリキュラムでも必要に応じて紹介します。一部まだ習っていない内容も含まれていることをご了承ください。
          
        #   deviseによるユーザー管理機能導入のおさらい
          
        #   また、deviseによるユーザー管理機能においては、マイグレーションファイルについてのトラブルが生じがちです。また、必要に応じてdeviseを再導入しなければいけない状況が発生します。それらについては以下の補足カリキュラムで紹介しています。
          
        #   データベースに関する修正作業を学ぼう
        #   deviseの削除方法を学ぼう
          
        #   これらの補足カリキュラムも、必要に応じて今後のカリキュラムでご紹介します。
          
        #   練習問題
        #   理解度向上のための練習問題です。ぜひチャレンジしましょう。
          
        #   【練習問題 Ruby on Rails（PicTweet）】ユーザーを登録しよう
          
        #   解答に行き詰まってしまった場合、適宜カリキュラムを参考にしていただいて構いません。
          
        #   この章の振り返り
        #   本章では、ユーザーの管理機能を実装しました。
          
        #   Gemのdeviseを使用すると、ゼロからユーザー機能を作成するより断然簡単に実装が可能です。
        #   是非覚えておきましょう。
          
        #   要点チェック
        #    deviseとは、ユーザー管理機能を簡単に実装するためのGemのこと
        #    rails g devise:install コマンドとは、deviseというGemの設定関連に使用するファイルを自動で生成するコマンドのこと
        #    rails g deviseコマンドとは、deviseの中で使用するユーザーモデルclass名を置き換え、modelなど必要なファイルを生成するコマンドのこと
        #    rails g devise:viewsコマンドとは、deviseで自動生成されたログインや新規作成画面を変更する際に使用するコマンドのこと
        #    user_signed_in?メソッドとは、ログインしているユーザー情報を取得するメソッドのこと
        #    リダイレクトとは、「本来受け取ったパスとは別のパスへ転送する」こと
        #    redirect_toメソッドとは、指定先にリダイレクトさせるメソッドのこと
        #    rails g migrationコマンドとは、マイグレーションファイルを生成するためのコマンド。命名規則に沿うと、必要なマイグレーションが記述された状態で生成されること
        #    スネークケースとキャメルケースとは、複数の単語が連立する場合に使用する命名パターンのこと
        #    devise_parameter_sanitizerメソッドとは、deviseでユーザー登録する場合に使用できる、「特定のカラムを許容する」メソッドのこと
        #    application_controller.rbファイルとは、rails g controllerが生成するコントローラーが予め継承しているコントローラーのこと
        # https://master.tech-camp.in/v2/curriculums/4221
  


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
        # SAVE METHODOは役割：saveするだけなのでNEWの適用が必要になる
          #　補足： CREATE METHODO : TRUE false を返してくれない＝＞条件分岐がなくて、保存したい時だけ→@prototype.create/　NOT NEEDED
          # CREATE METHODO :NEW＋SAVE


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

        # @comments = Comment.new
        # prototypesコントローラーのshowアクションに、@commentというインスタンス変数を定義し、Commentモデルの新規オブジェクトを代入した
        # なので上記は間違え
    # Answer
    @comment = Comment.new
    #  prototypesコントローラーのshowアクションに、@commentというインスタンス変数を定義し、Commentモデルの新規オブジェクトを代入した
      # VIEWを管理するSHOW .HTML.ERBで@commentと定義している変数と合わせてあげるため
    @comments = @prototype.comments
      # 
          #tweets/show.html.erbでform_withを使用して、comments#createを実行するリクエストを飛ばしたいので、@comment = Comment.newというインスタンス変数を生成しておかないといけません。

          # tweetsテーブルとcommentsテーブルはアソシエーションが組まれているので、@tweet.commentsとすることで、@tweetへ投稿されたすべてのコメントを取得できます。

          # また、ビューでは誰のコメントか明らかにするため、アソシエーションを使ってユーザーのレコードを取得する処理を繰り返します。
          # そのときに「N+1問題」が発生してしまうので、includesメソッドを使って、N+1問題を解決している点にも注意してください。
      # 
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
        #  https://master.tech-camp.in/v2/curriculums/4219
      # tweet = Tweet.find(params[:id])
    # tweet.update(tweet_params)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    #MEMO
    #  @item = Item.find(params[:id]) 
    #もし、現在ログインしているユーザーは商品を出品ユーザーではなかった時、トップページに遷移する
    unless current_user == @prototype.user
      redirect_to root_path
    end
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


  # ログインの有無で表示を変えよう
  # ヘッダー部分のHTMLは、すべてのビューで共通のテンプレートであるapplication.html.erbにあります。
  # application.html.erbを編集して、未ログイン時とログイン時でボタンの表示を変える実装をしましょう。

  # ログイン状態の確認には、user_signed_in?メソッドを使用します。

  #  user_signed_in?ユーザー サインド インメソッド
  # Gemのdeviseを導入しているため、使用できるメソッドです。
  # ログインしているかどうかの判定を行います。

  # user_signed_in?メソッドは、ユーザーがログインしていればtrueを、ログアウト状態であればfalseを返します。

    # [Another Answer]
      # before_action :contributor_confirmation, only: [:edit, :update, :destroy]
      # def contributor_confirmation
      #   redirect_to root_path unless current_user == @prototype.user
      # end
      # [Ref.]
          # before_action :contributor_confirmation, only: [:edit, :update]

          # def edit
          # end

          #   def update
          #     if @item.update(item_params)
          #       redirect_to item_path
          #     else
          #       render :edit
          #     end
          #   end

          #   private
          # def contributor_confirmation
          #     redirect_to root_path unless @item.user == current_user
          # end
          # https://qiita.com/N396184501/items/a02bd2ecbbe135f88d6c

end
