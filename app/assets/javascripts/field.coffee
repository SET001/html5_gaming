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
    map: null
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


  # draw_selection: (cell) ->
  #   @grid.ctx.beginPath()
  #   @grid.ctx.rect (cell.x-1)*Cell.width, (cell.y)*Cell.height, Cell.width, Cell.height
  #   @grid.ctx.lineWidth = Config.grid.selection_lineWidth
  #   @grid.ctx.strokeStyle = Config.grid.selection_color
  #   @grid.ctx.stroke()

  draw: ->
    if @config.show_grid
      @grid = @addLayer 'grid', @width, @height
      @show_grid()
 
  hide_grid: ->
    @grid.ctx.clearRect 0, 0, @width, @height
    @grid.visible = no
  show_grid: ->
    if !@grid.visible
      @grid.ctx.beginPath()
      for x in [0..@config.width-1]
        @grid.ctx.moveTo x*Cell.width, 0
        @grid.ctx.lineTo x*Cell.width, @height
      for y in [0..@config.height-1]
        @grid.ctx.moveTo 0, y*Cell.width
        @grid.ctx.lineTo @width, y*Cell.width
      @grid.ctx.lineWidth = Config.grid.lineWidth
      @grid.ctx.strokeStyle = Config.grid.color;
      @grid.ctx.stroke()
      @grid.visible = yes
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

    @layers.map = new Layer 'map', @width, @height
    @draw()

    @el.click (event) =>
      x = Math.floor event.offsetX/Cell.width
      y = Math.floor event.offsetY/Cell.height
      @deselect_all()

      @game.cells[x][y].draw_selection()