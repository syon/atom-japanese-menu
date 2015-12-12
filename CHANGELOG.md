## 1.6.2
* Fix bugs  
  - [設定画面に再フォーカスした時に表示状態が維持されない · Issue #12](https://github.com/syon/atom-japanese-menu/issues/12)

## 1.6.1
* Atom v1.2.3 に対応
* Fix bugs  
  - [Atomを再起動すると設定画面が英語に戻ってしまう。 · Issue #9](https://github.com/syon/atom-japanese-menu/issues/9)
  - Linux 版の設定画面で動作しないのを修正

## 1.5.0
* Atom v1.1.0 に対応
    * 設定画面に追加された説明を日本語化

## 1.4.0
* Windows に加え Linux でも設定画面のフォントに指定したものを適用
    * フォント未指定時の自動適用はしない

## 1.3.0
* Atom v1.0.7 に対応
* Atom v1.0.4 に対応
    * 設定画面の追加項目 `editor.backUpBeforeSaving` を日本語化

## 1.2.1
* Windows のみ設定画面のフォントにエディタ設定内のフォント指定を適用
    * フォント未指定時は `font-family: 'Segoe UI', Meiryo;`

## 1.1.0
* 設定画面を日本語化

## 1.0.0
* Atom v1.0.2 に対応

## 0.7.0
* Atom v0.211.0 に対応
    * コンテキストメニューを更新

## 0.6.0
* Atom v0.196.0 に対応

## 0.5.0

#### メニューのアクセスキー対応 (linux, win32)

`Alt`キーを押しながら対応するキーを押すことでキーボードからメニューにアクセスできます。

Atom のデフォルトではテキストエディタ操作中の Keybindings に `alt-f`, `alt-h`
が割り当たっているので、__ファイル(F)__ と __ヘルプ(H)__ が呼び出せません。
利用するには Keybindings の設定画面の "your keymap file" リンクから
`keymap.cson` を開いて以下の記述を追記します。

```cson
'atom-text-editor':
  'alt-f': 'native!'
  'alt-h': 'native!'
```

## 0.4.0
* Atom v0.190.0 に対応

## 0.3.2
* ３点リーダを半角３連ピリオド ... に統一

## 0.3.1
* Mac - Update menu labels

## 0.3.0
* for Linux (Ubuntu)

## 0.2.1
* for Windows

## 0.1.0 - First Release
* for Mac
* Every feature added
* Every bug fixed
