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
