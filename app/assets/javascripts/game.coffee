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
    
    # spawning units
    for i in [1..10]
      x = Math.floor(Math.random() * @config.width)
      y = Math.floor(Math.random() * @config.height)
      count = Math.floor(Math.random() * 999)
      unit = new ManUnit(@cells[x][y], count)
      unit.init.done (unit) =>
        @units.push unit
        unit.draw() 
        unit.think()

  constructor: (config) ->
    _.assign @config, config
    @field =  new Field '#field', @

window.onload = ->
  window.game = new Game
    width: 30
    height: 25
  game.run()