class window.ManUnit extends Unit
  image_url: '/assets/astronaut.png'
  f: 0
  state: 1
  direction: 0
  width: 32
  height: 32
  speed: 10
  max_health: 1000

  think: ->
    dm = [
      {x: 0, y: 1, name: 'down'}
      {x: -1, y: 0, name: 'left'}
      {x: 1, y: 0, name: 'right'}
      {x: 0, y: -1, name: 'up'}
    ]

    directions = [0..3]

    @direction = null
    while yes
      @direction = directions[rand directions.length]

      x = @cell.x + dm[@direction].x
      y = @cell.y + dm[@direction].y
      if x<0 || y<0 || x is @game.config.width || y is @game.config.height || !@game.cells[x][y].passable
        directions = _.without directions, @direction
        if !directions.length
          console.log 'can`t move!'
          @direction = null
          break
      else break
    if @direction != null
      @move _.assign dm[@direction], direction: @direction
    else setTimeout =>
      @think()
    , 1000

  is_finish_move: ->
    switch @vector.direction
      when 0 then return @y >= @cell.y*Cell.height + Cell.height*@vector.y
      when 3 then return @y <= @cell.y*Cell.height + Cell.height*@vector.y
      when 2 then return @x >= @cell.x*Cell.width + Cell.width*@vector.x
      when 1 then return @x <= @cell.x*Cell.width + Cell.width*@vector.x

  move_to: (cell) ->
    @target = cell
    

    interval = setInterval =>
      @x += @vector.x
      @y += @vector.y
      if ++@f > 5
        @f = 0
        if ++@state > 2
          @state = 0
      if @is_finish_move()
        clearInterval interval
        @vector = null
        @cell = _.clone @target
        @target = null
        @think()
      @redraw()
    , @speed