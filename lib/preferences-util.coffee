class PreferencesUtil

  @isAlreadyLocalized = (elem) ->
    localized = elem.getAttribute('data-localized') if elem
    return localized == 'true'

  @applySpecialHeading = (area, org, childIdx, text) ->
    sh = @getTextMatchElement(area, '.section-heading', org)
    return unless sh && !@isAlreadyLocalized(sh)
    sh.childNodes[childIdx].textContent = null
    span = document.createElement('span')
    span.textContent = org
    @applyTextWithOrg(span, text)
    sh.appendChild(span)

  @applyTextWithOrg = (elem, text) ->
    return unless text
    before = String(elem.textContent)
    return if before == text
    elem.textContent = text
    elem.setAttribute('title', before)
    elem.setAttribute('data-localized', 'true')

  @getTextMatchElement = (area, query, text) ->
    elems = area.querySelectorAll(query)
    result
    for el in elems
      if el.textContent.includes(text)
        result = el
        break
    return result

  @applySectionHeadings = (force) ->
    sv = document.querySelector('.settings-view')
    for sh in window.JapaneseMenu.defS.Settings.sectionHeadings
      el = @getTextMatchElement(sv, '.section-heading', sh.label)
      continue unless el
      if !@isAlreadyLocalized(el) || force
        @applyTextWithOrg(el, sh.value)
    for sh in window.JapaneseMenu.defS.Settings.subSectionHeadings
      el = @getTextMatchElement(sv, '.sub-section-heading', sh.label)
      continue unless el
      if !@isAlreadyLocalized(el) || force
        @applyTextWithOrg(el, sh.value)

  @applyButtonToolbar = () ->
    sv = document.querySelector('.settings-view')
    for btn in sv.querySelectorAll('.meta-controls .install-button')
      @applyTextWithOrg(btn, "インストール")
    for btn in sv.querySelectorAll('.meta-controls .settings')
      @applyTextWithOrg(btn, "設定")
    for btn in sv.querySelectorAll('.meta-controls .uninstall-button')
      @applyTextWithOrg(btn, "アンインストール")
    for btn in sv.querySelectorAll('.meta-controls .icon-playback-pause span')
      @applyTextWithOrg(btn, "無効にする")
    for btn in sv.querySelectorAll('.meta-controls .icon-playback-play span')
      @applyTextWithOrg(btn, "有効にする")

module.exports = PreferencesUtil
