class ContextMenu

  @localize: ->
    CSON = require 'cson'
    @defC = CSON.load __dirname + "/../def/context.cson"
    @updateContextMenu()
    atom.menu.update()

  @updateContextMenu: () ->
    for itemSet in atom.contextMenu.itemSets
      set = @defC.Context[itemSet.selector]
      continue if not set
      for item in itemSet.items
        continue if item.type is "separator"
        label = set[item.command]
        item.label = label if label?

module.exports = ContextMenu
