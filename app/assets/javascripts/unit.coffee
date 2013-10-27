class window.Unit
  id: 0
  type: null
  selected: no
  speed: 25
  target: null
  constructor: (type, x, y, count) ->
    @id = Math.floor((Math.random()*10000)+1)
    @type = type
    @cell = Field.cells[x][y]
    @count = count
    @_x = @cell.ax()
    @_y = @cell.ay()

  toggle_selection: ->
    @selected = !@selected

  move_to: (cell) ->
    @target = cell

  getX: ->
    @cell.x*Cell.width
  getY: ->
    @cell.y*Cell.height