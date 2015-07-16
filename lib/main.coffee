module.exports =

  activate: (state) ->
    setTimeout(@delay, 0, this)

  delay: (that) ->
    CSON = require 'cson'
    defM = CSON.load __dirname + "/../def/menu_#{process.platform}.cson"
    defC = CSON.load __dirname + "/../def/context.cson"

    # Menu
    that.updateMenu(atom.menu.template, defM.Menu)
    atom.menu.update()

    # ContextMenu
    that.updateContextMenu(defC.Context)

    # Settings (on init and open)
    that.updateSettings()
    atom.commands.add 'atom-workspace', 'settings-view:open', ->
      that.updateSettings(true)

  updateMenu: (menuList, def) ->
    return if not def
    for menu in menuList
      continue if not menu.label
      key = menu.label
      set = def[key]
      continue if not set
      menu.label = set.value if set?
      if menu.submenu?
        @updateMenu(menu.submenu, set.submenu)

  updateContextMenu: (def) ->
    for itemSet in atom.contextMenu.itemSets
      set = def[itemSet.selector]
      continue if not set
      for item in itemSet.items
        continue if item.type is "separator"
        label = set[item.command]
        item.label = label if label?

  updateSettings: (onOpen = false) ->
    tab = document.querySelector('.tab-bar .active[data-type="SettingsView"]')
    if tab != null || onOpen
      setTimeout(@delaySettings, 0, this)
    else

  delaySettings: (that) ->
    try
      panel = document.querySelector('.settings-view .panels-menu')
      data = [
        {label: "Settings", value: "設定"}
        {label: "Keybindings", value: "キーバインド"}
        {label: "Packages", value: "パッケージ"}
        {label: "Themes", value: "テーマ"}
        {label: "Updates", value: "アップデート"}
        {label: "Install", value: "インストール"}
      ]
      for d in data
        el = panel.querySelector("[name='#{d.label}']>a")
        el.text = d.value
        el.setAttribute('title', d.label)

      ext = document.querySelector('.settings-view .icon-link-external')
      before = ext['textContent']
      ext['textContent'] = "設定フォルダを開く"
      ext.setAttribute('title', before)

      data = [
        {id: 'core.audioBeep', title: "ビープ音を鳴らす"}
        {id: 'core.destroyEmptyPanes', title: "空になったペインを自動的に閉じる"}
        {id: 'core.excludeVcsIgnoredPaths', title: "バージョン管理システムによって無視されたパスを除外する"}
        {id: 'core.fileEncoding', title: "ファイルエンコーディング", desc: "ファイルを読み書きするためのデフォルトキャラクタセットを指定します。"}
        {id: 'core.followSymlinks', title: "シンボリックリンクをたどる", desc: "Fuzzy Finder でファイルを検索・開くときに使用されます。"}
        {id: 'core.ignoredNames', title: "無視するファイル"}
        {id: 'core.projectHome', title: "プロジェクトホーム"}
      ]
      sp = document.querySelector('.settings-panel')
      for d in data
        that.applyTextContentBySettingsId(that, d)
    catch e
      console.error "日本語化に失敗しました。", e

  applyTextContentBySettingsId: (that, data) ->
    el = document.querySelector("[id='#{data.id}']")
    ctrl = el.closest('.control-group')
    that.applyTextWithOrg(ctrl.querySelector('.setting-title'), data.title)
    that.applyTextWithOrg(ctrl.querySelector('.setting-description'), data.desc)

  applyTextWithOrg: (elem, text) ->
    return unless text
    before = new String(elem.textContent)
    elem.textContent = text
    elem.setAttribute('title', before)
