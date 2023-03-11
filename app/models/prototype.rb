class Prototype < ApplicationRecord
  belongs_to :user
  # belongs_toビロングス トゥーメソッド
  # 1つの投稿は、1人のユーザーが投稿したものです。
  # つまり1つの投稿を複数人が投稿できないため、投稿は必ず1人のユーザーに所属します。
  
  # この状態のことをbelongs toの関係といい、今回の場合は「Tweet belongs to User」の状態であると言えます。
  
  # Tweetモデルと他のモデル（User）との間に「1対1」のつながりがあることを示すのがbelongs_toメソッドです。
  has_one_attached :image
end
