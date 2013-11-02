class window.Field
  config:
    show_grid: yes    # show grid or not
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
    drag_helper =
      active: no
      x: null
      y: null
    @el = el
    @game = game
    # if !@el then throw 'Invalid elemend ID "' + el + '" provided to create field!'
    _.assign @config,
        width: game.config.map.width
        height: game.config.map.height
    if config
      _.assign @config, config

    screen_width = game.config.screen.width*Cell.width
    screen_height = game.config.screen.height*Cell.height
    @width = @config.width*Cell.width
    @height = @config.height*Cell.height

    if @width<screen_width then screen_width = @width
    if @height<screen_height then screen_height = @height

    parent = $(@el.parent())
    parent.css 'width', screen_width
    parent.css 'height', screen_height

    # parent.css 'height', 

    # game.config.scren.width
    # console.log @el.parent.height game.config.scren.height

    @el.css 'width', @width = @config.width * Cell.width
    @el.css 'height', @height = @config.height * Cell.height

    @layers.static = @addLayer 'static', @width, @height
    @layers.grid = @addLayer 'grid', @width, @height

    # @el.click (event) =>
    #   x = Math.floor event.offsetX/Cell.width
    #   y = Math.floor event.offsetY/Cell.height
    #   @deselect_all()
    #   @game.cells[x][y].draw_selection()

    sx = 0
    sy = 0
    ny = 0
    nx = 0
    interval = null
    @el[0].addEventListener 'mousedown', (e) =>
      drag_helper.active = yes
      drag_helper.x = e.clientX
      drag_helper.y = e.clientY
      interval = setInterval =>
        if ny < 0 && ny > (@width-500)*(-1)
          @el.css 'top', ny
        if nx < 0 && nx > (@width-500)*(-1)
          @el.css 'left', nx
      , 1
    @el[0].addEventListener 'mouseup', =>
      drag_helper.active = no
      clearInterval interval

    @el[0].addEventListener 'mousemove', (e) =>
      if drag_helper.active
        x = e.clientX
        y = e.clientY
        sx = (drag_helper.x - x) / 20
        sy = (drag_helper.y - y) / 20
        ny = parseInt(@el.css('top')) - sy
        nx = parseInt(@el.css('left')) - sx
        
