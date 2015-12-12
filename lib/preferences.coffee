PU = require './preferences-util'
PreferencesSettings = require './preferences-settings'

class Preferences

  @localize: (defS) ->
    @defS = defS
    @updateSettings()
    atom.workspace.onDidChangeActivePaneItem (item) =>
      if item isnt undefined
        if item.uri isnt undefined
          if item.uri.indexOf('atom://config') isnt -1
            unless window.JapaneseMenu.pref.done
              @updateSettings(true)

  @updateSettings: (onSettingsOpen = false) ->
    setTimeout(@delaySettings, 0, onSettingsOpen)

  @delaySettings: (onSettingsOpen) =>
    settingsTab = document.querySelector('.tab-bar [data-type="SettingsView"]')
    settingsEnabled = settingsTab.className.includes 'active' if settingsTab
    return unless settingsTab && settingsEnabled
    try
      # Tab title
      settingsTab.querySelector('.title').textContent = "設定"

      @sv = document.querySelector('.settings-view')

      @applyFonts()

      @loadAllSettingsPanels()

      PreferencesSettings.localize()

      @applyLeftSide()

      # Add Events
      btns = @sv.querySelectorAll('div.section:not(.themes-panel) .search-container .btn')
      for btn in btns
        btn.addEventListener('click', applyInstallPanelOnSwitch)

      window.JapaneseMenu.pref.done = true
    catch e
      console.error "日本語化に失敗しました。", e

  @applyFonts: () =>
    if process.platform == 'win32'
      font = atom.config.get('editor.fontFamily')
      if font
        @sv.style["fontFamily"] = font
      else
        @sv.style["fontFamily"] = "'Segoe UI', Meiryo"
    else if process.platform == 'linux'
      font = atom.config.get('editor.fontFamily')
      @sv.style["fontFamily"] = font
      settingsTab = document.querySelector('.tab-bar [data-type="SettingsView"]')
      settingsTab.style["fontFamily"] = font

  @loadAllSettingsPanels: () =>
    # Load all settings panels
    lastMenu = @sv.querySelector('.panels-menu .active a')
    panelMenus = @sv.querySelectorAll('.settings-view .panels-menu li a')
    for pm in panelMenus
      pm.click()
      pm.addEventListener('click', applyInstallPanelOnSwitch)
    # Restore last active menu
    lastMenu.click() if lastMenu

  @applyLeftSide: () =>
    # Left-side menu
    menu = @sv.querySelector('.settings-view .panels-menu')
    return unless menu
    for d in @defS.Settings.menu
      el = menu.querySelector("[name='#{d.label}']>a")
      PU.applyTextWithOrg el, d.value

    # Left-side button
    ext = @sv.querySelector('.settings-view .icon-link-external')
    PU.applyTextWithOrg ext, "設定フォルダを開く"

  applyInstallPanelOnSwitch = () ->
    PU.applySectionHeadings(true)
    PU.applyButtonToolbar()
    inst = document.querySelector('div.section:not(.themes-panel)')
    info = inst.querySelector('.native-key-bindings')
    info.querySelector('span:nth-child(2)').textContent = "パッケージ・テーマは "


module.exports = Preferences
