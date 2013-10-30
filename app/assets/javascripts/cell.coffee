class window.Cell
  @last_id: 0
  @width: 60
  @height: 60

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
    @field.ctx.beginPath()
    @_field.ctx.strokeStyle = '#ff0000'
    @_field.ctx.lineWidth = 4
    @_field.ctx.rect @x*Cell.width, @y*Cell.height, Cell.width, Cell.height
    @_field.ctx.stroke()