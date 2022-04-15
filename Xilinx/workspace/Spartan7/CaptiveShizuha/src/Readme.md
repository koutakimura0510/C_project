<h1>【非接触型 FPGAゲーム】</h1>

- [1. 概要](#1-概要)
- [2. ハードウェア構成](#2-ハードウェア構成)
- [3. コーディング規則](#3-コーディング規則)
- [4. ファイル・ディレクトリ構成](#4-ファイルディレクトリ構成)
</br></br>

## 1. 概要
FPGA を搭載した自作基板を作成、機能を実装しイベントでの販売を目標としたプロジェクト。</br>
原価を抑えるため、Xilinx FPGAの中でも低機能な Spartna7 を採用する。
よくあるゲームコントローラ制御では面白みに欠けるため、ジェスチャーセンサーを使用し、非接触でゲームを遊べるようにする。</br>
<!-- ![](res/IMG_3552.jpg) -->
</br>

## 2. ハードウェア構成
<!-- ![](res/回路図.pdf) -->

## 3. コーディング規則
- parameter locparama は小文字 p, lp から開始し、なるべく詳細な命名を行う</br>
- input outputのportは小文字 i, o から開始する。</br>
- 変数のプレフィックスは、w->ネット型wire変数　q->D-FFにしないreg変数　r->D-FFにするreg変数</br>
</br>

## 4. ファイル・ディレクトリ構成
ファイル名 | 詳細
-|-
DGB | Dotデータの生成ブロック
DTB | ディプレイ信号のタイミングデータ生成ブロック
PFB | アプリケーションブロックとディスプレイブロックを接続する Async FIFO ブロック
PGB | キャラクターの座標生成ブロック
ROB | 複数のRGB値の計算を行い結果を出力するブロック
SSB | 非同期信号の外部スイッチをチャタリング除去を行いBitを取得するブロック
TGB | 取得したピクセルデータをHDMIのTMDS信号に変換して出力するブロック
CaptiveShizuhaBase | 信号が外に出ず内部で処理が完結するブロックを管理するモジュール
CaptiveShizuhaTop | プロジェクトのトップモジュール
</br>

</br>