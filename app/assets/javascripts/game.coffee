window.rand = (max, min = 0) ->
  Math.floor(Math.random() * max) + min
class window.Game
  units: []
  cells: []
  config: {}

  run: ->
    t = new Date
    start = t.getTime()
    console.log start
    console.log 'Generating '+@config.map.width+'x'+@config.map.height+' world'

    # creating world

    for x in [0..@config.map.width]
      row = []
      for y in [0..@config.map.height]
        type = null
        passable = yes
        if rand(@config.stones) is 1
          type = 'stone'
          passable = no
        row.push new Cell @, x, y, passable, type
      @cells.push row
    console.log ((new Date()).getTime() - start)/1000
    console.log "done"

    # spawning units

    for i in [1..@config.units]
      while yes
        x = rand @config.map.width
        y = rand @config.map.height
        break if @cells[x][y].passable
      count = rand 999
      unit = new ManUnit(@cells[x][y], count)
      unit.init.done (unit) =>
        @units.push unit
        unit.draw() 
        unit.think()
    @field.draw()

  constructor: (el, config) ->
    console.log 'starting...', el
    _.assign @config, config
    @field =  new Field el, @

window.onload = ->
  params = {}
  for pair in window.location.search.substring(1).split('&')
    param = pair.split '='
    if param[0] in ['width', 'height', 'units', 'stones'] && !isNaN(param[1])
      params[param[0]] = param[1]
  console.log params
  # window.game = new Game _.assign defaults, params
  # game.run()