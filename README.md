# OrderManagement_VarWeb

受注管理システム(Web版)

受注の検索、登録、削除の3つの機能を持つ受注管理システムのWeb版。データベースとサーブレットを使っており、Webブラウザにて実行することができます。

サーブレットに関しては、MVCというアーキテクチャを採用して構築しています。Model,View,Controllerの3種類に分けることで、それぞれの責務を明確にし、開発の生産性を向上できます。また、3種類にわけることで、一番複雑なModelをいつでも読みだすことができ、また、アプリケーションの見通しも良くなります。


※開発は二人一組のチームで行いました。しかし、相方の技術不足によりほとんど私のみで開発を行いました。
ステップ数

　相方:受注検索と受注削除の3分の一ぐらい(javaとJsp,ステップ数:100以下)

　自分:受注登録と受注検索と受注削除(javaとJsp,ステップ数:1257)

　その他:データベースの作成




* カテゴリ : ツール
* プログラム内容 : 受注管理システム
* 開発期間 :2~3週間
* 互換性 : Windrow7,MacOSで動作確認済み 
* 開発環境 : Apache Tomcat,Eclipce
* 使用言語 : Java, Mysql, html, jsp


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





###反省など
当Webアプリケーションは、二人一組のチームで作業を役割分担し、開発を行いました。しかし、相方さんが授業を休むことが多々あり、相方の作業工程に支障がでていました。彼の様子を見たところ、提出期限に遅れが出る恐れがあると推測し、私は自分の作業を早めに終わらして、彼の作業を引き受けました。プログラム全体を理解し開発できたので、一貫性のあるものになったと思います。また、結合時に相方のソースコードを理解しながら構築する事もできたので、勉強になりました。

早め早めを心がけていたので、クラスで10班中3班という速さで完成できたので、よかったです。






##Install

　1.Mysqlとjava環境とApache Tomcatをインストールしておく必要があります。

　2.データベースは_orderdb_で、これをMysqlのDataファイルにダウンロード

　　また、Apache Tomcatの直下にorederwebを置く。(mac環境)

    /usr/local/apache-tomcat-8.0.29/webapps/

　3.MysqlとApache Tomcatを立ち上げておく必要があります。

　4.ブラウザで、http://localhost:8080/orderweb/primary.jspを開く
