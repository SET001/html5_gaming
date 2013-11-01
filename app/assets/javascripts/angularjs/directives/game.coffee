 app.directive 'game', ->
  restrict: "E"
  scope:
    game: "="
    params: "="
  link: (self, elem, attrs, ctrl) ->
    t = new Date
    start = t.getTime()
    console.log start

    self.game = new Game elem, self, self.params
    self.game.run()

    console.log ((new Date()).getTime() - start)/1000
    console.log "done"
