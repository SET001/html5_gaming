window.Observer = 
  watch_list: []
  moves: {}
  update_moves: (unit) ->
    r = @moves[unit.id]
    if r
      if (r.x != unit.id) || (r.y != unit.y)
        @moves[unit.id] = 
          x: unit.x
          y: unit.y
        @trigger unit
    else 
      @moves[unit.id] =
        x: unit.x
        y: unit.y
      @trigger unit

  watch_moves: (callback) ->
    @watch_list.push callback
  trigger: (unit) ->
    for watch in @watch_list
      watch unit