 app.directive 'game', ->
  restrict: "E"
  scope:
    game: "="
    params: "="
  link: (self, elem, attrs, ctrl) ->
    defaults =
      map:
        width: 20
        height: 20
      screen:
        width: 10
        height: 10
      units: 10
      stones: 4
    self.game = new Game elem, _.assign defaults, self.params
    self.game.run()
