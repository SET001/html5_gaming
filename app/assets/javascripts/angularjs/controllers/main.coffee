window.MainCtrl = ['$rootScope', (self) ->
  
  Field.init $('.field'), Config.field.width, Config.field.height
  self.units = [
    new Unit 'macabula', 3, 3, 999
    new Unit 'spider', 1, 1, 300
    new Unit 'spider2', 7, 9, 51
    new Unit 'spider2', 2, 5, 8
  ]
  Field.draw()

  

  # self.units[1].move_to 5, 5

  self.move = (event) ->
    for unit in self.units
      x = (parseInt event.offsetX / Cell.width) 
      y = (parseInt event.offsetY / Cell.height)
      if unit.selected
        cell = Field.cells[x][y]
        if !unit.target     # if it is not mooving yet
          unit.move_to cell
          Field.add_vector unit
        else
          unit.move_to cell
          Field.redraw()
        
  self.select_unit = (unit) ->
    self.unit.toggle_selection() if self.unit

    if !self.unit || self.unit.id != unit.id
      self.unit = unit
      self.unit.toggle_selection()
]