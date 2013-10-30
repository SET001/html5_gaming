class window.Game
  units: []
  cells: []
  config:
    width: null
    height: null

  run: ->
    # creating world
    for x in [0..@config.width]
      row = []
      for y in [0..@config.height]
        row.push new Cell @, x, y
      @cells.push row
    # spawning

    for i in [1..50]
      x = Math.floor(Math.random() * @config.width)
      y = Math.floor(Math.random() * @config.height)
      count = Math.floor(Math.random() * 999)
      types = ['Poke', 'Joe']
      type = types[Math.floor(Math.random() * types.length)]+'Unit'
      unit = new window[type](@cells[x][y], count)
      unit.init.done (unit) =>
        @units.push unit
        unit.think()

    # unit = new JoeUnit @cells[5][0]
    # unit.init.done (unit) =>
    #   @units.push unit
    #   unit.think()

  constructor: (config) ->
    _.assign @config, config

window.onload = ->
  window.game = new Game
    width: 20
    height: 20
  game.run()

  field =  new Field '#field', game
  game.field = field



  # interface
  $('#hide_grid').click ->
    field.hide_grid()
    no
  $('#show_grid').click ->
    field.show_grid()
    no
