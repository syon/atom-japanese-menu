class JapaneseMenu

  _defM = {}
  _defC = {}
  _defS = {}

  constructor: ->
    CSON = require 'cson'
    _defM = CSON.load __dirname + "/../def/menu_#{process.platform}.cson"
    _defC = CSON.load __dirname + "/../def/context.cson"
    _defS = CSON.load __dirname + "/../def/settings.cson"

  activate: (state) ->
    setTimeout(@delay, 0)

  delay: () =>
    # Menu
    @updateMenu(atom.menu.template)
    atom.menu.update()

    # ContextMenu
    @updateContextMenu()

    # Settings (on init and open)
    @updateSettings()
    atom.commands.add 'atom-workspace', 'settings-view:open', =>
      @updateSettings(true)

  updateMenu: (menuList) ->
    return if not _defM.Menu
    for menu in menuList
      continue if not menu.label
      key = menu.label
      set = _defM.Menu[key]
      continue if not set
      menu.label = set.value if set?
      if menu.submenu?
        @updateMenu(menu.submenu, set.submenu)

  updateContextMenu: () ->
    for itemSet in atom.contextMenu.itemSets
      set = _defC.Context[itemSet.selector]
      continue if not set
      for item in itemSet.items
        continue if item.type is "separator"
        label = set[item.command]
        item.label = label if label?

  updateSettings: (onOpen = false) ->
    tab = document.querySelector('.tab-bar .active[data-type="SettingsView"]')
    if tab != null || onOpen
      setTimeout(@delaySettings, 0)
    else

  delaySettings: () ->
    try
      panel = document.querySelector('.settings-view .panels-menu')
      for d in _defS.Settings.menu
        el = panel.querySelector("[name='#{d.label}']>a")
        applyTextWithOrg el, d.value

      ext = document.querySelector('.settings-view .icon-link-external')
      applyTextWithOrg ext, "設定フォルダを開く"

      sp = document.querySelector('.settings-panel')
      for d in _defS.Settings.settings
        applyTextContentBySettingsId(d)
    catch e
      console.error "日本語化に失敗しました。", e

  applyTextContentBySettingsId = (data) ->
    el = document.querySelector("[id='#{data.id}']")
    ctrl = el.closest('.control-group')
    applyTextWithOrg(ctrl.querySelector('.setting-title'), data.title)
    applyTextWithOrg(ctrl.querySelector('.setting-description'), data.desc)

  applyTextWithOrg = (elem, text) ->
    return unless text
    before = new String(elem.textContent)
    elem.textContent = text
    elem.setAttribute('title', before)

module.exports = new JapaneseMenu()
