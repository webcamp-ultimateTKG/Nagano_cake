# Nagano_cake
DMM WEBCAMPの学習コンテンツ、二ヶ月目チーム開発の課題です。
<br>
<br>
##  アプリ作成の背景
元々近隣住民が顧客だったが、昨年始めたInstagramから人気となり、全国から注文が来るようになった。 InstagramのDMやメールで通販の注文を受けていたが、情報管理が煩雑になってきたため、管理機能を含んだ通販サイトを開設しようと思い至った。
<br>
<br>
## トップ画面
**↓トップ画面**
![top](https://user-images.githubusercontent.com/93575477/150904007-ee18099c-50b4-41f2-876f-b95bca80cd27.png)
<br>
<br>
##  ER図
![ER](https://user-images.githubusercontent.com/93575477/150904315-829df852-1f83-4675-88ad-90c2987c35b8.png)
<br>
<br>
## 使い方

### アプリケーション全体
このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ bundle install
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

Railsサーバーを立ち上げます。

```
$ rails server
```

### 管理者側
管理者側を確認したい場合は、アプリケーション直下に、.envファイルを作成のうえ、
下記情報を入力してください。(seedを環境変数化しているため)
```
EMAIL=任意のメールアドレス
PASSWORD=任意のパスワード
```

上記入力が完了したら、seedファイルを読み込みます。

```
rails db:seed
```
<br>

## 使用ツール
Cloud9

<br>
## 使用技術
- Ruby 2.6.3
- Ruby on Rails 5.2.6
- Bootstrap 4.6.1
<br>
<br>
## アプリ機能一覧

### 顧客側
【会員未登録】
* サイトの閲覧
* 商品の検索
* 会員新規登録機能

【会員登録後】
* ログイン機能（メールアドレス、パスワードでログイン）
* ログアウト機能
* 退会機能
* 商品のカート追加機能
* カート内の商品の個数変更機能
* 商品購入機能
* マイページでの登録情報の変更、配送先の追加、注文履歴の確認機能

### 管理者側
* ログイン機能
* ログアウト機能
* 商品の新規登録、編集機能
* 会員の閲覧、会員情報の編集機能
* 注文履歴の閲覧、注文状況の編集機能
<br>

## メンバー
- goto0214
- wilas0o0o
- montblanc
