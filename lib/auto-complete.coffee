{BufferedProcess} = require 'atom'
Utils = require './utils'

module.exports =
class AutoComplete

  @complete: (input) ->
    @process = new BufferedProcess(@params(input))

  @params: (input = "/") ->
    command: if atom.config.get("run-command.shellCommand")? then atom.config.get("run-command.shellCommand") else '/bin/bash'
    args: ['-c', "compgen -abck #{input}", '-il']
