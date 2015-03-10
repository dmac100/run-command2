module.exports =
class Utils
  @stringIsBlank: (str)->
    !str or /^\s*$/.test str

  @colorize: (str) ->
    # Get the color code and wrap the element with the associated span
    colors =
      24: 'no-underline',
      30: 'black',
      31: 'red',
      32: 'green',
      33: 'yellow',
      34: 'blue',
      35: 'purple',
      36: 'cyan',
      37: 'white',
      39: 'default',

    str.replace /\[(\d+)m([^\[]*)/g, (match, color, string) ->
      return "<span class=\"run-command-#{colors[color]}\">#{string}</span>"
