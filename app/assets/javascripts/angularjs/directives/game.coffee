 app.directive 'game', ->
  restrict: "E"
  link: (self, elem, attrs, ctrl) ->
    # t = new Date
    # start = t.getTime()
    # console.log start

    self.$parent.game = new Game elem, self, self.params
    self.$parent.game.run()

    ###console.log ((new Date()).getTime() - start)/1000
    console.log "done"###
