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
        passable = yes
        if rand(2) is 1
          type = 'stone'
          passable = no
        row.push new Cell @, x, y, passable, type
      @cells.push row
    # spawning units

    for i in [1..10]
      while yes
        x = rand @config.width
        y = rand @config.height
        break if @cells[x][y].passable
      count = rand 999
      unit = new ManUnit(@cells[x][y], count)
      unit.init.done (unit) =>
        @units.push unit
        unit.draw() 
        unit.think()
    @field.draw()

  constructor: (config) ->
    _.assign @config, config
    @field =  new Field '#field', @

window.onload = ->
  window.game = new Game
    width: 30
    height: 25
  game.run()