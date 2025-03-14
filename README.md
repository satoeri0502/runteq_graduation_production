# runteq_graduation_production
## ■詳細
RUNTEQ卒業制作

# ■サービス概要
> どんなサービスなのかを３行で説明してください。

『刀剣×学習時間計測アプリ』<br>
自身の学習した時間によって刀剣を鍛造できたり、刀剣図鑑を埋めたりすることで楽しく学習継続をサポートします。<br>
学習モチベーションが保てず勉強が続かない人に向けたアプリです。

# ■ このサービスへの思い・作りたい理由
> このサービスの題材となるものに関してのエピソードがあれば詳しく教えてください。
> このサービスを思いつくにあたって元となる思いがあれば詳しく教えてください。

現在学習時間を記録・可視化できるアプリを使っており、たまに「どのくらい勉強したかな？」と振り返ると達成感があり嬉しく感じていました。<br>
また、そのアプリを使ってから勉強に取り組むハードルが下がったようにも感じています。

一方で、ゲーム性は全くないため少し飽きを感じていたところ、友人が「学習時間によって植物を植えられる」という育成と学習時間計測を組み合わせたアプリを使っており、<br>
とても良いなと感じ、自分の好きな刀剣と組み合わせて見たい！と思ったのがそのサービスを作ろうと思ったきっかけです。

刀剣については、もともと「刀剣乱舞」というゲームが好きで、各刀剣を収集するという要素が特に好きでした。<br>
そのため、今回のサービスには自分の頑張りによって「刀剣を収集できる」という要素を入れたいと考えています。

また、頑張った結果がすぐ出ると嬉しいタイプですが、学習というのは結果がすぐは出ません。<br>
そのため、少しでも達成感を味わえるように「収集要素」で頑張った結果を反映できるようにしようと考えました。

# ■ ユーザー層について
> 決めたユーザー層についてどうしてその層を対象にしたのかそれぞれ理由を教えてください。

## ユーザー層
資格勉強をしている人

## 何故その層を対象にしたのか
資格勉強は継続することが大切ですが、なかなか難しいと感じています。

自分は運よくモチベーションを保てるアプリに出会いましたが、同じようにモチベーションを保てない方のために「勉強をゲーム感覚で楽しく続ける」ことをサポートしたいと考えたからです。

# ■サービスの利用イメージ
> ユーザーがこのサービスをどのように利用できて、それによってどんな価値を得られるかを簡単に説明してください。

- スマートフォンやWebブラウザからアクセスし、学習時間を計測

- 計測した時間の長さに応じて刀を鍛造できる
  - 鍛造のWeb上での動きの想定は以下です
    1. ユーザーは計測開始時に「どのくらい勉強するか」目標時間を設定する<br>
        　⇒設定できる時間は鍛造に必要な計測時間から選べる
    2. 設定している時間中はカウントダウンタイマーが動く<br>
        　⇒終了ボタン、一時停止ボタンが表示されている
    3. 目標時間を達成したら終了をお知らせ<br>
        以下2つの選択肢が表示される
        - 計測終了して鍛造<br>
          　⇒計測したトータル時間で鍛造<br>
            　この際、ストックした時間がある場合はそれと合算した時間で鍛造される刀種が決まる
        - 計測終了して時間をストック<br>
          　⇒鍛造はせず、計測時間をストックする
        - 同じ時間でもう一度計測<br>
          　⇒手順2から再実施
    4. 目標時間を達成する前に終了した場合<br>
        - 終了時の計測時間とストック時間を合算した結果30分未満だった場合<br>
          　⇒今回の計測時間がをストックに保存
        - 終了時の計測時間とストック時間を合算した結果30分以上だった場合<br>
          　⇒合算時間で鍛造できる刀種を鍛造<br>
          　　（もし合算結果が1時間5分等だったら脇差を鍛造して、残り時間はストック保存される）
        

- 鍛造した刀は図鑑が解放され、基本情報や逸話などを見ることができる
  - 図鑑への掲載数（最終的な目標）
    - 刀剣乱舞に実装されている117振の掲載を想定
    - 想定刀種と実装数、鍛造に必要な計測時間 ↓
      |短刀  |脇差  |打刀   |太刀  |大太刀 |槍   |薙刀  |剣   |
      |:----:|:---:|:-----:|:----:|:----:|:---:|:----:|:--:|
      |23振り|11振り|32振り |35振り|5振り  |5振り|3振り |3振り|
      |30分  |1時間 |1時間半|2時間 |2時間半|3時間|3時間半|4時間|
    - コンプリートには合計190.5時間

  - 図鑑をコンプリートした場合
    - 図鑑をコンプリートした時点で「おめでとうメッセージ」をポップアップ表示<br>
      例）RUNTEQカリキュラムにて、各カリキュラムを完了した際に出てくるポップアップのイメージ
      - SNSへのシェアボタンを設置し、周りに頑張りを共有できる
    - コンプリート後の計測
      - レベル上げ機能を実装予定なので、それで自分の刀剣の育成＆カスタマイズができる
      - 新しい刀剣が図鑑に追加された場合は、 新たに図鑑コンプに挑戦できる
        - これをコンプした際はまた別の「おめでとうメッセージ」を出す

