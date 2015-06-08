{$, View} = require 'atom-space-pen-views'
{CommandRunner} = require './command-runner'

Utils = require './utils'

module.exports =
class CommandRunnerView extends View
  @content: ->
    @div class: 'inset-panel panel-bottom run-command native-key-bindings', tabindex: -1, =>
      @div class: 'panel-heading', =>
        @span 'Command: '
        @span outlet: 'header'
      @div class: 'panel-body padded results', outlet: 'resultsContainer', =>
        @pre '', outlet: 'results'

  destroy: ->
    delete @commandRunner
    @detach()

  render: (command, results) =>
    atBottom = @resultsContainer[0].scrollHeight <=
      @resultsContainer[0].scrollTop + @resultsContainer.outerHeight()

    @header.text(command)

    results = Utils.colorize(results)
    @results.html(results)

    if atom.config.get 'run-command2.snapCommandResultsToBottom'
      @resultsContainer.scrollToBottom()

  hidePanel: =>
    @bottomPane?.hide()
    @bottomPane.destroy()

  showPanel: =>
    @bottomPane ?= atom.workspace.addBottomPanel(item: this)
    @bottomPane.show()

  togglePanel: ->
    if @bottomPane?.isVisible()
      @bottomPane?.hide()
      atom.views.getView(atom.workspace).focus()
    else
      @bottomPane?.show()

  runCommand: (command, cwd)->
    if @commandRunner?
      @commandRunner.kill()
      delete @commandRunner

    @commandRunner = new CommandRunner(command, cwd, @render)
    @commandRunner.runCommand()
    @showPanel()

  reRunCommand: (e) =>
    if @commandRunner?
      @commandRunner.kill()

      @commandRunner.runCommand()
      @showPanel()
    else


  killCommand: (e) =>
    if @commandRunner?
      @commandRunner.kill()
