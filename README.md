# BookOutPut

![スクリーンショット 2020-03-12 5 46 05](https://user-images.githubusercontent.com/55213482/76595212-71cf2500-653e-11ea-8c42-c2e49e40cc54.png)

http://bookoutput.work/

本に関するクイズを作り、みんなで共有するWEBサービスです。

## 動機

このアプリ作成者(私)は、読書をするのが好きです。

せっかく読書をしても、読んだままとなってしまい、その知識が定着しないのが悩みでした。

知識を定着させるには、その知識に関する問題(クイズ)を作るのが有効と言われています。しかし、本に関するクイズを作るサービスが見つかりませんでした。

このサービスは、私が作りたかったサービスです。

## 主要機能

- 本に紐づいたクイズの作成・出題機能
- 本のお気に入り機能と、それに基づくフィード機能
- 作ったクイズのCSV出力機能

## ER図

![bookoutput (1)](https://user-images.githubusercontent.com/55213482/76920941-18853e00-6910-11ea-8d9d-be8276037a41.png)

基本的なDB設計におけるアンチパターン・正規化などについては理解しているつもりです。

## 技術アピールポイント

#### コード関連

- Google Books APIを用いた本リソースの検索/取得
- Google Books APIの情報をオブジェクト指向により分離
- ActiveModelのmoduleをincludeしたフォームオブジェクトによる複数リソース登録
- namespaceによるマイページ機能/ルーティング
- RESTを意識したリソース/URL設計

#### gem関連

- Rubocopの静的コード解析の利用
- RSpecでのテスト(特にrequest spec)を充実
- Carrierwave, fogを用いたS3への画像アップロード
- pry, binding_of_callerを用いたデバッグ

#### その他周辺

- Git flowに基づいたbranch管理
- チーム開発を想定したissue管理、pull request
- GitHub Actionsを用いたCI(ビルド、テスト、lintチェック)
- 基本的なAWSマネージドサービスを用いたインフラ構成


#### 開発環境

チーム開発での開発環境構築を想定し、Docker,docker-composeを使用いたしました。

[Dockerfile](https://github.com/kumackey/book-output/blob/develop/Dockerfile), [docker-compose.yml](https://github.com/kumackey/book-output/blob/develop/docker-compose.yml)

確認手順は以下の通りです。

$ git clone git@github.com:kumackey/book-output.git

$ docker-compose build

$ docker-compose up

$ docker-compose run web rails db:create db:migrate db:seed


## その他情報

- Ruby 2.6.5
- Ruby on Rails 5.2.4
- MySQL 5.7 
- Redis 3.0.5

AWS: VPC / EC2 / RDS / S3 / ElastiCache / Route53 / IAM

その他: Nginx / puma 
