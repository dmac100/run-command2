{SelectListView} = require 'atom-space-pen-views'

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

  viewForItem: (item) ->
    "<li>#{item}</li>"

  confirmed: (item) ->
    @selected = item
    @panel.hide()

  getEmptyMessage: () ->
    "Commands"

  autoComplete: ->
    cwd = @cwd?.cwd() || atom.project.getPaths()[0]
    @autocomplete = AC.complete(@commandEntryView.getText(), cwd)
    @autocomplete.process.stdout.on 'data', @updateCommand

  updateCommand: (output) ->
    # Get an array to populate
    output = output.toString().split("\n")
    # Remove the last empty element
    output.pop()

    # Populate the list
    console.log output
