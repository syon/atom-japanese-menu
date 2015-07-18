class JapaneseMenu

  constructor: ->
    CSON = require 'cson'
    @defM = CSON.load __dirname + "/../def/menu_#{process.platform}.cson"
    @defC = CSON.load __dirname + "/../def/context.cson"
    @defS = CSON.load __dirname + "/../def/settings.cson"

  activate: (state) ->
    setTimeout(@delay, 0)

  delay: () =>
    # Menu
    @updateMenu(atom.menu.template, @defM.Menu)
    atom.menu.update()

    # ContextMenu
    @updateContextMenu()

    # Settings (on init and open)
    @updateSettings()
    atom.commands.add 'atom-workspace', 'settings-view:open', =>
      @updateSettings(true)

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

  updateContextMenu: () ->
    for itemSet in atom.contextMenu.itemSets
      set = @defC.Context[itemSet.selector]
      continue if not set
      for item in itemSet.items
        continue if item.type is "separator"
        label = set[item.command]
        item.label = label if label?

  updateSettings: (onSettingsOpen = false) ->
    setTimeout(@delaySettings, 0, onSettingsOpen)

  delaySettings: (onSettingsOpen) =>
    settingsTab = document.querySelector('.tab-bar [data-type="SettingsView"]')
    settingsEnabled = settingsTab.className.includes 'active'
    return unless settingsTab && settingsEnabled
    try
      # Tab title
      settingsTab.querySelector('.title').textContent = "設定"

      # on Open
      applyOnPanel()

      # Add a event on menus which works when clicked
      panelMenus = document.querySelectorAll('.settings-view .panels-menu li')
      for panelMenu in panelMenus
        panelMenu.addEventListener("click", applyOnPanel, false)

      # Left-side menu
      menu = document.querySelector('.settings-view .panels-menu')
      return unless menu
      for d in @defS.Settings.menu
        el = menu.querySelector("[name='#{d.label}']>a")
        applyTextWithOrg el, d.value

      # Left-side button
      ext = document.querySelector('.settings-view .icon-link-external')
      applyTextWithOrg ext, "設定フォルダを開く"

    catch e
      console.error "日本語化に失敗しました。", e

  applyOnPanel = (e) ->
    activePanelName
    if e
      activePanelName = e.target.title
    else
      activePanel = document.querySelector('.panels-menu .active')
      activePanelName = activePanel.getAttribute('name')

    if activePanelName == "Settings"
      # Settings panel
      sp = document.querySelector('.settings-panel')
      for d in window.JapaneseMenu.defS.Settings.settings
        applyTextContentBySettingsId(d)

    # Every panel
    panel = document.querySelector('.panels>[style="display: block;"]')

  applyTextContentBySettingsId = (data) ->
    el = document.querySelector("[id='#{data.id}']")
    return unless el
    ctrl = el.closest('.control-group')
    applyTextWithOrg(ctrl.querySelector('.setting-title'), data.title)
    applyTextWithOrg(ctrl.querySelector('.setting-description'), data.desc)

  applyTextWithOrg = (elem, text) ->
    return unless text
    before = String(elem.textContent)
    return if before == text
    elem.textContent = text
    elem.setAttribute('title', before)

module.exports = window.JapaneseMenu = new JapaneseMenu()
