class window.ManUnit extends Unit
  image_url: '/assets/astronaut.png'
  f: 0
  state: 1
  direction: 0
  width: 32
  height: 32
  speed: 10
  max_health: 1000
  dm:[
    {x: 0, y: 1, name: 'down'}
    {x: -1, y: 0, name: 'left'}
    {x: 1, y: 0, name: 'right'}
    {x: 0, y: -1, name: 'up'}
  ]

# ебаный ад
  random_direction: ->
    directions = [0..3]
    direction = null
    while yes
      direction = directions[rand directions.length]
      x = @cell.x + @dm[direction].x
      y = @cell.y + @dm[direction].y
      if x<0 || y<0 || x is @game.config.map_width || y is @game.config.map_height || !@game.cells[x][y].passable
        # console.log 'disgarding movement to', @dm[direction]
        directions = _.without directions, direction
        if !directions.length
          console.log 'can`t move!'
          direction = null
          break
      else break
    direction

  think: ->
    direction = @random_direction()
    if direction != null
      @move direction
    else setTimeout =>
      @think()
    , 1000

  is_finish_move: ->
    vector = @dm[@direction]
    switch @direction
      when 0 then res = @y >= @target.y*Cell.height
      when 3 then res = @y <= @target.y*Cell.height
      when 2 then res = @x >= @target.x*Cell.width
      when 1 then res = @x <= @target.x*Cell.width

  move_to: (cell) ->
    @target = cell
    interval = setInterval =>
      @x += @dm[@direction].x
      @y += @dm[@direction].y
      if ++@f > 5
        @f = 0
        if ++@state > 2
          @state = 0
      res = @is_finish_move()
      if res
        clearInterval interval
        @cell = _.clone @target
        @target = null
        @think()
      @redraw()
    , @speed