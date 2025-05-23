# runteq_graduation_production
## ■詳細
RUNTEQ卒業制作


# ■サービス概要
> どんなサービスなのかを３行で説明してください。

『薬管理を手助けするアプリ』<br>
薬の飲み忘れを防止したり、ストック切れで困ったりしないようにお知らせするアプリです。<br>
服用する時間になったらLINE通知にてお知らせしたり、ストックが切れそうな頃にLINE通知にて購入時期をお知らせしたりします。


# ■ このサービスへの思い・作りたい理由
> このサービスの題材となるものに関してのエピソードがあれば詳しく教えてください。
> このサービスを思いつくにあたって元となる思いがあれば詳しく教えてください。

私は持病により毎日薬を呑む必要があるのですが、たまに飲み忘れてしまうことがあります。<br>
いつもは自席の目につくところにおくことで、飲み忘れを防いでいるのですが、<br>
稀に、薬の１シートを飲み切って次のシートを出し忘れると、飲み忘れることがありました。<br>
また、シートの穴の位置でその日飲んだかどうかを判断しているのですが、<br>
飲み忘れがあって穴の位置がズレると飲んだかどうか、あやふやになってしまうこともあります。<br>
２０代の私でもこれなので、高齢の方はよりご自身の常備薬服用を忘れたり、飲んだか覚えていなかったりすると感じました。<br>
上記より、自分のためにも、また、自分の親世代などにも役立てるアプリとして本アプリ案を形にしたいと考えました。


# ■ ユーザー層について
> 決めたユーザー層についてどうしてその層を対象にしたのかそれぞれ理由を教えてください。

## ユーザー層
薬を定期的に使う必要がある人、また、そのような家族がいる人

## 何故その層を対象にしたのか
薬を使う人にとっては、日々の服用忘れを防止したり、服用したことを確認できるから<br>
上記のような家族がいる人にとっては、離れた場所にいたり、常に見ていることが出来なかったとしても<br>
服用出来ているか確認して安心感を得ることができるため


# ■サービスの利用イメージ
> ユーザーがこのサービスをどのように利用できて、それによってどんな価値を得られるかを簡単に説明してください。
## 薬を使う人
服用者は通知を受けたいLINEアカウントを使って会員登録をする
  - LINEアカウントでの登録は必須
  - 任意でメールアドレスの登録も促す<br>
    （LINEアカウントを削除してもログインができるため推奨していく）

以下2通りの方法でログインして使用する
  - LINEアカウントでのログイン
  - メールアドレスとパスワードでのログイン

Webアプリから以下の情報を登録する
- 薬について
  - 使う薬の名前
  - １日に飲む回数と個数
  - 今現在の薬の残数（登録した数から使用回数＆個数をもとに残数を減らしていく）

- リマインドについて
  - 通知時間<br>
    １日３回食後であれば、自分のライフスタイルに合わせて食後時間を設定し、リマインドできるようにする
  - ストック補充時期<br>
    薬が切れる前に補充できるよう、通知時期を決めることができる

- その他
  - 完了報告を通知する人（家族など）

Webアプリに登録された情報をもとに、自身のLINEに通知が来て各種リマインドをしてくれる<br>
特に薬の服用については飲んだかどうかをLINEで返信することでタスク管理し、飲み忘れを防ぐ<br>
また、利用者層は高齢者も想定しているため「１画面１アクション」となるように工夫する

## 薬を使う人が家族にいる人
薬を使う人がLINEにて「飲んだ」ことを返信しタスクを完了した際に、家族にLINEで完了報告を通知する<br>
事前に家族にもLINE連携してもらう必要があるので、薬を使う人から招待リンクを送ってもらい、<br>
そこから連携することを考えている（OAuth認証？）<br>

これにより、家族は「薬を飲んだか把握しておきたい」相手がしっかり服用出来ているかを確認できる


# ■ ユーザーの獲得について
> 想定したユーザー層に対してそれぞれどのようにサービスを届けるのか現状考えていることがあれば教えてください。

