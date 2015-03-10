{$, View} = require 'atom-space-pen-views'
{CommandRunner} = require './command-runner'

module.exports =
class CommandRunnerView extends View
  @content: ->
    @div class: 'inset-panel panel-bottom run-command', =>
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
    @results.text(results)

    if atBottom and atom.config.get 'run-command.snapCommandResultsToBottom'
      @resultsContainer.scrollToBottom()

  hidePanel: =>
    @bottomPane?.hide()

  showPanel: =>
    @bottomPane ?= atom.workspace.addBottomPanel(item: this)
    @bottomPane.show()

  togglePanel: =>
    if @bottomPane?.isVisible()
      @hidePanel()

  runCommand: (command)->
    if @commandRunner?
      @commandRunner.kill()
      delete @commandRunner

    @commandRunner = new CommandRunner(command, @render)
    @commandRunner.runCommand()
    @showPanel()

  reRunCommand: (e)=>
    if @commandRunner?
      @commandRunner.kill()

      @commandRunner.runCommand()
      @showPanel()
    else
      e.abortKeyBinding()

  killCommand: (e) =>
    if @commandRunner?
      @commandRunner.kill()
