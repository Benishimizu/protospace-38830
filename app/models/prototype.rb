class Prototype < ApplicationRecord
  belongs_to :user
            # belongs_toビロングス トゥーメソッド
                # 1つの投稿は、1人のユーザーが投稿したものです。
                # つまり1つの投稿を複数人が投稿できないため、投稿は必ず1人のユーザーに所属します。
                
                # この状態のことをbelongs toの関係といい、今回の場合は「Tweet belongs to User」の状態であると言えます。
                
                # Tweetモデルと他のモデル（User）との間に「1対1」のつながりがあることを示すのがbelongs_toメソッドです。
  has_one_attached :image
            #  has_one_attachedハズ ワン アタッチドメソッド
                # 各レコードとファイルを1対1の関係で紐づけるメソッドです。
                # has_one_attachedメソッドを記述したモデルの各レコードは、それぞれ1つのファイルを添付できます。

                # 【例】has_one_attachedメソッド
                # class モデル < ApplicationRecord
                #   has_one_attached :ファイル名
                # end
                # :ファイル名には、添付するファイルがわかる名前をつけましょう。
                # この記述により、モデル.ファイル名で、添付されたファイルにアクセスできるようになります。また、このファイル名は、そのモデルが紐づいたフォームから送られるパラメーターのキーにもなります。

                # 今回はこの仕組みを利用して、画像ファイルをmessageテーブルのレコードに添付





              #   今回のプロトタイプ投稿機能のルールに合うように、バリデーションを設定しましょう。

              # プロトタイプ情報の投稿機能におけるルールは以下のとおりでした。こちらを参考にしてください。

              # プロトタイプの投稿に必要な情報	条件	必須か否か
              # プロトタイプの名称	string型、カラム名はtitle	必須
              # キャッチコピー	text型、カラム名はcatch_copy	必須
              # コンセプト	text型、カラム名はconcept	必須
              # プロトタイプの画像1枚	ActiveStorageを用いて実装	必須
              # なお、imageカラムのバリデーションについては、Prototypeモデルに以下のように設定します。
              # 【例】imageカラムのバリデーション
              # validates :image, presence: true
              # 作業チェック
              # Prototypeモデルに、プロトタイプの名称、キャッチコピー、コンセプト、画像に関するバリデーションを記述した
          # 
              validates :title, presence: true
              validates :catch_copy, presence: true
              validates :concept, presence: true
              validates :image, presence: true
              # validates :image, presence
#               validatesバリデーツメソッド
              # validatesとは、バリデーションを設定する時に使用するメソッドです。

              # 【例】モデルファイル
              # validates :カラム名, バリデーションの種類
              # 下記の例は、presence: trueと記述することで、nameカラムが「空ではないか」というバリデーションを設けています。
              # validates :name, presence: true
              # このバリデーションを設けることで、名前が空欄の時データベースに保存できなくなります。
              # つまり、値を必ず入れなければいけません。
              # もし、空欄で登録しようとすると、エラーが発生します。
# 

 #           Bin//今回は画像がないと投稿できないので下記コードは不要
              # validates :concept, presence: true, unless: :was_attached?

              # def was_attached?
              #   self.image.attached?
              # end
              # https://master.tech-camp.in/v2/curriculums/4763
# 
  has_many :comment



            end
