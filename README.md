# OrderManagement_VarWeb

受注管理システム(Web版)

受注の検索、登録、削除の3つの機能を持つ基幹システムのWeb版。データベースとサーブレットを使っており、Webブラウザにて実行することができます。また、Web版はコマンドプロンプト版の応用版となっております。コマンドプロンプト版は[こちら](https://github.com/masapixyon/OrderManagement_VarCommandPrompt "")



* カテゴリ : ツール
* プログラム内容 : 基幹システム(受注管理システム)
* 互換性 : Windrow7,MacOSで動作確認済み 
* 開発環境 : MacOS,Apache Tomcat,Eclipce
* 使用言語 : Java, Mysql, html, jsp


サーブレットに関しては、MVCを意識して構築しています。また、プラグインを追加設定済みのEclipceでサーバを立ち上げており、ボタンひとつで再起動できるから、楽でいいですね。


##Demo
####受注登録

日付の登録では、登録月に存在しない日を選択された場合は、エラーにしています。

<img src="https://github.com/masapixyon/OrderManagement_VarWeb/blob/master/gif/RegistrationWeb.gif" width="700">


####受注検索削除

キーワードで検索されますが、データベースの仕様上、

キーワードに記述せずに検索を行うと、全てのデータが表示される。（使えるのでそのまま）

<img src="https://github.com/masapixyon/OrderManagement_VarWeb/blob/master/gif/SearchAndDeletionWeb.gif" width="700">


####エラー項目

５つのエラーに対応しています。

    ERROR CODE 001 : 入力された商品コードは既に選択済みです
    ERROR CODE 002 : 商品コードや数量に入力できるのは数値のみです
    ERROR CODE 003 : 商品選択確定を行うには、受注選択をする必要があります
    ERROR CODE 004 : 入力された年月日は存在しません
    ERROR CODE 005 : 検索された文字に該当する受注記録は存在しません

<img src="https://github.com/masapixyon/OrderManagement_VarWeb/blob/master/gif/Errors.gif" width="700">


##Install

　1.Mysqlとjava環境とApache Tomcatをインストールしておく必要があります。

　2.データベースは_orderdb_で、これをMysqlのDataファイルにダウンロード

　　また、Apache Tomcatの直下にorederwebを置く。(mac環境)

    /usr/local/apache-tomcat-8.0.29/webapps/

　3.MysqlとApache Tomcatを立ち上げておく必要があります。

　4.ブラウザで、http://localhost:8080/orderweb/primary.jspを開く
