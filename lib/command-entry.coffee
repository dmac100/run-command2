{SelectListView} = require 'atom-space-pen-views'

AC = require './auto-complete'
Utils = require './utils'

module.exports =
class CommandEntry extends SelectListView
  initialize: (CommandEntryView) ->
    super
    @addClass('overlay from-top')
    @setItems([])
    @panel = atom.workspace.addModalPanel(item: this)
    @focusFilterEditor()
    @panel.show()

    @on 'focusout', =>
      @panel.hide()

    @.on 'keydown', (e) =>
      if e.keyCode is 9
        e.preventDefault()
        @autoComplete()
      else if e.keyCode is 13
        @confirmed(@getFilterQuery())
        CommandEntryView.runCommand(@getFilterQuery())
      else if e.keyCode is 27
        @panel.hide()

  viewForItem: (item) ->
    "<li>#{item}</li>"

  confirmed: (item) ->
    @selected = item
    @panel.hide()

  getEmptyMessage: () ->
    "Commands"

  autoComplete: ->
    cwd = @cwd?.cwd() || atom.project.getPaths()[0]
    @autocomplete = AC.complete(@getFilterQuery(), cwd)
    @autocomplete.process.stdout.on 'data', @updateCommand

  updateCommand: (output) =>
    # Get an array to populate
    output = output.toString().split("\n")
    # Remove the last empty element
    output.pop()

    # Make the array unique
    output = Utils.uniq(output)

    # Populate the list
    @setItems(output)

    # Set text to largext common substring
    @filterEditorView.setText(Utils.commonPrefix(output))
