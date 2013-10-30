class window.Unit
  @last_id: 0

  id: 0
  selected: no
  speed: 0
  target: null
  x: 0
  y: 0
  image: 0
  init: null

  constructor: (cell, count) ->

    @id = ++Unit.last_id
    @cell = cell
    @game = cell.game
    @speed = rand 80, 20
    @layer = @game.field.addLayer 'unit_'+@id

    @x = cell.x*Cell.width
    @y = cell.y*Cell.height

    @image = new Image()
    @image.src = @image_url

    # should be centered in cell
    deferred = new $.Deferred()
    @init = deferred.promise()
    @image.onload = =>
      if @image.width < Cell.width
        @x += Math.floor((Cell.width - @image.width) / 2)
      if @image.height < Cell.height
        @y += Math.floor((Cell.height - @image.height) / 2)
      Observer.update_moves @
      deferred.resolve @
    

  toggle_selection: ->
    @selected = !@selected

  draw: ->
    @layer.ctx.drawImage @image,
      @state*@width, @direction*@height, @width, @height,
      @x, @y, @width, @height
  redraw: ->
    @layer.ctx.clearRect @x-2, @y-2, @image.width+10, @image.height+10
    @draw()

  move_to: (cell) ->
    @target = cell
    interval = setInterval =>
      @x += @vector.x
      @y += @vector.y
      if @is_finish_move()
        clearInterval interval
        @vector = null
        @cell = _.clone @target
        @target = null
        @think()
      @redraw()
    , @speed

  move: (vector) ->
    @vector = vector
    @move_to @game.cells[@cell.x + vector.x][@cell.y + vector.y]