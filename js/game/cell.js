(function() {
  window.Cell = (function() {
    Cell.last_id = 0;

    Cell.width = 32;

    Cell.height = 32;

    Cell.prototype._field = null;

    Cell.prototype.selected = false;

    Cell.prototype.image = null;

    Cell.prototype.loaded = false;

    Cell.prototype.passable = true;

    Cell.prototype.x = null;

    Cell.prototype.y = null;

    Cell.prototype.put_thing = function(type) {
      var deferred,
        _this = this;
      this.loaded = false;
      this.type = type;
      this.passable = Game.things[type].passable;
      this.image = new Image();
      this.image.src = 'images/' + type + '.png';
      deferred = new $.Deferred();
      this.loaded = deferred.promise();
      return this.image.onload = function() {
        return _this.loaded = deferred.resolve(_this);
      };
    };

    Cell.prototype.draw_selection = function() {
      var ctx;
      ctx = this.game.field.layers.grid.ctx;
      ctx.beginPath();
      ctx.strokeStyle = '#ff0000';
      ctx.lineWidth = 4;
      ctx.rect(this.x * Cell.width, this.y * Cell.height, Cell.width, Cell.height);
      return ctx.stroke();
    };

    function Cell(game, x, y, passable, type) {
      if (passable == null) {
        passable = true;
      }
      if (type == null) {
        type = null;
      }
      this.passable = passable;
      this.id = ++Cell.last_id;
      this.game = game;
      this.x = x;
      this.y = y;
    }

    return Cell;

  })();

}).call(this);
