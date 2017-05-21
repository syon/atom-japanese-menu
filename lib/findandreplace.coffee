PU = require './preferences-util'

class FindAndReplace

  @localize: (defF) ->
    @defF = require "../def/findandreplace"
    # Dispatch Commands
    atom.commands.onDidDispatch (e) ->
      # find and replace package
      if e.type is "find-and-replace:toggle" or e.type is "find-and-replace:show"
        #console.log("find-and-replace:toggle")
        @fr = document.querySelector('.bottom')
        for panel in atom.workspace.getBottomPanels()
          #console.log(panel.item[0]?.className)
          if panel.item[0]?.className == 'find-and-replace' or panel.item[0]?.className == 'project-find padded'
            for sh in window.JapaneseMenu.defF.Buttons
              el = PU.getTextMatchElement(fr, 'button.btn', sh.label)
              continue unless el
              if !PU.isAlreadyLocalized(el)
                PU.applyTextWithOrg(el, sh.value)
            for sh in window.JapaneseMenu.defF.Description
              el = PU.getTextMatchElement(fr, 'span.header-item.description', sh.label)
              continue unless el
              if !PU.isAlreadyLocalized(el)
                PU.applyTextWithOrg(el, sh.value)
            for sh in window.JapaneseMenu.defF.PlaceholderText
              el = PU.getTextMatchElement(fr, 'div.placeholder-text', sh.label)
              continue unless el
              if !PU.isAlreadyLocalized(el)
                PU.applyTextWithOrg(el, sh.value)

module.exports = FindAndReplace
