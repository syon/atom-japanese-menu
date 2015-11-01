PU = require './preferences-util'

class PreferencesSettings

  @localize: () ->

    @defS = window.JapaneseMenu.defS.Settings
    @sv = document.querySelector('.settings-view')

    # Settings panel
    @localizeSettingsPanel()

    # Keybindings
    @localizeKeybindingsPanel()

    # Themes panel
    @localizeThemesPanel()

    # Updates panel
    @localizeUpdatesPanel()

    # Install panel
    @localizeInstallPanel()

    # Buttons
    PU.applyButtonToolbar()

  @localizeSettingsPanel: () ->
    # Notes
    for note in @defS.settings.notes
      info = @sv.querySelector("[id='#{note.id}']")
      unless PU.isAlreadyLocalized(info)
        info.innerHTML = note.html
        info.setAttribute('data-localized', 'true')

    # Every settings item
    for d in @defS.settings.controls
      applyTextContentBySettingsId(d)

  applyTextContentBySettingsId = (data) ->
    el = document.querySelector("[id='#{data.id}']")
    return unless el
    ctrl = el.closest('.control-group')
    PU.applyTextWithOrg(ctrl.querySelector('.setting-title'), data.title)
    PU.applyTextWithOrg(ctrl.querySelector('.setting-description'), data.desc)

  @localizeKeybindingsPanel: () =>
    info = @sv.querySelector('.keybinding-panel>div:nth-child(2)')
    unless PU.isAlreadyLocalized(info)
      info.querySelector('span:nth-child(2)').textContent = "これらのキーバインドは　"
      info.querySelector('span:nth-child(4)').textContent = "をクリック（コピー）して"
      info.querySelector('a.link').textContent = " キーマップファイル "
      span = document.createElement('span')
      span.textContent = "に貼り付けると上書きできます。"
      info.appendChild(span)
      info.setAttribute('data-localized', 'true')

  @localizeThemesPanel: () =>
    info = @sv.querySelector('.themes-panel>div>div:nth-child(2)')
    unless PU.isAlreadyLocalized(info)
      info.querySelector('span').textContent = "Atom は"
      info.querySelector('a.link').textContent = " スタイルシート "
      span = document.createElement('span')
      span.textContent = "を編集してスタイルを変更することもできます。"
      info.appendChild(span)
      tp1 = @sv.querySelector('.themes-picker>div:nth-child(1)')
      tp1.querySelector('.setting-title').textContent = "インターフェーステーマ"
      tp1.querySelector('.setting-description').textContent = "タブ、ステータスバー、ツリービューとドロップダウンのスタイルを変更します。"
      tp2 = @sv.querySelector('.themes-picker>div:nth-child(2)')
      tp2.querySelector('.setting-title').textContent = "シンタックステーマ"
      tp2.querySelector('.setting-description').textContent = "テキストエディタの内側のスタイルを変更します。"
      info.setAttribute('data-localized', 'true')

  @localizeUpdatesPanel: () =>
    PU.applySpecialHeading(@sv, "Available Updates", 2, "利用可能なアップデート")
    PU.applyTextWithOrg(@sv.querySelector('.update-all-button.btn-primary'), "すべてアップデート")
    PU.applyTextWithOrg(@sv.querySelector('.update-all-button:not(.btn-primary)'), "アップデートをチェック")
    PU.applyTextWithOrg(@sv.querySelector('.alert.icon-hourglass'), "アップデートを確認中...")
    PU.applyTextWithOrg(@sv.querySelector('.alert.icon-heart'), "インストールしたパッケージはすべて最新です！")

  @localizeInstallPanel: () ->
    PU.applySectionHeadings()
    inst = document.querySelector('div.section:not(.themes-panel)')
    info = inst.querySelector('.native-key-bindings')
    unless PU.isAlreadyLocalized(info)
      info.querySelector('span:nth-child(2)').textContent = "パッケージ・テーマは "
      tc = info.querySelector('span:nth-child(4)')
      tc.textContent = tc.textContent.replace("and are installed to", "に公開されており ")
      span = document.createElement('span')
      span.textContent = " にインストールされます。"
      info.appendChild(span)
      info.setAttribute('data-localized', 'true')
    PU.applyTextWithOrg(inst.querySelector('.search-container .btn:nth-child(1)'), "パッケージ")
    PU.applyTextWithOrg(inst.querySelector('.search-container .btn:nth-child(2)'), "テーマ")


module.exports = PreferencesSettings
