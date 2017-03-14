Menu        = require './menu'
ContextMenu = require './context-menu'
Preferences = require './preferences'

class JapaneseMenu

  pref: {done: false}

  constructor: ->
    @defM = require "../def/menu_#{process.platform}"
    @defC = require "../def/context"
    @defS = require "../def/settings"

  activate: (state) ->
    setTimeout(@delay, 0)

  delay: () =>
    Menu.localize(@defM)
    ContextMenu.localize(@defC)
    Preferences.localize(@defS)


module.exports = window.JapaneseMenu = new JapaneseMenu()
