class CreatePrototypes < ActiveRecord::Migration[6.0]
  def change
    create_table :prototypes do |t|
      # Memo1
      # t.string :name
      # t.string :text
      # t.text :image


      # Memo2:https://master.tech-camp.in/v2/curriculums/4579
      # t.string :name
      # t.string :text
      # t.text :image
      # t.references :user, foreign_key: true
      # 上記例のように外部キー制約を設定すると、特定のuser情報を削除したい場合には、
      # まず先にそのuser情報を参照しているtweetsテーブルのレコードを削除しなくてはなりません。

      # 外部キー制約は、t.references :userにforeign_key: trueと記述することで、設定できます。
      
      # 書き方は、以下のように記述します。
      # t.references :カラム名,  foreign_key: true
      # 上記でreferencesという型を使用していますが、これは他テーブルから情報を参照する際に用いる型です。
      # userと記載するとuser_idというカラムが生成されます。
      # 指定したカラムが、DBに空のままの状態で保存するのを防ぎます。
      
      # NOT NULLノット ヌル制約
      # NOT NULL制約は、テーブルの属性値にNULL（空の値）が入らないように制限する制約です。
            
      # たとえば、usersテーブルの「name」カラムにNOT NULL制約を設定すると、nameカラムが空のレコードだと保存できなくなります。
      # この制約は、t.string :nameにnull: falseと記述することで、設定できます。
      # カラム名の後にこれを記述します。
      # 書き方は、以下のように記述します。

      # 【例】
      # t.型 :カラム名, null: false


      t.string :title, null: false
      t.text :catch_copy, null: false
      t.text :concept, null: false
      t.references :user, null:false, foreign_key: true

      # t.reference :image, foreign_key: true
        #<---Conf:Not image the reason 
        # imageについては、ActiveStorageで実装します。したがって、prototypesテーブルのカラムとして設ける必要はありません。
        #https://master.tech-camp.in/v2/curriculums/4579 
        # https://master.tech-camp.in/v2/curriculums/4216#11
        # ReadMe memo
          # | title              | string     | null: false                    |
          # | catch_copy         | text       | null: false                    |
          # | concept            | text       | null: false                    |
          # | user               | references | null: false, foreign_key: true |

      t.timestamps
    end
  end
end
