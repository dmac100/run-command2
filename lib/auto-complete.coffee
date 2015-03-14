{BufferedProcess} = require 'atom'

module.exports =
class AutoComplete

  @complete: (input, cwd) ->
    @process = new BufferedProcess(@params(input, cwd))

  @params: (input = "/", cwd) ->
    command: if atom.config.get("run-command.shellCommand")? then atom.config.get("run-command.shellCommand") else '/bin/bash'
    args: ['-c', "compgen -cfd #{input}", '-il']
    options:
      cwd: cwd
