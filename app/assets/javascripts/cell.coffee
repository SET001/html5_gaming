class window.Cell
  @last_id: 0
  @width: 32
  @height: 32

  _field: null
  selected: no
  x: null
  y: null

  constructor: (game, x, y)->
    @id = ++Cell.last_id
    @game = game
    @x = x
    @y = y

  # cx/cy coordinates of center of te cell
  draw_selection: ->
    @game.field.grid.ctx.beginPath()
    @game.field.grid.ctx.strokeStyle = '#ff0000'
    @game.field.grid.ctx.lineWidth = 4
    @game.field.grid.ctx.rect @x*Cell.width, @y*Cell.height, Cell.width, Cell.height
    @game.field.grid.ctx.stroke()