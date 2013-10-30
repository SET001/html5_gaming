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

  is_finish_move: ->
    switch @vector.direction
      when 0 then return @y <= @cell.y*Cell.height + Cell.height*@vector.y
      when 1 then return @x >= @cell.x*Cell.width + Cell.width*@vector.x
      when 2 then return @y >= @cell.y*Cell.height + Cell.height*@vector.y
      when 3 then return @x <= @cell.x*Cell.width + Cell.width*@vector.x

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
      @game.field.draw_unit @
      # Observer.update_moves @
    , @speed

  move: (vector) ->
    @vector = vector
    @move_to @game.cells[@cell.x + vector.x][@cell.y + vector.y]

  think: ->
    dm = [
      {x: 0, y: -1, name: 'up'}
      {x: 1, y: 0, name: 'right'}
      {x: 0, y: 1, name: 'down'}
      {x: -1, y: 0, name: 'left'}
    ]

    directions = [0..3]
    if @cell.y is 0
      directions = _.without directions, 0
    if @cell.x is @game.config.width-1
      directions = _.without directions, 1
    if @cell.y is @game.config.height-1
      directions = _.without directions, 2
    if @cell.x is 0
      directions = _.without directions, 3
    d = directions[Math.floor(Math.random() * directions.length)]
    @move _.assign dm[d], direction: d
