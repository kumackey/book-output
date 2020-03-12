# BookOutPut

http://bookoutput.work/

本に関するクイズを作り、みんなで共有するWEBサービスです。

## 動機

このアプリ作成者(私)は、読書をするのが好きです。
せっかく読書をしても、読んだままとなってしまい、その知識が定着しないのが悩みでした。

知識を定着させるには、その知識に関する問題(クイズ)を作るのが有効と言われています。
しかし、本に関するクイズを作るサービスが見つかりませんでした。

このサービスは、私が作りたかったサービスです。

## 主要機能

- 本に紐づいたクイズの作成・出題機能
- 本の検索機能
- 本のお気に入り機能と、それに基づくフィード機能

## 技術アピールポイント

#### コード関連

- Google Books APIを用いた本情報の取得
- 本の検索結果をリソースとしてURL表示
- ActiveModelの関数をincludeしたForm objectによる複数リソース登録
- Ajaxによるモーダル・いいね・クイズ削除
- ActiveRecordのwhereと、SQLを組み合わせたFeed
- Fat Controllerへの警戒

#### gem関連

- Rubocopの静的コード解析の利用
- RSpecでのテスト(特にrequest spec)を充実
- Carrierwave, fogを用いたS3への画像アップロード
- slimを用いたスッキリとしたテンプレートエンジン記述
- pry, binding_of_callerを用いたデバッグ
- kaminariを用いたページネーション

#### その他周辺

- Git flowに基づいたbranch管理
- チーム開発を想定したissue管理、pull request
- Docker, docker-composeを使用した開発環境構築
- GitHub Actionsを用いたCI(ビルド、テスト、lintチェック)
- 基本的なAWSマネージドサービスを用いたインフラ構成

## その他情報

- Ruby 2.6.5
- Ruby on Rails 5.2.4
- MySQL 5.7 
- Redis 3.0.5

AWS: VPC / EC2 / RDS / S3 / Route53 / IAM
その他: Nginx / puma 

#### 確認手順

$ git clone git@github.com:kumackey/book-output.git
$ docker-compose build
$ docker-compose up
$ docker-compose run web rails db:create db:migrate db:seed
