class ContextMenu

  @localize: (defC) ->
    @updateContextMenu(defC)
    atom.menu.update()

  @updateContextMenu: (defC) ->
    for itemSet in atom.contextMenu.itemSets
      set = defC.Context[itemSet.selector]
      continue if not set
      for item in itemSet.items
        continue if item.type is "separator"
        label = set[item.command]
        item.label = label if label?

module.exports = ContextMenu
