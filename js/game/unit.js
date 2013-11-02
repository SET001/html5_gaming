(function() {
  window.Unit = (function() {
    Unit.last_id = 0;

    Unit.prototype.id = 0;

    Unit.prototype.selected = false;

    Unit.prototype.speed = 0;

    Unit.prototype.target = null;

    Unit.prototype.x = 0;

    Unit.prototype.y = 0;

    Unit.prototype.image = 0;

    Unit.prototype.init = null;

    function Unit(cell, count) {
      var deferred,
        _this = this;
      this.id = ++Unit.last_id;
      this.cell = cell;
      this.game = cell.game;
      this.speed = rand(80, 20);
      this.layer = this.game.field.addLayer('unit_' + this.id);
      this.x = cell.x * Cell.width;
      this.y = cell.y * Cell.height;
      this.image = new Image();
      this.image.src = this.image_url;
      deferred = new $.Deferred();
      this.init = deferred.promise();
      this.image.onload = function() {
        if (_this.image.width < Cell.width) {
          _this.x += Math.floor((Cell.width - _this.image.width) / 2);
        }
        if (_this.image.height < Cell.height) {
          _this.y += Math.floor((Cell.height - _this.image.height) / 2);
        }
        return deferred.resolve(_this);
      };
    }

    Unit.prototype.toggle_selection = function() {
      return this.selected = !this.selected;
    };

    Unit.prototype.draw = function() {
      return this.layer.ctx.drawImage(this.image, this.state * this.width, this.direction * this.height, this.width, this.height, this.x, this.y, this.width, this.height);
    };

    Unit.prototype.redraw = function() {
      this.layer.ctx.clearRect(this.x - 2, this.y - 2, this.image.width + 10, this.image.height + 10);
      return this.draw();
    };

    Unit.prototype.move_to = function(cell) {
      return this.target = cell;
    };

    Unit.prototype.move = function(direction) {
      this.direction = direction;
      return this.move_to(this.game.cells[this.cell.x + this.dm[this.direction].x][this.cell.y + this.dm[this.direction].y]);
    };

    return Unit;

  })();

}).call(this);
