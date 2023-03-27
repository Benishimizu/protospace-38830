Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "prototypes#index"
  # resources :prototypes //7つのアクションが生成されてしまう
  # https://master.tech-camp.in/v2/curriculums/4220
  # https://master.tech-camp.in/v2/curriculums/4219

  resources :prototypes, only: [:destroy, :update, :edit, :show, :index, :create, :new] do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show]
  # resources :comments, only: :create
    # 上記でも大丈夫だが、かっこ　がある方が編集しやすい
      # resources :images, only: :index
      # resources :products, only: [:index, :show]
      # ■公式サイト
      # https://railsguides.jp/routing.html
      # https://master.tech-camp.in/v2/curriculums/4227#8
      # コメントの時は基本ルーティングのネストが必要
        # 例：ルーティングのネスト
          # ネストは、ある記述の中に別の記述をして、親子関係を示す方法です。
          # 「入れ子構造」とも呼ばれます。

          # ルーティングにおけるネストとは、あるコントローラーのルーティングの中に、別のコントローラーのルーティングを記述することです。

          # 【例】ルーティングのネスト
          # Rails.application.routes.draw do
          #   resources :親となるコントローラー do
          #     resources :子となるコントローラー
          #   end
          # end
          # ルーティングでネストを利用すると、アクションを実行するためのパスで、親子関係を表現できます。


          # tweets_controller.rbのルーティングの中にcomments_controller.rbのルーティングを記述します。ネストを利用したときに設定されるルーティングの例を見てみましょう。
          # 【例】ネストを利用した場合
          # Prefix Verb           URI Pattern                            Controller#Action
          # # 中略
          # tweet_comments POST   /tweets/:tweet_id/comments(.:format)   comments#create
          # # 中略
          # パスの:tweet_idという部分に記述された値は、パラメーターとして送られます。
          # もし、ネストを利用しなかった場合は、:tweet_idのような、パスにパラメーターを含められる部分がありません。
          # 【例】ネストを利用しなかった場合
          # Prefix Verb     URI Pattern           Controller#Action
          # # 中略
          # comments POST   /comments(.:format)   comments#create
          # # 中略
          # 以上からわかるように、ルーティングにネストを利用しなければ、モデルと結びついている別モデルのid情報が送れなくなります。ネストを利用すれば、id情報を含めることができます。

          # まとめると、ルーティングをネストさせる一番の理由は、アソシエーション先のレコードのidをparamsに追加してコントローラーに送るためです。

          # 今回の実装だと、コメントと結びつくツイートのidをparamsに追加します。
          # -ユーザーに関するshowアクションのルーティングを設定しよう------
          # マイページを表示する際にはusersコントローラーのshowアクションを動かせるようにルーティングを設定しましょう。

          #  routes.rbを以下のように編集しましょう
          #  config/routes.rb
          #  Rails.application.routes.draw do
          #    devise_for :users
          #    root to: 'tweets#index'
          #    resources :tweets
          #    resources :users, only: :show
          #  end
          #  これで、/users/:idのパスでリクエストした際にusers_controller.rbのshowアクションを実行するルーティングが設定できました。
          # 【例】
            # Prefix   Verb   URI Pattern             Controller#Action
            # user     GET    /users/:id(.:format)    users#show
          # False
          # prototype_user GET    /prototypes/:prototype_id/users/:id(.:format)                                            users#show
          # ネストをしたなかにコーディングをしてしまうと１行上のような内容になり、ルーティングがうまくできないことがある。
          # なのでネストをしていないところに書くことを気をつけなければいけない
          # ７つのアクション
          # アクション名	内容
              # index	一覧表示：トップページ
              # show	詳細表示：詳細ページ
              # new	生成：新規登録ページ
              # create	保存：保存してや投稿完了のページ
              # edit	編集：編集ページ
              # update	更新：更新した後
              # destroy	削除：削除した後もしくは削除ページ
  # 

end
