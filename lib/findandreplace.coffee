PU = require './preferences-util'

class FindAndReplace

  @_targetCommands: [
    'project-find:show'
    'project-find:toggle'
    'find-and-replace:show'
    'find-and-replace:toggle'
    'find-and-replace:show-replace'
  ]

  @localize: (defF) ->
    @defF = defF
    atom.commands.onDidDispatch (e) =>
      if @_targetCommands.includes(e.type)
        try
          for panel in atom.workspace.getBottomPanels()
            switch panel.item.constructor.name
              when 'ProjectFindView' then @localizeProjectFindView(panel)
              when 'FindView' then @localizeFindView(panel)
        catch e
          console.error(e)

  @localizeProjectFindView: (panel) =>
    def = @defF.ProjectFindView
    items = panel.getItem()
    items.refs['descriptionLabel'].innerHTML = def.descriptionLabel
    items.refs['findEditor'].placeholderText = def.findEditor
    items.refs['findAllButton'].textContent = def.findAllButton
    items.refs['replaceEditor'].placeholderText = def.replaceEditor
    items.refs['replaceAllButton'].textContent = def.replaceAllButton
    items.refs['pathsEditor'].placeholderText = def.pathsEditor
    
    panelElement = document.querySelector('atom-panel > .project-find')
    @localizeOnChangeOptions(items, panelElement, def)
    opt = panelElement.querySelector('.options-label .options')
    opt.addEventListener 'DOMSubtreeModified', () =>
      @localizeOnChangeOptions(items, panelElement, def)

  @localizeFindView: (panel) =>
    def = @defF.FindView
    items = panel.getItem()
    items.refs['findEditor'].placeholderText = def.findEditor
    items.refs['nextButton'].textContent = def.nextButton
    items.refs['findAllButton'].textContent = def.findAllButton
    items.refs['replaceEditor'].placeholderText = def.replaceEditor
    items.refs['replaceNextButton'].textContent = def.replaceNextButton
    items.refs['replaceAllButton'].textContent = def.replaceAllButton
    
    panelElement = document.querySelector('atom-panel > .find-and-replace')
    @localizeOnChangeOptions(items, panelElement, def)
    opt = panelElement.querySelector('.options-label .options')
    opt.addEventListener 'DOMSubtreeModified', () =>
      @localizeOnChangeOptions(items, panelElement, def)

  @localizeOnChangeOptions: (items, panelElement, def) =>
    items.refs['descriptionLabel'].innerHTML = def.descriptionLabel
    ol = def.OptionsLabel
    optLbl = panelElement.querySelector('.options-label > span:first-child')
    optLbl.textContent = ol.Heading
    opt = panelElement.querySelector('.options-label .options')
    txt = opt.textContent
    txt = txt.replace 'Regex', ol.Regex
    txt = txt.replace 'Case Sensitive', ol.CaseSensitive
    txt = txt.replace 'Case Insensitive', ol.CaseInsensitive
    txt = txt.replace 'Within Current Selection', ol.WithinCurrentSelection
    txt = txt.replace 'Whole Word', ol.WholeWord
    opt.textContent = txt

module.exports = FindAndReplace
