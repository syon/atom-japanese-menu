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
    catch e
      console.error "日本語化に失敗しました。", e