- 計測時間は見やすく可視化され、どのくらい勉強出来たかを把握できる

上記の機能によって、ユーザーに「図鑑を埋めたい！」という気持ちを持たせ、勉強の習慣化やモチベーション維持に貢献する。<br>
また、その結果としてユーザーが取り組んでいる目標の達成にも貢献する。


# ■ ユーザーの獲得について
> 想定したユーザー層に対してそれぞれどのようにサービスを届けるのか現状考えていることがあれば教えてください。

RUNTEQ生は学習継続をされている方が多いので、その方たちに使っていただき広めて良ければと考えています。
「資格勉強している人向け！」などの文言や勉強関連のハッシュタグなどを入れて宣伝することも考えています。

# ■ サービスの差別化ポイント・推しポイント
> 似たようなサービスが存在する場合、そのサービスとの明確な差別化ポイントとその差別化ポイントのどこが優れているのか教えてください。
> 独自性の強いサービスの場合、このサービスの推しとなるポイントを教えてください。

同じようにキャラ育成と時間計測を組み合わせたアプリがあります。
そことの差別化としては、収集要素と収集要素した刀に関するプチ情報を得られる点かなと考えています。

# ■ 機能候補
> 現状作ろうと思っている機能、案段階の機能をしっかりと固まっていなくても構わないのでMVPリリース時に作っていたいもの、本リリースまでに作っていたいものをそれぞれ分けて教えてください。

## MVPリリース時に実装しておきたい機能
- 学習時間を計測する機能
  - 最初に学習する時間をセットし、カウントダウンしていく
  - 時間になったら通知でお知らせし終了

- 計測時間によって刀をランダムで鍛造する機能
  - 刀は [刀剣名刀図鑑](https://www.touken-world.jp/search-noted-sword/) を参考に、実在した、または広く逸話が残っている刀剣を実装
  - 【追記3】MVPリリース時には以下30振りを実装する予定
    |短刀  |脇差  |打刀   |太刀  |大太刀 |槍   |薙刀  |剣   |
    |:----:|:---:|:-----:|:----:|:----:|:---:|:----:|:--:|
    |10振り|5振り |5振り  |5振り |2振り  |1振り|1振り |1振り|
    |30分  |1時間 |1時間半|2時間 |2時間半|3時間|3時間半|4時間|

- 学習時間を見れる機能
  - 一週間の記録、月の記録、今までのトータル時間

- 鍛造した刀剣の情報が見れる図鑑機能
  - 刀剣名、時代、持ち主、刀種、エピソードなどを表示

- １日に１回学習リマインド通知を送る機能
  - 設定した時間になっても計測がない場合にLINEなどで通知して勉強を促す
    - 詳細はまだ調査していないので今後詰めていきたいと考えています

## 本リリースまでに作っていたいもの
- 刀剣育成機能
  - 育成機能とは何か
    - これは基本的にレベル上げ機能のことを想定しています。
    - 下記に記載したように、図鑑に載っている刀剣ではなく「刀種ごとに用意されたデフォルト刀剣を一振り選んでレベル上げしていき、各レベルに応じてカスタマイズ機能が解放されていく」ということを想定しています
  - 図鑑にあるような既存の刀剣ではなく、自分だけの刀剣を鍛造して育成する機能
  - 自作刀剣についてはレベル上げができ、一定レベルに達するとカスタマイズできる部分が増えていく
    - 柄、鍔、鞘などのデザインや色をカスタマイズできるなどを考案中<br>
    例）[Picrew](https://picrew.me/ja/) などのイラストメーカーの感じをイメージ

- 計測終了時に、継続して計測できる機能
  - 同じ時間でもう一度計測するか、計測を終了するかを選べる機能
  - 鍛造は「計測開始～終了」までのトータル時間で刀種が決まる
  - 最初から長時間設定しちゃうとモチベーションが下がる…という人向けに、短時間で区切って学習を継続できるようにしたい
    - 例）3時間設定だとハードル高いけど、30分を6回なら出来そう！と思ってもらい、できるところまで継続して「終了」した段階の時間で鍛造刀種を決定する

- SNSへのシェア機能
  - 図鑑解放率
  - 今回の計測で鍛造出来た刀剣について
  - レベルアップについて
  - 自分好みにカスタマイズした刀剣について


# ■ 機能の実装方針予定
> 一般的なCRUD以外の実装予定の機能についてそれぞれどのようなイメージ(使用するAPIや)で実装する予定なのか現状考えているもので良いので教えて下さい。

## MVPリリース時
### 通知機能(LINE通知)
- LINE Messaging API
- LINE Messaging API SDK for Ruby

### カウントダウンタイマー
- JavaScriptで実装？

### 学習時間を見れる機能
- 学習時間を棒グラフで表示
  - ChartkickというGemが使えそう

## 本リリース時
### 刀剣育成機能
- レベリング
  - レベルを記録するのでCRUD処理のR・Uに該当すると思います
- カスタマイズ
  - こちらも「どんなカスタマイズをしたかを記録」するのでR・Uに該当すると思います

### SNSへのシェア機能
- Font Awesomeを使ってアイコンを表示
- Viewにシェア用のリンクを記述