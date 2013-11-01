window.rand = (max, min = 0) ->
  Math.floor(Math.random() * max) + min
class window.Game
  @things:
    stone:
      passable: no
  units: []
  cells: []
  config:
    map:
      width: 10
      height: 10
    screen:
      width: 2
      height: 2
    units: 1
    stones: 0 # 0-1 number of stones where 1 mean that every cell will be a stone and .5 that only half of them

  add_thing: (thing, x, y)->
    # if !coords
    #   coords = {}
    #   coords.x = rand @config.map.width
    #   coords.y = rand @config.map.height
    @cells[x][y].put_thing thing

  add_unit: (x, y)->
    # if !coords
    #   coords = {}
    #   while yes
    #     coords.x = rand @config.map.width
    #     coords.y = rand @config.map.height
    #     break if @cells[coords.x][coords.y].passable
    count = rand 999
    unit = new ManUnit(@cells[x][y], count)
    unit.init.done (unit) =>
      @units.push unit
      unit.draw() 
      unit.think()
      if @scope   # it does not defined in test environment
        @scope.$apply()
    unit.init

  run: ->
    #putting stones
    cells = @config.map.width*@config.map.height
    if isNaN(@config.stones) || @config.stones>1 || @config.stones<0
      throw "config.stones should be numeric 0-1"

    stones = cells/100*@config.stones*100
    for i in [0..stones]
      while yes
        x = rand @config.map.width
        y = rand @config.map.height
        break if !@cells[x][y].type
      @cells[x][y].put_thing 'stone'

    if cells is stones && @config.units
      throw 'Nowhere to spawn units. Need more passable cells!'
    # spawning units
    for i in [1..@config.units]
      @add_unit()
    @field.draw()



  constructor: (el, scope, config) ->
    _.assign @config, config
    @scope = scope
    @field =  new Field el, @

    for x in [0..@config.map.width]
      row = []
      for y in [0..@config.map.height]
        row.push new Cell @, x, y
      @cells.push row

window.onload = ->
  params = {}
  for pair in window.location.search.substring(1).split('&')
    param = pair.split '='
    if param[0] in ['width', 'height', 'units', 'stones'] && !isNaN(param[1])
      params[param[0]] = param[1]
  # window.game = new Game _.assign defaults, params
  # game.run()