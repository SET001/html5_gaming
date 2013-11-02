(function() {
  app.directive('game', function() {
    return {
      restrict: "E",
      link: function(self, elem, attrs, ctrl) {
        self.$parent.game = new Game(elem, self, self.params);
        return self.$parent.game.run();
        /*console.log ((new Date()).getTime() - start)/1000
        console.log "done"
        */

      }
    };
  });

}).call(this);
