### ER図
[![Image from Gyazo](https://i.gyazo.com/3826cb7723426b3a139294ec765c3f4f.png)](https://gyazo.com/3826cb7723426b3a139294ec765c3f4f)

### 本サービスの概要（700文字以内）
『薬管理を手助けするアプリ』<br>
薬の飲み忘れを防止したり、ストック切れで困ったりしないようにお知らせするアプリです。<br>
服用する時間になったらLINE通知にてお知らせしたり、ストックが切れそうな頃にLINE通知にて購入時期をお知らせしたりします。<br>
また、家族共有設定をすることで「薬を飲んだ・飲んでいない」を家族へ通知することも出来ます。

### MVPで実装する予定の機能
- [x] おくすり登録機能
- [x] ログイン機能
- [x] 服用タスク管理機能
- [x] 服用リマインド機能
- [x] 処方箋等画像アップロード機能

### 本リリースで実装する予定の機能
- [x] 服用ログ機能
- [x] 家族共有機能
- [x] リマインドカスタマイズ機能
- [x] 在庫通知機能

### テーブル補足情報
#### usersテーブル
| カラム名            | 型       | 説明           |
| ------------------ | -------- | -------------- |
| id                 | int      | 主キー            |
| name               | string   | 表示名            |
| age                | int      | 年齢              |
| gender             | string   | 性別              |
| line\_uid          | string   | LINE連携用UID（任意） |
| email              | string   | メールアドレス（任意）    |
| password\_digest   | string   | パスワード（メール登録時）  |
| reminder\_interval | int      | 飲み忘れ時リマインド分数（任意） |
| created\_at        | int            |                |
| updated\_at        | time     |                |

#### medicinesテーブル
| カラム名                 | 型        | 説明                         |
| -------------------- | -------- | -------------------------- |
| id                   | int      | 主キー                        |
| user\_id             | int      | 外部キー（登録ユーザー）               |
| name                 | string   | 薬の名前                       |
| image                | string   | 処方箋等の画像                    |
| dose\_per\_day       | int      | 1日に飲む回数                    |
| pills\_per\_dose     | int      | 1回に飲む個数                    |
| stock\_count         | int      | 現在のストック数（個数）               |
| stock\_alert\_count  | int      | 残り何個で通知するか（個数ベース）          |
| stock\_alert\_month  | int      | 薬が切れる〇か月前で通知する（0ならこの通知はオフ） |
| created\_at          | datetime |                            |
| updated\_at          | datetime |                            |


#### dosetimingsテーブル
| カラム名          | 型        | 説明           |
| --------------   | -------- | ------------ |
| id               | int      | 主キー          |
| medicine\_id     | int      | 外部キー（どの薬か）   |
| dose\_time       | string   | 飲む時間帯（朝･夕など） |
| dose\_timing     | string   | 飲むタイミング（食前、食後など） |
| reminder\_time   | time     | 通知する具体的な時間   |
| created\_at      | time     |              |
| updated\_at      | time     |              |

#### familymembersテーブル
| カラム名     | 型       | 説明             |
| ----------- | -------- | ---------------- |
| id            | int      | 主キー            |
| user\_id      | int      | 外部キー（招待したユーザー）   |
| name          | string   | 家族の名前（表示用）       |
| relationship  | string   | 家族との関係性            |
| line\_uid     | string   | 家族のLINEID（通知に使用） |
| invited\_at   | time     | 招待送信日時           |
| accepted      | bit      | 参加承認済みかどうか       |
| created\_at   | time     |                  |
| updated\_at   | time     |                  |

#### intakelogsテーブル
| カラム名          | 型       | 説明                          |
| ---------------- | -------- | ----------------------------- |
| id               | int      | 主キー                       |
| user\_id         | int      | 外部キー（誰が飲んだか）      |
| medicine\_id     | int      | 外部キー（どの薬か）          |
| dosetiming\_id   | int      | 外部キー（飲む時間帯）        |
| scheduled\_at    | time     | 通知された予定時間                 |
| taken\_at        | time     | 実際に飲んだ時間（未記録ならNULL）  |
| status           | int      | 服用状態（0:通知済み、飲んでいない 1:飲んだ 2:スキップ） |
| created\_at      | time     |                               |
| updated\_at      | time     |                               |


### ER図の注意点
- [x] プルリクエストに最新のER図のスクリーンショットを画像が表示される形で掲載できているか？
- [x] テーブル名は複数形になっているか？
- [x] カラムの型は記載されているか？
- [x] 外部キーは適切に設けられているか？
- [x] リレーションは適切に描かれているか？多対多の関係は存在しないか？
- [x] STIは使用しないER図になっているか？
- [x] Postsテーブルにpoast_nameのように"テーブル名+カラム名"を付けていないか？