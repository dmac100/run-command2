module.exports =
class Utils
  @stringIsBlank: (str)->
    !str or /^\s*$/.test str

  @colorize: (str) ->
    # Get the color code and wrap the element with the associated span
    colors =
      32: 'green',
      31: 'red',
      30: 'black',
      37: 'white'

    str.replace /\[(\d+)m\s*(\w+)/g, (match, color, string) ->
      return "<span class=\"run-command-#{colors[color]}\">#{string}</span>"
