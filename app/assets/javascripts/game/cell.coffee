class window.Cell
  @last_id: 0
  @width: 32
  @height: 32

  _field: null
  selected: no
  image: null
  loaded: no
  passable: yes
  x: null
  y: null

  put_thing: (type) ->
    @loaded = no
    @type = type
    @passable = Game.things[type].passable
    @image = new Image()
    @image.src = '/assets/' + type + '.png'

    deferred = new $.Deferred()
    @loaded = deferred.promise()
    @image.onload = =>
      @loaded = deferred.resolve @
      console.log @

  draw_selection: ->
    ctx = @game.field.layers.grid.ctx
    ctx.beginPath()
    ctx.strokeStyle = '#ff0000'
    ctx.lineWidth = 4
    ctx.rect @x*Cell.width, @y*Cell.height, Cell.width, Cell.height
    ctx.stroke()

  constructor: (game, x, y, passable = yes, type=null)->
    @passable = passable
    @id = ++Cell.last_id
    @game = game
    @x = x
    @y = y