まずはRUNTEQ内で使っていただき、使用感を元に改善していきたいと考えています。<br>
また、自分だけでなく親にも使ってもらい、良ければ同世代の仲間内でも広めてもらえたらと考えています。


# ■ サービスの差別化ポイント・推しポイント
> 似たようなサービスが存在する場合、そのサービスとの明確な差別化ポイントとその差別化ポイントのどこが優れているのか教えてください。
> 独自性の強いサービスの場合、このサービスの推しとなるポイントを教えてください。

1. 家族への服用通知機能
多くの薬管理アプリは「使っている本人」に焦点を当てており、家族への通知機能を備えたものは少ないです。<br>
これにより、離れて暮らす高齢の親を持つ方や介護されている方は、服用状況を把握できるので安心感を提供できると考えています。

2. LINE連携
多くの薬管理アプリは服用情報を専用アプリで登録する必要があり、手間に感じる方もいるようです。<br>
一方今回のアプリでは服用情報をLINEで登録できるので利便性高く、利用継続率も維持できると考えています。


# ■ 機能候補
> 現状作ろうと思っている機能、案段階の機能をしっかりと固まっていなくても構わないのでMVPリリース時に作っていたいもの、本リリースまでに作っていたいものをそれぞれ分けて教えてください。

## MVPリリース時に実装しておきたい機能
- 薬の登録機能
  - 薬の名前
  - １日に飲む回数と個数<br>
    病院でもらう薬の袋に書かれているような内容を想定しています
    - 例①）１日２回（朝・昼）食前に１錠
    - 例②）１日３回（朝・昼・晩）食後に２錠
  - 今現在の薬のストック数

- 服用タスク管理機能
  - リマインドともに「飲んだかどうか」を返信するように通知<br>
    （リマインドのメッセージ内に「飲んだ」ボタンを配置し、それを押すことで返信できる想定）

- リマインド機能
  - 薬を飲む時間になったらお知らせ
  - 薬のストック時期になったらお知らせ

- 処方箋、市販薬の画像アップロード機能
  - 登録する薬について、いつでも正しい内容を確認できるよう画像も登録できる

## 本リリースまでに作っていたいもの
- 服用ログ
  - いつどの薬を飲んだかを見返せる機能

- 家族への共有機能
  - 服用者が服用タスクを完了した場合、事前に連携済みのLINEアカウントへ完了通知をする
  - 服用者の薬の登録情報を閲覧できる機能

- リマインダーのカスタマイズ
  - 飲み忘れがあった場合にリマインドできる機能
  - どのくらいの時間タスクを完了しなかったらリマインドするかを設定できる

- アップロードした画像から薬の情報を取得する機能
  - 処方箋や市販薬のパッケージからテキストを取得
  - 薬の名前っぽいものを抽出し、医薬品のデータベースなどと照合して補正
  - 最終的にユーザに確認画面を表示して修正できるようにして登録<br>
  ※処方箋は正規表現等で絞り込める想定だが、市販薬についてはまだ検討中<br>
    できる範囲で実装していきたい

- 薬情報入力時のオートコンプリート機能
  - そのユーザが以前に登録したことのある薬についてはオートコンプリート機能で表示する


# ■ 機能の実装方針予定
> 一般的なCRUD以外の実装予定の機能についてそれぞれどのようなイメージ(使用するAPIや)で実装する予定なのか現状考えているもので良いので教えて下さい。

## MVPリリース時
### ステップ形式での薬の登録
- sessionを使って各ステップで入力した値を一時保存し、最後にDBへ登録する形を想定

### 画像のアップロード
- CarrierWave 

### LINEでのリマインド通知
- LINE Messaging API
- LINE Messaging API SDK for Ruby

### LINEでのタスク完了
- LINE Messaging API

## 本リリース時
### 家族への共有機能
- LINE Messaging API
- Webhook
- OAuth認証（家族の連携）

### 画像テキスト取得機能
- Tesseract OCR
- rtesseract(Gem)
- Google Cloud Vision API(利用料金がかかるため、なるべくTesseract OCRを使う)

### オートコンプリート機能
- jQuery
- Ajax