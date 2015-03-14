{BufferedProcess} = require 'atom'
Utils = require './utils'

module.exports =
class AutoComplete

  @complete: (input, cwd) ->
    @process = new BufferedProcess(@params(input, cwd))

  @params: (input = "/", cwd) ->
    command: if atom.config.get("run-command.shellCommand")? then atom.config.get("run-command.shellCommand") else '/bin/bash'
    args: ['-c', "compgen -abck #{input}", '-il']
    options:
      cwd: cwd
