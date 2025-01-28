# Drug-Quest

## サイト概要

### サイトテーマ
ドラッグストアで起こりうるトラブルや課題を扱うクイズに回答し、回答時間の速さで自分のレベルが可視化されるサイト

### テーマを選んだ理由
前職に関連するサイトを作成したいと考えた結果、部下や後輩に教えていた内容をクイズ形式にすれば、
楽しく、学べると思い作成しました。

### ターゲットユーザ
- ドラッグストアで働こうと思う人
- ドラッグストアに興味がある人


### 主な利用シーン
- ドラッグストアに関する情報を得たいと思った時

---

## 設計書

---

## 開発環境
- **OS**: Amazon Linux 2
- **言語**: HTML, CSS, JavaScript, Ruby, SQL
- **フレームワーク**: Ruby on Rails
- **JSライブラリ**: jQuery
- **IDE**: Visual Studio Code


## クローン後から立ち上げまで
```
./setup.sh
```
上記のコマンドで
```
$ bundle install
$ yarn install
$ rails db:migrate
$ rails db:seed
```
これらがまとめて完了します。
「All tasks completed!」と表示されれば
```
rails s
```
使用可能です
