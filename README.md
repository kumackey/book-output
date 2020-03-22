# BookOutPut

![スクリーンショット 2020-03-12 5 46 05](https://user-images.githubusercontent.com/55213482/76595212-71cf2500-653e-11ea-8c42-c2e49e40cc54.png)

http://bookoutput.work/

本に関するクイズを作り、みんなで共有するWEBサービスです。

使い方紹介: [gif](https://twitter.com/kumackey_/status/1241634940216729600)
※ 2分半ほどの長さです。

## 動機

このアプリ作成者(私)は、読書をするのが好きです。

せっかく読書をしても、読んだままとなってしまい、その知識が定着しないのが悩みでした。

知識を定着させるには、その知識に関する問題(クイズ)を作るのが有効と言われています。しかし、本に関するクイズを作るサービスが見つかりませんでした。

このサービスは、私が作りたかったサービスです。

詳細な機能の企画に関しては、以下企画書をご参照ください。

https://github.com/kumackey/book-output/wiki/Proposal

## 要件定義

issueを用いて実装したい機能の管理を行っております。

https://github.com/kumackey/book-output/issues

今後追加したい機能に関しては【機能要件】として表示しております。

## 現在の主要機能

- 本に紐づいたクイズの作成・出題機能
- 本のお気に入り機能と、それに基づくフィード機能
- 作ったクイズのCSV出力機能

## ER図

![bookoutput](https://user-images.githubusercontent.com/55213482/77245830-f881b180-6c64-11ea-8511-130f8b641da4.png)

クイズアプリにおけるデータベース設計について、以下Qiita記事を書きました。
https://qiita.com/kumackey/items/7ccbc949458bd0af22bd

## 技術アピールポイント

#### コード関連

Google Books APIを用いた本リソースの検索/取得に関して、以下Qiita記事を書きました。
https://qiita.com/kumackey/items/bd369a23360c94452d33

- ActiveModelのmoduleをincludeしたフォームオブジェクトによる複数リソース登録
- namespaceによるマイページ機能/ルーティング

#### gem関連

- Rubocopの静的コード解析の利用
- RSpecでのテスト(特にrequest spec)を充実
- Carrierwave, fogを用いたS3への画像アップロード
- pry, binding_of_callerを用いたデバッグ

#### その他周辺

- チーム開発を想定したissue管理、pull request
- GitHub Actionsを用いたCI(ビルド、テスト、lintチェック)
- 基本的なAWSマネージドサービスを用いたインフラ構成

#### 開発の流れ

基本的な開発の流れとしては以下の通りで、チーム開発を想定した流れを意識しました。

- ブランチの命名規則についてはGit flowに基づく(develop, release, feature/*)。
- issueに対応したfeatureブランチを作成し開発を進める。
- pull requestを作るとCIが起動し、完了を確認できたらdevelopにマージする。
- デプロイする際にはreleaseブランチ・タグ・pull requestを作りCIが起動、完了が確認できたらmasterにマージ。

[デプロイ手順書](https://github.com/kumackey/book-output/wiki/How-to-deploy)

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
