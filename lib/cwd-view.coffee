{SelectListView} = require 'atom-space-pen-views'

module.exports =
class CWDView extends SelectListView
 initialize: ->
   super
   @addClass('overlay from-top')
   @setItems(atom.project.getPaths())
   atom.workspaceView.append(this)
   @focusFilterEditor()

 viewForItem: (item) ->
   "<li>#{item}</li>"

 confirmed: (item) ->
   @selected = item
   @hide()

  cwd: ->
    @selected
