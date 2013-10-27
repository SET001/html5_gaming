class window.Cell
  config:

  @width: 60
  @height: 60

  _field: null
  selected: no
  x: null
  y: null

  constructor: (field, x, y)->
    @_field = field
    @x = x-1
    @y = y-1
  # cx/cy coordinates of center of te cell
  cy: ->
    ((@y+1)*Cell.height-parseInt(Cell.height/2))
  cx: ->
    ((@x+1)*Cell.width-parseInt(Cell.width/2))
  ay: ->
    (@y)*Cell.height
  ax: ->
    (@x)*Cell.width
  draw_selection: ->
    @_field.ctx.beginPath()
    @_field.ctx.strokeStyle = '#ff0000'
    @_field.ctx.lineWidth = 4
    @_field.ctx.rect @x*Cell.width, @y*Cell.height, Cell.width, Cell.height
    @_field.ctx.stroke()
  
class Field
  config:
    grid: yes     # show grid or not
  cells: []
  selections: []  # selected cells
  width: 0
  height: 0
  ctx: null       # canvas content
  el: null        # DOM element that handles field
  show_grid: yes
  vectors: []     # moving objects

  deselect_cell: (cell) ->
    @cells[x][y].selected = no
    @draw()
  deselect_all_cells: (cell) ->
    @selections = []
    @redraw()
  add_selection: (cell) ->
    cell.selected = yes
    @selections.push cell
    @redraw()
  select_cells: (cells) ->
    for c in cells
      cell = @cells[c.x][c.y]
      cell.selected = yes
      @selections.push cell
    @redraw()


  update_unit: (unit) ->
    if el = $('#unit_'+unit.id)
      el.css 'top', unit._y
      el.css 'left', unit._x
  draw: ->
    @draw_grid() if @show_grid
    
    for cell in @selections
      cell.draw_selection()

    # for unit in @vectors
    #   unit.target.draw_selection()
    #   @draw_vector unit

  redraw: ->
    console.log 'redrawing'
    @ctx.clearRect 0, 0, @_w, @_h
    @draw()

  draw_grid: ->
    @ctx.beginPath()
    for cell in [0..@width-1]
      @ctx.moveTo cell*Cell.width, 0
      @ctx.lineTo cell*Cell.width, @_h
    for row in [0..@height-1]
      @ctx.moveTo 0, row*Cell.width
      @ctx.lineTo @_w, row*Cell.width
    @ctx.lineWidth = Config.grid.lineWidth
    @ctx.strokeStyle = Config.grid.color;
    @ctx.stroke()

  hide_grid: ->
    @show_grid = no
    @redraw()
  show_grid: ->
    @show_grid = yes
    @redraw()

  add_vector: (unit) ->
    @vectors.push unit
    c = 100
    rx = (unit.target.ax() - unit._x) / c
    ry = (unit.target.ay() - unit._y) / c
    vector = []
    
    x = unit._x
    y = unit._y
    for i in [1..c]
      x += rx
      y += ry
      vector.push
        x: x
        y: y

    interval = setInterval =>
      if !vector.length
        console.log 'stoped'
        clearInterval interval
        @vectors = _.reject @vectors, (el) ->
          el.id is unit.id
        unit.cell = unit.target
        unit.target = null
      else
        cords = vector.shift()
        unit._x = cords.x
        unit._y = cords.y
        @update_unit unit
    , unit.speed

    @redraw()
  draw_vector: (unit) ->
    # console.log 'darawing vector', from.cx(), from.cy(), to.cx(), to.cy()
    @ctx.beginPath()
    @ctx.moveTo unit.cell.cx(), unit.cell.cy()
    @ctx.lineTo unit.target.cx(), unit.target.cy()
    @ctx.strokeStyle = "#ff0000"
    @ctx.lineWidth = 1
    @ctx.stroke()

  constructor: (el, width, height) ->

    console.log el
    @width = width
    @height = height
    @el = el

    canvas = document.getElementById("grid")

    @_w = Cell.width*@width
    @_h = Cell.height*@height
    canvas.height = @_h
    canvas.width = @_w

    el.width @_w
    el.height @_h

    @ctx = canvas.getContext("2d")

    for x in [1..@width]
      row = []
      for y in [1..@height]
        row.push new Cell @, x, y
      @cells.push row

