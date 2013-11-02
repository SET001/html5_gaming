window.AppCtrl = ['$rootScope']
window.AppCtrl.push (self) ->
  self.game = {}
  self.params = {}

  self.add_unit = ->
    console.log self.game
    x = rand self.game.config.map.width
    y = rand self.game.config.map.height
    self.game.add_unit x, y

