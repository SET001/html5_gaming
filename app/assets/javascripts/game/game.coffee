window.rand = (max, min = 0) ->
  Math.floor(Math.random() * max) + min
class window.Game
  @things:
    stone:
      passable: no
  units: []
  cells: []
  config:
    map_width: 10
    map_height: 10
    screen_width: 20
    screen_height: 20
    units: 5
    stones: 0.1 # 0-1 number of stones where 1 mean that every cell will be a stone and .5 that only half of them

  add_thing: (thing, x, y)->
    # if !coords
    #   coords = {}
    #   coords.x = rand @config.map_width
    #   coords.y = rand @config.map_height
    @cells[x][y].put_thing thing

  add_unit: (x, y)->
    # if !coords
    #   coords = {}
    #   while yes
    #     coords.x = rand @config.map_width
    #     coords.y = rand @config.map_height
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
    cells = @config.map_width*@config.map_height
    if isNaN(@config.stones) || @config.stones>1 || @config.stones<0
      throw "config.stones should be numeric 0-1"

    if stones = cells/100*@config.stones*100
      for i in [0..stones-1]
        while yes
          x = rand @config.map_width
          y = rand @config.map_height
          break if !@cells[x][y].type
        @cells[x][y].put_thing 'stone'

    if cells is stones && @config.units
      throw 'Nowhere to spawn units. Need more passable cells!'
    # spawning units
    for i in [1..@config.units]
      while yes
        x = rand @config.map_width
        y = rand @config.map_height
        break if @cells[x][y].passable
      @add_unit x, y
    @field.draw()



  constructor: (el, scope, config) ->
    _.assign @config, config
    @scope = scope
    @field =  new Field el, @

    for x in [0..@config.map_width]
      row = []
      for y in [0..@config.map_height]
        row.push new Cell @, x, y
      @cells.push row