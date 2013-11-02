(function() {
  window.AppCtrl = ['$rootScope'];

  window.AppCtrl.push(function(self) {
    self.game = {};
    self.params = {};
    return self.add_unit = function() {
      var x, y;
      console.log(self.game);
      x = rand(self.game.config.map.width);
      y = rand(self.game.config.map.height);
      return self.game.add_unit(x, y);
    };
  });

}).call(this);
