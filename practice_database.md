# 課題
## ailsで質問・回答アプリを作ってください（テーブル設計編）

要件  
ログインログアウト機能がある  
ユーザーはニックネームとアバター画像を登録できる  
ユーザーは質問を投稿できる  
ユーザーは自分の質問を編集・削除できる  
ユーザーは質問に対して回答ができる  
ユーザーは質問を解決済み状態に変更できる  
ユーザーは質問を検索できる  
質問があった際に全員に対して質問があった旨をメールで通知する（ただし自分は除く）  
質問に対して回答があった場合は質問者および当該質問に回答したユーザーに対してメールで通知する。（ただし自分は除く）  
質問はページングできる  
管理画面がある  
管理画面へは権限を付与されたユーザーしか入れない  
管理画面では全てのリソースを削除できる  

# 解答
- users
  - id:integer
  - name:string
  - mail:string
  - avater:string
  - admin:boolean
  - password_digest:string

- questions
  - id:integer
  - title:string
  - body:text
  - solved:boolean
  - user_id:integer

- answers
  - body:text
  - user_id:integer
  - question_id:integer

### 補足説明
要件をもとに頭の中でイメージした結果、必要だと思うものを書き出しました。  

- users/avater:string
  - アバター画像のファイル名を保存する。現場本にあったActiveStorageをを使うのかとも思ったのですが、ネットで調べたところ画像名ををDBに保存してそれをもとに読み込むやり方がテーブル構成がシンプルになると思いそちらを採用しました。(正直にいうとActiveStorageをまだ理解していないからでもあります)  

- questions/solved:boolean
  - 質問が解決済みかどうかのフラグ。名付けは「解決」を英訳してそれっぽいものを選びましたがこんな感じの決め方でいいのでしょうか
