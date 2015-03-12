{SelectListView} = require 'atom-space-pen-views'

module.exports =
class CWDView extends SelectListView
 initialize: ->
   super
   @addClass('overlay from-top')
   @setItems(atom.project.getPaths())
   @panel = atom.workspace.addModalPanel(item: this)
   @focusFilterEditor()
   @panel.show()

   @on 'focusout', =>
     @panel.hide()

  viewForItem: (item) ->
    "<li>#{item}</li>"

  confirmed: (item) ->
    @selected = item
    @panel.hide()

  cwd: ->
    @selected
