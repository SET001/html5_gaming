 app.directive 'game', ->
  restrict: "E"
  scope:
    game: "="
    params: "="
  link: (self, elem, attrs, ctrl) ->
    self.game = new Game elem, self, self.params
    self.game.run()
