# BookOutPut

![スクリーンショット 2020-03-12 5 46 05](https://user-images.githubusercontent.com/55213482/76595212-71cf2500-653e-11ea-8c42-c2e49e40cc54.png)

https://bookoutput.work/

本に関するクイズを作り、みんなで共有するWEBサービスです。

使い方紹介: [gif](https://twitter.com/kumackey_/status/1241634940216729600)
※ 2分半ほどの長さです。

## 動機

このアプリ作成者(私)は、読書をするのが好きです。

せっかく読書をしても、読んだままとなってしまい、その知識が定着しないのが悩みでした。

知識を定着させるには、その知識に関する問題(クイズ)を作るのが有効と言われています。しかし、本に関するクイズを作るサービスが見つかりませんでした。

このサービスは、私が作りたかったサービスです。

詳細な機能の企画に関しては、企画書をご参照ください。

[企画書](https://github.com/kumackey/book-output/wiki/Proposal)

## 要件定義

issueを用いて実装したい機能の管理を行っております。
https://github.com/kumackey/book-output/issues

今後追加したい機能に関しては【機能要件】として表示しております。

## 現在の主要機能

- 本に紐づいたクイズの作成・出題機能
- 本のお気に入り機能と、それに基づくフィード機能
- 作ったクイズのCSV出力機能

## ER図

![er_bookoutput (3)](https://user-images.githubusercontent.com/55213482/81491646-ae639680-92cb-11ea-98a3-fb8576b34483.png)

データベース設計については以下のように記事を書きました。

[クイズアプリにおけるデータベース設計のアンチパターン](https://qiita.com/kumackey/items/7ccbc949458bd0af22bd)

[GoogleBooksAPIだけで本リソースの取得をする設計を行い、失敗した話](https://qiita.com/kumackey/items/3be24f6bc5f6f66515a0)

## コードのアピールポイント

技術的な核心となっている箇所については、記事を書きました。

[【Ruby on Rails】Google Books APIを叩く際の5つのTips](https://qiita.com/kumackey/items/bd369a23360c94452d33)

[accepts_nested_attributes_forを使わずに複数リソースを同時登録する(クイズアプリを例に)](https://qiita.com/kumackey/items/b469143f1a0c4902cf4e)

## インフラ

素早くリリースが行え、継続的な改善・保守がしやすいクラウドでインフラを構築しました。
クラウドインフラとして現在のデファクトスタンダードであるAWSを選択しました。

AWS: VPC / EC2 / RDS / S3 / ElastiCache / Route53 / IAM / ACM

ファイアウォールやsshのポート番号をデフォルトからずらすなど、セキリュティには注意しました。

## 開発の流れ

基本的な開発の流れとしては以下の通りで、チーム開発を想定した流れを意識しました。

- ブランチの命名規則についてはGit flowに基づく(develop, release, feature/*)。
- issueに対応したfeatureブランチを作成し開発を進める。
- pull requestを作るとCIが起動し、完了を確認できたらdevelopにマージする。
- デプロイする際にはreleaseブランチ・タグ・pull requestを作りCIが起動、完了が確認できたらmasterにマージ。

[デプロイ手順書](https://github.com/kumackey/book-output/wiki/How-to-deploy)

## 開発環境

チーム開発での開発環境構築を想定し、Docker,docker-composeを使用いたしました。

[Dockerfile](https://github.com/kumackey/book-output/blob/develop/Dockerfile), [docker-compose.yml](https://github.com/kumackey/book-output/blob/develop/docker-compose.yml)

確認手順は以下の通りです。

$ git clone git@github.com:kumackey/book-output.git

$ docker-compose build

$ docker-compose run web rails db:create db:migrate db:seed

$ docker-compose up -d

