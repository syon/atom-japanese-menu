Menu = require './menu'
ContextMenu = require './context-menu'
SettingsView = require './settings-view'

class JapaneseMenu

  constructor: ->
    CSON = require 'cson'
    @defS = CSON.load __dirname + "/../def/settings.cson"

  activate: (state) ->
    setTimeout(@delay, 0)

  delay: () =>
    Menu.localize()
    ContextMenu.localize()
    SettingsView.localize(@defS)


module.exports = window.JapaneseMenu = new JapaneseMenu()
