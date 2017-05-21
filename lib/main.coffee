Menu        = require './menu'
ContextMenu = require './context-menu'
Preferences = require './preferences'
FindAndReplace = require './findandreplace'

class JapaneseMenu

  pref: {done: false}

  constructor: ->
    @defM = require "../def/menu_#{process.platform}"
    @defC = require "../def/context"
    @defS = require "../def/settings"
    @defF = require "../def/findandreplace"

  activate: (state) ->
    setTimeout(@delay, 0)

  delay: () =>
    Menu.localize(@defM)
    ContextMenu.localize(@defC)
    Preferences.localize(@defS)
    FindAndReplace.localize(@defF)

module.exports = window.JapaneseMenu = new JapaneseMenu()
