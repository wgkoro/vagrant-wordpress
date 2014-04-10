vagrant-wordpress
=================

## 使い方(Mac)

### 1.VirtualBox, Vagrantのインストール

下記をそれぞれインストール

- VirtualBox <https://www.virtualbox.org/wiki/Downloads>
- Vagrant <http://www.vagrantup.com/>

### 2.Hostsの設定

ターミナルを使える方は  
$ sudo vi /etc/hosts

黒い画面が苦手な方はHosts設定ソフトを使いましょう  
<https://github.com/specialunderwear/Hosts.prefpane/downloads> (1.3をダウンロード&インストール)  
参考資料: [Macのhost編集は「Hosts」がわかりやすくて便利すぎ - にゅるり◎](http://d.hatena.ne.jp/akuyan/20130129/1359444733)

設定内容:  
config/hosts.txtの中身をそのまま設定してください。  
192.168.33.10 local.wordpress.com.local

### 3.WordPres本体の設置

WordPress一式を公式サイトから落としてきて、解凍したファイルをsourceの中に置きます。  
ディレクトリは source/wordpress/ファイル一式 となるようにしてください。

### 4.WordPress configのコピー

config/wp-config.php を3で設置したwordpressディレクトリの中にコピーしてください。  
設置は右のような構成にしてください → source/wordpress/wp-config.php

### 5.ターミナルからvagrant up

「ターミナル」を開きます。  
Finderの「アプリケーション」→「ユーティリティ」→ターミナル

ターミナルが開いたら、「cd 」と打った後に、Finderからvagrant一式ディレクトリをドラッグ&ドロップします。  
cd [Vagrant一式ファイルのパス] となったらEnterを押して移動します。

あとは vagrant up と打ち込めば起動します。

### 6.WordPressの初期設定を行う

ブラウザから <http://local.wordpress.com.local/wp-admin/install.php> へ移動し、WPの初期設定を行えば完了です。

よい開発を！
