class Comment < ApplicationRecord
  belongs_to :prototype  # tweetsテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション
  # https://master.tech-camp.in/v2/curriculums/4227
  # https://master.tech-camp.in/v2/curriculums/4762
end
