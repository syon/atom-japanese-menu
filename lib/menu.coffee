class Menu

  @localize: (defM) ->
    @updateMenu(atom.menu.template, defM.Menu)
    setTimeout(@handleReopenProjectMenu, 0)
    atom.workspace.onDidChangeActivePaneItem () =>
      @handleReopenProjectMenu()
      atom.menu.update()
    atom.menu.update()

  @updateMenu: (menuList, def) ->
    return if not def
    for menu in menuList
      continue if not menu.label
      key = menu.label
      set = def[key]
      continue if not set
      menu.label = set.value if set?
      if menu.submenu?
        @updateMenu(menu.submenu, set.submenu)

  # When another Atom window opens, Atom recreates 'Reopen Project' menu.
  # This function merges the updated menu and removes added File menu.
  @handleReopenProjectMenu: () =>
    try
      idxR = @findArrayItemByLabel(atom.menu.template, 'File')
      throw idxR unless idxR
      fileR = atom.menu.template[idxR]
      submIdxR = @findArrayItemByLabel(fileR.submenu, 'Reopen Project')
      theMenuR = fileR.submenu[submIdxR].submenu
      
      idxL = @findArrayItemByLabel(atom.menu.template, 'ファイル')
      fileL = atom.menu.template[idxL]
      submIdxL = @findArrayItemByLabel(fileL.submenu, 'プロジェクト履歴から開く')
      theMenuL = fileL.submenu[submIdxL].submenu
      
      atom.menu.template[idxL].submenu[submIdxL].submenu = theMenuL.filter (x) -> !x.commandDetail
      atom.menu.template[idxL].submenu[submIdxL].submenu.push theMenuR...
      atom.menu.template.splice(idxR, 1)
    catch e
      return

  @findArrayItemByLabel: (arr, label) ->
    for menu, i in arr
      if menu.label == label
        return i

module.exports = Menu
