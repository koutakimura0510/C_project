rawファイル作成手順

formerフォルダからrawフォルダに音源保存
1. audacity 実行
2. ステレオからモノラルにトラック変更
3. サンプリングレートを指定に変更
4. ファイル書き出し
5. RAWファイル(header-less)
6. Unsigned 8-bit PCM, もしくは Signed 16bit PCM


プログラムを実行してrawフォルダの音源をoutputとsdfileフォルダに保存
1. 引数にrawフォルダの形成したい音源ファイルを指定する

output ファイルに生成されるファイルは、export.c 内の count で改行される。
Zynq を使用したプロジェクトの名残。