window.rand = (max) ->
  Math.floor(Math.random() * max)
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
        type = null
        if rand(10) is 1
          type = 'stone'
        row.push new Cell @, x, y, type
      @cells.push row
    # spawning units
    for i in [1..10]
      x = rand @config.width
      x =       
      y = rand @config.height
      count = rand 999
      unit = new ManUnit(@cells[x][y], count)
      unit.init.done (unit) =>
        @units.push unit
        unit.draw() 
        # unit.think()
    @field.draw()

  constructor: (config) ->
    _.assign @config, config
    @field =  new Field '#field', @

window.onload = ->
  window.game = new Game
    width: 30
    height: 25
  game.run()