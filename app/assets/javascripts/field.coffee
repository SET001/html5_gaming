class window.Field
  config:
    show_grid: yes     # show grid or not
    width: null
    height: null

  selections: []  # selected cells
  el: null        # DOM element that handles field
  game: null      # game object
  vectors: []     # moving objects
  layers:
    static: null
  # deselect_cell: (cell) ->
  #   @cells[x][y].selected = no
  #   @draw()
  deselect_all: (cell) ->
    @selections = []
    @redraw_grid()

  toggle_selection: (cell) ->
    cell.selected = yes
    @selections.push cell
    @redraw_grid()

  draw: ->
    if @config.show_grid
      @show_grid()
    for row in @game.cells
      for cell in row
        if cell.type
          cell.loaded.done (cell) =>
            @layers.static.ctx.drawImage cell.image, cell.x*Cell.width, cell.y*Cell.height, Cell.width, Cell.height
 
  hide_grid: ->
    @layers.grid.ctx.clearRect 0, 0, @width, @height
    # @layers.grid.visible = no
  show_grid: ->
    ctx = @layers.grid.ctx
    ctx.beginPath()
    for x in [0..@config.width-1]
      ctx.moveTo x*Cell.width, 0
      ctx.lineTo x*Cell.width, @height
    for y in [0..@config.height-1]
      ctx.moveTo 0, y*Cell.width
      ctx.lineTo @width, y*Cell.width
    ctx.lineWidth = Config.grid.lineWidth
    ctx.strokeStyle = Config.grid.color;
    ctx.stroke()
    # @grid.visible = yes
    for cell in @selections
      @draw_selection cell
  redraw_grid: ->
    @hide_grid()
    @show_grid()

  addLayer: (id) ->
    layer = new Layer id, @width, @height
    @el.append layer.el
    layer

  constructor: (el, game, config=null) ->
    @el = $ el
    @game = game
    if !@el then throw 'Invalid elemend ID "' + el + '" provided to create field!'
    _.assign @config,
        width: game.config.width
        height: game.config.height
    if config
      _.assign @config, config

    @el.css 'width', @width = @config.width * Cell.width
    @el.css 'height', @height = @config.height * Cell.height

    @layers.static = @addLayer 'static', @width, @height
    @layers.grid = @addLayer 'grid', @width, @height

    @el.click (event) =>
      x = Math.floor event.offsetX/Cell.width
      y = Math.floor event.offsetY/Cell.height
      @deselect_all()

      @game.cells[x][y].draw_selection()