class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true
  # validates :text, presence: true

  has_many :prototypes
    # # アソシエーションを定義しよう
    #  has_manyハズ メニーメソッド
    #  Userモデルの視点で考えると、あるユーザーの作成した投稿は複数個ある状態です。
    #  つまり、1人のユーザーは複数の投稿を所有しています。
    
    #  この状態のことをhas manyの関係といい、今回の場合は「User has many Tweets」の状態であると言えます。
    #  この関連付けをするため、userと他のモデルとの間に「1対多」のつながりがあることを示すのがhas_manyメソッドです。
      # https://master.tech-camp.in/v2/curriculums/4223#7

  has_many :comments  # commentsテーブルとのアソシエーション
  # https://master.tech-camp.in/v2/curriculums/4227

end
