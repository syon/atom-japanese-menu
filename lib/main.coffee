CSON         = require 'cson'
Menu         = require './menu'
ContextMenu  = require './context-menu'
SettingsView = require './settings-view'

class JapaneseMenu

  constructor: ->
    @defM = CSON.load __dirname + "/../def/menu_#{process.platform}.cson"
    @defC = CSON.load __dirname + "/../def/context.cson"
    @defS = CSON.load __dirname + "/../def/settings.cson"

  activate: (state) ->
    setTimeout(@delay, 0)

  delay: () =>
    Menu.localize(@defM)
    ContextMenu.localize(@defC)
    SettingsView.localize(@defS)


module.exports = window.JapaneseMenu = new JapaneseMenu()
